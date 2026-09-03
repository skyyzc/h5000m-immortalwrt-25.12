#!/bin/sh
set -eu

lock_name="${1:-candidate}"
case "$lock_name" in candidate|stable) ;; *) echo "usage: $0 candidate|stable" >&2; exit 2;; esac

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
lock="$root/versions/$lock_name.json"
workspace="${H5000M_WORKSPACE:-$root/workspace}"
src="$workspace/immortalwrt"
python_cmd="${PYTHON:-python3}"
command -v "$python_cmd" >/dev/null || { echo "Python is required (set PYTHON if python3 is not on PATH)" >&2; exit 1; }

repo=$("$python_cmd" -c 'import json,sys; print(json.load(open(sys.argv[1]))["immortalwrt"]["repository"])' "$lock")
commit=$("$python_cmd" -c 'import json,sys; print(json.load(open(sys.argv[1]))["immortalwrt"]["commit"] or "")' "$lock")
qmodem_repo=$("$python_cmd" -c 'import json,sys; print(json.load(open(sys.argv[1]))["qmodem"]["repository"] or "")' "$lock")
qmodem_commit=$("$python_cmd" -c 'import json,sys; print(json.load(open(sys.argv[1]))["qmodem"]["commit"] or "")' "$lock")
[ -n "$commit" ] || { echo "ImmortalWrt commit is UNKNOWN in $lock" >&2; exit 1; }
[ -n "$qmodem_repo" ] && [ -n "$qmodem_commit" ] || { echo "QModem source is UNKNOWN in $lock" >&2; exit 1; }

mkdir -p "$workspace"
if [ ! -d "$src/.git" ]; then
  git clone --filter=blob:none --no-checkout "$repo" "$src"
fi
git -C "$src" remote set-url origin "$repo"
git -C "$src" fetch --depth=1 origin "$commit"
git -C "$src" checkout --detach "$commit"
test "$(git -C "$src" rev-parse HEAD)" = "$commit"

qmodem_dir="$src/feeds/qmodem"
rm -rf "$qmodem_dir"
git clone --filter=blob:none --no-checkout "$qmodem_repo" "$qmodem_dir"
git -C "$qmodem_dir" fetch --depth=1 origin "$qmodem_commit"
git -C "$qmodem_dir" checkout --detach "$qmodem_commit"
test "$(git -C "$qmodem_dir" rev-parse HEAD)" = "$qmodem_commit"
cp "$src/feeds.conf.default" "$src/feeds.conf"
printf 'src-link qmodem %s\n' "$qmodem_dir" >> "$src/feeds.conf"

# Feed SHAs are intentionally UNKNOWN in BUILD-01. Refuse a false lock instead
# of silently updating feeds to moving branch tips.
"$python_cmd" - "$lock" <<'PY'
import json, sys
d=json.load(open(sys.argv[1]))
missing=[name for name, feed in d['feeds'].items() if not feed.get('commit')]
if missing:
    raise SystemExit('Feed commits are UNKNOWN: '+', '.join(missing))
PY

"$python_cmd" - "$lock" "$src" <<'PY'
import json, os, subprocess, sys
d=json.load(open(sys.argv[1])); src=sys.argv[2]
for name, feed in d['feeds'].items():
    path=os.path.join(src,'feeds',name)
    if not os.path.isdir(os.path.join(path,'.git')):
        subprocess.check_call(['git','clone','--filter=blob:none','--no-checkout',feed['repository'],path])
    subprocess.check_call(['git','-C',path,'fetch','--depth=1','origin',feed['commit']])
    subprocess.check_call(['git','-C',path,'checkout','--detach',feed['commit']])
PY

if [ "${H5000M_PREPARE_FETCH_ONLY:-0}" = 1 ]; then
  echo "Prepared locked source checkouts without feed indexing (fetch-only mode)"
  exit 0
fi

(cd "$src" && ./scripts/feeds update -a)
"$python_cmd" - "$lock" "$src" <<'PY'
import json, os, subprocess, sys
d=json.load(open(sys.argv[1])); src=sys.argv[2]
for name, feed in d['feeds'].items():
    path=os.path.join(src,'feeds',name)
    commit=feed['commit']
    subprocess.check_call(['git','-C',path,'fetch','--depth=1','origin',commit])
    subprocess.check_call(['git','-C',path,'checkout','--detach',commit])
    actual=subprocess.check_output(['git','-C',path,'rev-parse','HEAD'],text=True).strip()
    if actual != commit: raise SystemExit(f'{name} feed mismatch: {actual}')
PY
(cd "$src" && ./scripts/feeds install -a)
echo "Prepared $src at $commit"
