#!/bin/sh
set -eu
profile=${1:-}
lock_name=${2:-candidate}
case "$profile" in rescue|full) ;; *) echo "usage: $0 rescue|full [candidate|stable]" >&2; exit 2;; esac
root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src="${H5000M_SOURCE:-$root/workspace/immortalwrt}"
out="${H5000M_MANIFEST:-$root/BUILD-MANIFEST.json}"
python3 - "$root" "$src" "$profile" "$lock_name" "$out" <<'PY'
import datetime, glob, hashlib, json, os, subprocess, sys
root, src, profile, lock_name, out = sys.argv[1:]
lock=json.load(open(os.path.join(root,'versions',lock_name+'.json')))
def sha(path):
    h=hashlib.sha256()
    with open(path,'rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
    return h.hexdigest()
def git(path):
    try: return subprocess.check_output(['git','-C',path,'rev-parse','HEAD'],text=True).strip()
    except Exception: return None
patches=sorted(glob.glob(os.path.join(root,'patches','immortalwrt','*.patch')))
artifacts=sorted(glob.glob(os.path.join(src,'bin','targets','mediatek','filogic','*h5000m*')))
d={'project_commit':git(root),'immortalwrt_commit':git(src),'kernel_version':None,'profile':profile,
   'feeds_commits':{k:v.get('commit') for k,v in lock['feeds'].items()},
   'higo_version':lock['higo']['version'],'higo_payload_sha256':lock['higo']['payload_sha256'],
   'qmodem_version':lock['qmodem']['package_version'],'qmodem_commit':lock['qmodem']['commit'],
   'qmi_wwan_q_version':lock['qmi_wwan_q']['version'],'qmi_wwan_q_commit':lock['qmi_wwan_q']['commit'],
   'openappfilter_version':lock['openappfilter']['version'],'openappfilter_commit':lock['openappfilter']['commit'],
   'wrtbwmon_version':lock['wrtbwmon']['version'],'wrtbwmon_commit':lock['wrtbwmon']['commit'],
   'config_sha256':sha(os.path.join(root,'configs',profile+'.config')),
   'patches_sha256':{os.path.basename(p):sha(p) for p in patches},
   'github_run_id':os.getenv('GITHUB_RUN_ID'),'build_time':datetime.datetime.now(datetime.timezone.utc).isoformat(),
   'artifacts':[{'filename':os.path.basename(p),'sha256':sha(p)} for p in artifacts if os.path.isfile(p)]}
with open(out,'w') as f: json.dump(d,f,indent=2,sort_keys=True)
print(out)
PY
