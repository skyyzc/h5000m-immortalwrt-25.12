#!/bin/sh
set -eu

profile="${1:-}"
source_lock="${2:-candidate}"
case "$profile" in rescue|full) ;; *) echo "usage: $0 rescue|full [candidate|stable]" >&2; exit 2;; esac
case "$source_lock" in candidate|stable) ;; *) echo "source must be candidate or stable" >&2; exit 2;; esac

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src="${H5000M_SOURCE:-$root/workspace/immortalwrt}"
artifacts="${H5000M_ARTIFACTS:-$root/artifacts}"
mkdir -p "$artifacts"
cp "$root/configs/$profile.config" "$artifacts/requested.config"
"$root/scripts/prepare.sh" "$source_lock"
H5000M_SOURCE="$src" "$root/scripts/apply.sh"
# Apply twice: native checks and identical package state must remain safe.
H5000M_SOURCE="$src" "$root/scripts/apply.sh"
cp "$root/configs/$profile.config" "$src/.config"
make -C "$src" defconfig
cp "$src/.config" "$artifacts/resolved.config"
"$root/scripts/validate-config.sh" "$artifacts/resolved.config"
H5000M_SOURCE="$src" "$root/scripts/validate-higo.sh" "$source_lock"
H5000M_SOURCE="$src" "$root/scripts/validate-rg520.sh" "$source_lock"

project_sha=$(git -C "$root" rev-parse HEAD)
source_sha=$(git -C "$src" rev-parse HEAD)
kernel_version=$(make -s -C "$src" val.LINUX_VERSION)
timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
mkdir -p "$src/files/etc"
"${PYTHON:-python3}" - "$src/files/etc/h5000m-build.json" "$profile" "$project_sha" "$source_sha" "$kernel_version" "$timestamp" <<'PY'
import json, os, sys
out, profile, project, source, kernel, timestamp=sys.argv[1:]
data={'profile':profile,'project_commit':project,'immortalwrt_commit':source,
      'kernel_version':kernel,'build_timestamp':timestamp,
      'github_run_id':os.getenv('GITHUB_RUN_ID'),'github_run_number':os.getenv('GITHUB_RUN_NUMBER')}
with open(out,'w',newline='\n') as f: json.dump(data,f,indent=2,sort_keys=True); f.write('\n')
PY
make -C "$src" download -j"${JOBS:-8}"
if ! make -C "$src" -j"${JOBS:-$(nproc)}"; then
  echo 'Parallel compile failed; retrying serially with verbose output' >&2
  make -C "$src" -j1 V=s
fi

find "$src/bin/targets/mediatek/filogic" -maxdepth 1 -type f -name '*h5000m*initramfs-kernel.bin' -exec cp {} "$artifacts/" \;
find "$artifacts" -maxdepth 1 -type f -name '*h5000m*initramfs-kernel.bin' -print -quit | grep -q . || {
  echo 'BUILD_GATE FAIL: no H5000M initramfs image generated' >&2; exit 1;
}
H5000M_MANIFEST="$artifacts/BUILD-MANIFEST.json" "$root/scripts/generate-manifest.sh" "$profile" "$source_lock"
"$root/scripts/generate-build-report.sh" "$artifacts/BUILD-MANIFEST.json" "$artifacts/BUILD-REPORT.md"
(cd "$artifacts" && sha256sum *h5000m*initramfs-kernel.bin BUILD-MANIFEST.json BUILD-REPORT.md resolved.config > SHA256SUMS)
echo "Build artifacts ready in $artifacts"
