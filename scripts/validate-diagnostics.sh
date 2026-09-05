#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src=${H5000M_SOURCE:-$root/workspace/immortalwrt}
lock=${1:-candidate}
python_cmd=${PYTHON:-python3}
makefile="$src/package/network/utils/tcpdump/Makefile"
libpcap_makefile="$src/package/libs/libpcap/Makefile"

[ -f "$makefile" ] || { echo "DIAGNOSTICS_GATE FAIL: missing locked tcpdump Makefile" >&2; exit 1; }
[ -f "$libpcap_makefile" ] || { echo "DIAGNOSTICS_GATE FAIL: missing locked libpcap Makefile" >&2; exit 1; }
"$python_cmd" - "$root/versions/$lock.json" "$makefile" "$libpcap_makefile" <<'PY'
import json, re, sys
lock=json.load(open(sys.argv[1]))
text=open(sys.argv[2],encoding='utf-8').read()
libpcap_text=open(sys.argv[3],encoding='utf-8').read()
expected=lock['diagnostics']['ipv6_packet_tool']
checks={
    'package': r'define Package/tcpdump-mini',
    'version': rf'PKG_VERSION:={re.escape(expected["version"])}',
    'release': rf'PKG_RELEASE:={re.escape(str(expected["release"]))}',
    'source hash': rf'PKG_HASH:={re.escape(expected["source_sha256"])}',
    'libpcap dependency': r'DEPENDS:=\+libpcap',
}
for label, pattern in checks.items():
    if not re.search(pattern,text): raise SystemExit('DIAGNOSTICS_GATE FAIL: '+label)
    print('DIAGNOSTICS_GATE PASS: '+label)
dependency=expected['dependency']
dependency_checks={
    'libpcap version': rf'PKG_VERSION:={re.escape(dependency["version"])}',
    'libpcap release': rf'PKG_RELEASE:={re.escape(str(dependency["release"]))}',
    'libpcap source hash': rf'PKG_HASH:={re.escape(dependency["source_sha256"])}',
}
for label, pattern in dependency_checks.items():
    if not re.search(pattern,libpcap_text): raise SystemExit('DIAGNOSTICS_GATE FAIL: '+label)
    print('DIAGNOSTICS_GATE PASS: '+label)
PY

if grep -R -n 'tcpdump' "$root/package" "$root/files" 2>/dev/null; then
  echo 'DIAGNOSTICS_GATE FAIL: tcpdump must not auto-run from project runtime files' >&2
  exit 1
fi
echo 'DIAGNOSTICS_GATE PASS: tcpdump-mini is manual-only; no project boot hook'
