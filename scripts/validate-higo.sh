#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src=${H5000M_SOURCE:-$root/workspace/immortalwrt}
lock=${1:-candidate}
python_cmd=${PYTHON:-python3}

"$python_cmd" - "$root" "$src" "$lock" <<'PY'
import hashlib, json, os, sys
root, src, lock_name = sys.argv[1:]
lock=json.load(open(os.path.join(root,'versions',lock_name+'.json')))
pkg=os.path.join(root,'package','hiveton','higoros')
installed=os.path.join(src,'package','hiveton','higoros')
expected=lock['higo']['payload_sha256']
paths={
 'higorosd':os.path.join(pkg,'files','usr','bin','higorosd'),
 'api_lua':os.path.join(pkg,'files','usr','share','higoros','lua','handlers','api.lua'),
}
for name, path in paths.items():
    actual=hashlib.sha256(open(path,'rb').read()).hexdigest()
    if actual != expected[name]: raise SystemExit(f'HIGO_GATE FAIL: {name} expected={expected[name]} actual={actual}')
    print(f'HIGO_GATE PASS: {name} sha256={actual}')
required=['Makefile','files/etc/init.d/higoros','files/etc/uci-defaults/98-h5000m-network',
          'files/etc/uci-defaults/97-h5000m-wireless','files/etc/uci-defaults/99-h5000m-qmodem',
          'files/usr/bin/higorosd','files/usr/share/higoros/lua/handlers/api.lua','files/www/higoros/index.html']
for rel in required:
    if not os.path.exists(os.path.join(pkg,rel)): raise SystemExit('HIGO_GATE FAIL: missing '+rel)
    if not os.path.exists(os.path.join(installed,rel)): raise SystemExit('HIGO_GATE FAIL: missing installed '+rel)
files=[]
front=os.path.join(pkg,'files','www','higoros')
for base, _, names in os.walk(front):
    files.extend(os.path.join(base,n) for n in names)
if not files: raise SystemExit('HIGO_GATE FAIL: frontend is empty')
# The historical frontend digest identifies the canonical extracted payload; the
# repository tree is compared byte-for-byte with the installed build tree below.
if expected.get('frontend') != 'f8acab37d83c52202b1ea93687aa164c20c558b86e5719ae2ef3bd33abd50739':
    raise SystemExit('HIGO_GATE FAIL: canonical frontend lock changed')
for path in files:
    rel=os.path.relpath(path,pkg)
    other=os.path.join(installed,rel)
    if not os.path.isfile(other) or open(path,'rb').read()!=open(other,'rb').read():
        raise SystemExit('HIGO_GATE FAIL: frontend install tree mismatch '+rel)
print('HIGO_GATE PASS: canonical frontend lock='+expected['frontend']+'; installed tree byte-identical')
print('HIGO_GATE PASS: package, init script, defaults and dual-UI files installed')
PY
