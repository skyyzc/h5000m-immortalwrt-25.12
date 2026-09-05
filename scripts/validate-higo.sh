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
runtime_patch=lock['higo']['runtime_patch']
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
if expected.get('frontend') != 'f8acab37d83c52202b1ea93687aa164c20c558b86e5719ae2ef3bd33abd50739':
    raise SystemExit('HIGO_GATE FAIL: canonical frontend lock changed')
tree=hashlib.sha256()
for path in sorted(files,key=lambda p:os.path.relpath(p,front).replace(os.sep,'/')):
    tree.update(os.path.relpath(path,front).replace(os.sep,'/').encode('utf-8')+b'\0')
    tree.update(open(path,'rb').read())
actual_tree=tree.hexdigest()
if actual_tree != expected.get('frontend_tree_sha256'):
    raise SystemExit(f'HIGO_GATE FAIL: frontend tree expected={expected.get("frontend_tree_sha256")} actual={actual_tree}')
patch_path=os.path.join(root,runtime_patch['path'])
patch_sha=hashlib.sha256(open(patch_path,'rb').read()).hexdigest()
if patch_sha != runtime_patch['sha256']:
    raise SystemExit(f'HIGO_GATE FAIL: runtime patch expected={runtime_patch["sha256"]} actual={patch_sha}')
patched_rel='files/www/higoros/'+runtime_patch['patched_asset']
differences=[]
for path in files:
    rel=os.path.relpath(path,pkg).replace(os.sep,'/')
    other=os.path.join(installed,rel)
    if not os.path.isfile(other): raise SystemExit('HIGO_GATE FAIL: missing installed '+rel)
    if open(path,'rb').read()!=open(other,'rb').read(): differences.append(rel)
if differences != [patched_rel]:
    raise SystemExit(f'HIGO_GATE FAIL: unexpected runtime differences {differences}')
patched_asset=os.path.join(installed,patched_rel)
patched_asset_sha=hashlib.sha256(open(patched_asset,'rb').read()).hexdigest()
if patched_asset_sha != runtime_patch['patched_asset_sha256']:
    raise SystemExit(f'HIGO_GATE FAIL: patched asset expected={runtime_patch["patched_asset_sha256"]} actual={patched_asset_sha}')
installed_files=[]
installed_front=os.path.join(installed,'files','www','higoros')
for base, _, names in os.walk(installed_front):
    installed_files.extend(os.path.join(base,n) for n in names)
runtime_tree=hashlib.sha256()
for path in sorted(installed_files,key=lambda p:os.path.relpath(p,installed_front).replace(os.sep,'/')):
    runtime_tree.update(os.path.relpath(path,installed_front).replace(os.sep,'/').encode('utf-8')+b'\0')
    runtime_tree.update(open(path,'rb').read())
actual_runtime_tree=runtime_tree.hexdigest()
if actual_runtime_tree != runtime_patch['patched_frontend_tree_sha256']:
    raise SystemExit(f'HIGO_GATE FAIL: patched tree expected={runtime_patch["patched_frontend_tree_sha256"]} actual={actual_runtime_tree}')
print('HIGO_GATE PASS: canonical frontend payload='+expected['frontend'])
print('HIGO_GATE PASS: vendor source 60-file frontend tree sha256='+actual_tree)
print('HIGO_GATE PASS: deterministic patched runtime tree sha256='+actual_runtime_tree+'; only '+patched_rel+' differs')
print('HIGO_GATE PASS: package, init script, defaults and dual-UI files installed')
PY
