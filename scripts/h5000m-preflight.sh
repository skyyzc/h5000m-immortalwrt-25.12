#!/bin/sh
set -eu

profile=${1:-both}
lock_name=${2:-candidate}
root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src=${H5000M_SOURCE:-$root/workspace/immortalwrt}
python_cmd=${PYTHON:-python3}
case "$profile" in rescue|full|both) ;; *) echo 'profile must be rescue, full or both' >&2; exit 2;; esac

"$python_cmd" - "$root/versions/$lock_name.json" <<'PY'
import json, sys
d=json.load(open(sys.argv[1]))
required=('immortalwrt','feeds','qmodem')
for key in required:
    if key not in d: raise SystemExit(f'PREFLIGHT FAIL: missing lock {key}')
for name, source in d.get('full_sources', {}).items():
    if source.get('status') != 'CONFIRMED' or len(source.get('commit','')) != 40:
        raise SystemExit(f'PREFLIGHT FAIL: incomplete Full source lock {name}')
print('PREFLIGHT PASS: source lock schema and Full source identities')
PY

# Full must contain the complete Rescue request set; comments and signatures are
# intentionally ignored, package/target selections are not.
if [ "$profile" = full ] || [ "$profile" = both ]; then
  sed -n '/^CONFIG_/p;/^# CONFIG_.* is not set$/p' "$root/configs/rescue.config" | sort >"${TMPDIR:-/tmp}/h5000m-rescue.$$"
  sed -n '/^CONFIG_/p;/^# CONFIG_.* is not set$/p' "$root/configs/full.config" | sort >"${TMPDIR:-/tmp}/h5000m-full.$$"
  trap 'rm -f "${TMPDIR:-/tmp}/h5000m-rescue.$$" "${TMPDIR:-/tmp}/h5000m-full.$$"' EXIT HUP INT TERM
  missing=$(comm -23 "${TMPDIR:-/tmp}/h5000m-rescue.$$" "${TMPDIR:-/tmp}/h5000m-full.$$")
  [ -z "$missing" ] || { echo "PREFLIGHT FAIL: Full omits Rescue selections:" >&2; echo "$missing" >&2; exit 1; }
  echo 'PREFLIGHT PASS: Full is a strict superset of Core Rescue'
fi

# These two locations are shell contracts by definition.  Validate every file
# so a missing or damaged shebang cannot silently bypass the gate.
for script in "$root"/scripts/*.sh "$root"/package/hiveton/*/files/etc/init.d/*; do
  [ -f "$script" ] || continue
  sh -n "$script"
done

# Package bin/libexec directories may also contain native executables (Higo's
# higorosd is an AArch64 ELF).  Validate only payloads that explicitly declare
# a shell interpreter; feeding arbitrary executables to `sh -n` caused both
# Run 25 profiles to fail before config resolution or compilation.
for payload in "$root"/package/hiveton/*/files/usr/bin/* "$root"/package/hiveton/*/files/usr/libexec/*; do
  [ -f "$payload" ] || continue
  [ "$(dd if="$payload" bs=2 count=1 2>/dev/null)" = '#!' ] || continue
  first_line=$(LC_ALL=C sed -n '1p' "$payload")
  case "$first_line" in
    *sh*) sh -n "$payload" ;;
  esac
done
echo 'PREFLIGHT PASS: declared project shell payload syntax'
"$python_cmd" "$root/tests/test-higo-cpe-normalization.py"
H5000M_SOURCE="$src" "$root/scripts/validate-ipv6-route.sh"

if [ "$profile" = full ] || [ "$profile" = both ]; then
  "$root/scripts/validate-full-integration.sh" "$lock_name"
fi
echo "H5000M_PREFLIGHT PASS: profile=$profile lock=$lock_name"
