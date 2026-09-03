#!/bin/sh
set -eu
root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src=${H5000M_SOURCE:-$root/workspace/immortalwrt}
feed="$src/feeds/qmodem"
lock=${1:-candidate}
python_cmd=${PYTHON:-python3}
"$python_cmd" - "$root/versions/$lock.json" "$feed" <<'PY'
import json, os, re, subprocess, sys
lock=json.load(open(sys.argv[1])); feed=sys.argv[2]
actual=subprocess.check_output(['git','-C',feed,'rev-parse','HEAD'],text=True).strip()
expected=lock['qmodem']['commit']
if actual != expected: raise SystemExit(f'RG520_GATE FAIL: source expected={expected} actual={actual}')
checks={
 'RG520 USB 2c7c:0801':('driver/quectel_QMI_WWAN/src/qmi_wwan_q.c',r'0x2C7C, 0x0801'),
 'QMAP':('driver/quectel_QMI_WWAN/src/qmi_wwan_q.c',r'QMAP'),
 'Linux 6.x compatibility':('driver/quectel_QMI_WWAN/src/qmi_wwan_q.c',r'KERNEL_VERSION\(6,'),
 'QModem 3.2.0':('version.mk',r'QMODEM_VERSION:=3\.2\.0'),
}
for label,(rel,pattern) in checks.items():
    text=open(os.path.join(feed,rel),encoding='utf-8',errors='ignore').read()
    if not re.search(pattern,text,re.I): raise SystemExit('RG520_GATE FAIL: '+label)
    print('RG520_GATE PASS: '+label)
print('RG520_GATE PASS: qmi_wwan_q 1.5-r1 and QModem source locked at '+actual)
PY

for file in \
  "$root/package/hiveton/higoros/files/etc/uci-defaults/96-h5000m-qmodem-redial" \
  "$root/package/hiveton/higoros/files/etc/uci-defaults/99-h5000m-qmodem"; do
  [ -f "$file" ] || { echo "RG520_GATE FAIL: missing $file" >&2; exit 1; }
done
grep -Eq 'wwan0(_1)?' "$root/package/hiveton/higoros/files/etc/uci-defaults/99-h5000m-qmodem" || {
  echo 'RG520_GATE FAIL: fixed wwan profile missing' >&2; exit 1;
}
grep -q 'ttyUSB3' "$root/package/hiveton/higoros/files/etc/uci-defaults/99-h5000m-qmodem" || {
  echo 'RG520_GATE FAIL: ttyUSB3 management configuration missing' >&2; exit 1;
}
echo 'RG520_GATE PASS: fixed profile and redial protection present (STATIC/BUILD ONLY)'
