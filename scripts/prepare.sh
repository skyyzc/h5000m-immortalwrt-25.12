#!/bin/sh
set -eu

lock_name="${1:-candidate}"
case "$lock_name" in candidate|stable) ;; *) echo "usage: $0 candidate|stable" >&2; exit 2;; esac

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
lock="$root/versions/$lock_name.json"
workspace="${H5000M_WORKSPACE:-$root/workspace}"
src="$workspace/immortalwrt"
command -v python3 >/dev/null || { echo "python3 is required" >&2; exit 1; }

repo=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["immortalwrt"]["repository"])' "$lock")
commit=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["immortalwrt"]["commit"] or "")' "$lock")
[ -n "$commit" ] || { echo "ImmortalWrt commit is UNKNOWN in $lock" >&2; exit 1; }

mkdir -p "$workspace"
if [ ! -d "$src/.git" ]; then
  git clone --filter=blob:none --no-checkout "$repo" "$src"
fi
git -C "$src" remote set-url origin "$repo"
git -C "$src" fetch --depth=1 origin "$commit"
git -C "$src" checkout --detach "$commit"
test "$(git -C "$src" rev-parse HEAD)" = "$commit"

# Feed SHAs are intentionally UNKNOWN in BUILD-01. Refuse a false lock instead
# of silently updating feeds to moving branch tips.
python3 - "$lock" <<'PY'
import json, sys
d=json.load(open(sys.argv[1]))
missing=[name for name, feed in d['feeds'].items() if not feed.get('commit')]
if missing:
    raise SystemExit('Feed commits are UNKNOWN: '+', '.join(missing))
PY

(cd "$src" && ./scripts/feeds update -a)
python3 - "$lock" "$src" <<'PY'
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
