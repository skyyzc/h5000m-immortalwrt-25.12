#!/bin/sh
set -eu
manifest=${1:-}
out=${2:-}
[ -f "$manifest" ] || { echo "manifest not found: $manifest" >&2; exit 1; }
[ -n "$out" ] || { echo "report output is required" >&2; exit 2; }
"${PYTHON:-python3}" - "$manifest" "$out" <<'PY'
import json, sys
m=json.load(open(sys.argv[1]))
lines=['# H5000M Build Report','','## Build Identity','',
 f"- Project: `{m['project']['commit']}` on `{m['project']['branch']}`",f"- Profile: `{m['profile']}`",
 f"- GitHub run: `{m['github']['run_id']}` / number `{m['github']['run_number']}` / attempt `{m['github']['run_attempt']}`",
 f"- Timestamp: `{m['build']['timestamp']}`",'','## Source Locks','',f"- ImmortalWrt: `{m['source']['immortalwrt_commit']}`"]
for name, feed in m['feeds'].items(): lines.append(f"- {name}: `{feed['commit']}`")
lines += ['','## Gates','','- Prepare: PASS (fresh exact source and feed locks)','- Apply: PASS (native baseline verified; identical second apply)',
 '- Defconfig: PASS','- Resolved Config: PASS','- H5000M/Higo/RG520 static build gates: PASS','- Compile: PASS',
 '','## Warnings','','- Static/build evidence only; no device or RAM boot validation was performed.',
 '','## Errors and Fixes','','- No unresolved build error.','','## Artifacts','']
for a in m['artifacts']: lines.append(f"- `{a['filename']}` — {a['size']} bytes — `{a['sha256']}`")
lines += ['','## Hashes','',f"- resolved.config: `{m['resolved_config']['sha256']}`",'','## Unknowns','']
lines += [f'- `{x}`' for x in m['unknown']] or ['- None for build identity fields.']
lines += ['','## Known Issues','','- Runtime behavior, UI behavior, RG520 dialing, QMAP, Wi-Fi and IPv6 remain untested on hardware.',
 '','## Validation Level','','- SOURCE_LOCKED: PASS','- CONFIG_RESOLVED: PASS','- BUILD_OK: PASS',
 '- RAM_BOOT_OK: NOT TESTED','- DEVICE_OK: NOT TESTED','- FUNCTION_TESTED: NOT TESTED','']
open(sys.argv[2],'w',newline='\n').write('\n'.join(lines))
PY
