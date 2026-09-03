#!/bin/sh
set -eu
profile=${1:-}
lock_name=${2:-candidate}
case "$profile" in rescue|full) ;; *) echo "usage: $0 rescue|full [candidate|stable]" >&2; exit 2;; esac
root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src=${H5000M_SOURCE:-$root/workspace/immortalwrt}
artifact_dir=${H5000M_ARTIFACTS:-$root/artifacts}
out=${H5000M_MANIFEST:-$artifact_dir/BUILD-MANIFEST.json}
python_cmd=${PYTHON:-python3}

"$python_cmd" - "$root" "$src" "$artifact_dir" "$profile" "$lock_name" "$out" <<'PY'
import datetime, glob, hashlib, json, os, subprocess, sys
root, src, artifact_dir, profile, lock_name, out=sys.argv[1:]
lock=json.load(open(os.path.join(root,'versions',lock_name+'.json')))
def sha(path):
    h=hashlib.sha256()
    with open(path,'rb') as f:
        for b in iter(lambda:f.read(1024*1024),b''): h.update(b)
    return h.hexdigest()
def cmd(*args):
    try: return subprocess.check_output(args,text=True,stderr=subprocess.DEVNULL).strip()
    except Exception: return None
project_commit=cmd('git','-C',root,'rev-parse','HEAD')
project_branch=os.getenv('GITHUB_REF_NAME') or cmd('git','-C',root,'branch','--show-current')
project_repo=(os.getenv('GITHUB_SERVER_URL')+'/'+os.getenv('GITHUB_REPOSITORY')
              if os.getenv('GITHUB_SERVER_URL') and os.getenv('GITHUB_REPOSITORY')
              else cmd('git','-C',root,'remote','get-url','origin'))
kernel=cmd('make','-s','-C',src,'kernelversion')
resolved=os.path.join(artifact_dir,'resolved.config')
patches=sorted(glob.glob(os.path.join(root,'patches','immortalwrt','*.patch')))
images=sorted(p for p in glob.glob(os.path.join(artifact_dir,'*h5000m*initramfs*.itb')) if os.path.isfile(p))
unknown=[]
for field, value in [('kernel.version',kernel),('github.run_id',os.getenv('GITHUB_RUN_ID')),
                     ('github.run_number',os.getenv('GITHUB_RUN_NUMBER')),('github.run_attempt',os.getenv('GITHUB_RUN_ATTEMPT'))]:
    if not value: unknown.append(field)
d={'schema_version':1,
 'project':{'repository':project_repo,'branch':project_branch,'commit':project_commit},
 'source':{'immortalwrt_repository':lock['immortalwrt']['repository'],'immortalwrt_branch':lock['immortalwrt']['branch'],
           'immortalwrt_commit':cmd('git','-C',src,'rev-parse','HEAD')},
 'feeds':{name:{'repository':feed['repository'],'commit':cmd('git','-C',os.path.join(src,'feeds',name),'rev-parse','HEAD')}
          for name,feed in lock['feeds'].items()},
 'kernel':{'version':kernel},'profile':profile,
 'packages':{'higo':{'version':lock['higo']['version'],'hashes':lock['higo']['payload_sha256']},
             'qmodem':{'version':lock['qmodem']['package_version'],'repository':lock['qmodem']['repository'],'commit':lock['qmodem']['commit']},
             'qmi_wwan_q':{'version':lock['qmi_wwan_q']['version'],'repository':lock['qmi_wwan_q']['source'],'commit':lock['qmi_wwan_q']['commit']}},
 'resolved_config':{'sha256':sha(resolved)},
 'patches':{'sha256':{os.path.relpath(p,root).replace('\\','/'):sha(p) for p in patches}},
 'github':{'workflow':os.getenv('GITHUB_WORKFLOW'),'run_id':os.getenv('GITHUB_RUN_ID'),
           'run_number':os.getenv('GITHUB_RUN_NUMBER'),'run_attempt':os.getenv('GITHUB_RUN_ATTEMPT')},
 'build':{'timestamp':datetime.datetime.now(datetime.timezone.utc).replace(microsecond=0).isoformat().replace('+00:00','Z'),'status':'SUCCESS'},
 'artifacts':[{'filename':os.path.basename(p),'type':'h5000m-rescue-initramfs','sha256':sha(p),'size':os.path.getsize(p)} for p in images],
 'unknown':unknown}
with open(out,'w',newline='\n') as f: json.dump(d,f,indent=2,sort_keys=True); f.write('\n')
print(out)
PY
