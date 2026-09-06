#!/bin/sh
set -eu

lock_name=${1:-candidate}
root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src=${H5000M_SOURCE:-$root/workspace/immortalwrt}
lock=$root/versions/$lock_name.json
python_cmd=${PYTHON:-python3}
cache=$src/.h5000m-full-sources
destination=$src/package/h5000m-full

[ -d "$src" ] || { echo "source tree not found: $src" >&2; exit 1; }
[ -f "$lock" ] || { echo "source lock not found: $lock" >&2; exit 1; }
mkdir -p "$cache" "$destination"

"$python_cmd" - "$lock" <<'PY' | while IFS='|' read -r name repository commit package_paths; do
import json, sys
d=json.load(open(sys.argv[1]))
for name, source in d.get('full_sources', {}).items():
    print('|'.join((name, source['repository'], source['commit'], ','.join(source['package_paths']))))
PY
  checkout=$cache/$name
  if [ ! -d "$checkout/.git" ]; then
    git clone --filter=blob:none --no-checkout "$repository" "$checkout"
  fi
  git -C "$checkout" remote set-url origin "$repository"
  git -C "$checkout" fetch --depth=1 origin "$commit"
  git -C "$checkout" checkout --detach --force "$commit"
  [ "$(git -C "$checkout" rev-parse HEAD)" = "$commit" ] || {
    echo "FULL_SOURCE_GATE FAIL: $name identity mismatch" >&2; exit 1;
  }
  old_ifs=$IFS; IFS=,
  for package_path in $package_paths; do
    IFS=$old_ifs
    [ -f "$checkout/$package_path/Makefile" ] || {
      echo "FULL_SOURCE_GATE FAIL: $name missing package $package_path" >&2; exit 1;
    }
    target=$destination/$(basename "$package_path")
    rm -rf "$target"
    cp -a "$checkout/$package_path" "$target"
    IFS=,
  done
  IFS=$old_ifs
  echo "FULL_SOURCE_GATE PASS: $name@$commit"
done

[ -f "$destination/wrtbwmon/net/etc/init.d/wrtbwmon" ] || {
  echo 'FULL_SOURCE_GATE FAIL: wrtbwmon install tree missing' >&2; exit 1;
}
"$python_cmd" "$root/scripts/patch-full-sources.py" "$src" "$destination"
echo 'FULL_SOURCE_GATE PASS: locked Full sources installed and compatibility patches applied'
