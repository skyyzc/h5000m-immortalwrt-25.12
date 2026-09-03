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

# Refuse a false lock instead of silently updating feeds to moving branch tips.
"$python_cmd" - "$lock" <<'PY'
import json, sys
d=json.load(open(sys.argv[1]))
missing=[name for name, feed in d['feeds'].items() if not feed.get('commit')]
if missing:
    raise SystemExit('Feed commits are UNKNOWN: '+', '.join(missing))
PY

"$python_cmd" - "$lock" "$src/feeds.conf" <<'PY'
import json, sys
d=json.load(open(sys.argv[1]))
with open(sys.argv[2], 'w', newline='\n') as out:
    for name, feed in d['feeds'].items():
        out.write(f"src-git {name} {feed['repository']}^{feed['commit']}\n")
    q=d['qmodem']
    out.write(f"src-git qmodem {q['repository']}^{q['commit']}\n")
PY

if [ "${H5000M_PREPARE_FETCH_ONLY:-0}" = 1 ]; then
  "$python_cmd" - "$lock" "$src" <<'PY'
import json, os, subprocess, sys
d=json.load(open(sys.argv[1])); src=sys.argv[2]
sources=dict(d['feeds'])
sources['qmodem']={'repository':d['qmodem']['repository'],'commit':d['qmodem']['commit']}
for name, feed in sources.items():
    path=os.path.join(src,'feeds',name)
    if not os.path.isdir(os.path.join(path,'.git')):
        subprocess.check_call(['git','clone','--filter=blob:none','--no-checkout',feed['repository'],path])
    subprocess.check_call(['git','-C',path,'fetch','--depth=1','origin',feed['commit']])
    subprocess.check_call(['git','-C',path,'checkout','--detach',feed['commit']])
PY
  echo "Prepared locked source checkouts without feed indexing (fetch-only mode)"
  exit 0
fi

(cd "$src" && ./scripts/feeds update -a)
"$python_cmd" - "$lock" "$src" <<'PY'
import json, os, subprocess, sys
d=json.load(open(sys.argv[1])); src=sys.argv[2]
sources=dict(d['feeds'])
sources['qmodem']={'commit':d['qmodem']['commit']}
for name, feed in sources.items():
    path=os.path.join(src,'feeds',name)
    commit=feed['commit']
    actual=subprocess.check_output(['git','-C',path,'rev-parse','HEAD'],text=True).strip()
    if actual != commit: raise SystemExit(f'{name} feed mismatch: {actual}')
PY
(cd "$src" && ./scripts/feeds install -a)
echo "Prepared $src at $commit"
