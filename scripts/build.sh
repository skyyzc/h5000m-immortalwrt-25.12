#!/bin/sh
set -eu

profile="${1:-}"
source_lock="${2:-candidate}"
case "$profile" in rescue|full) ;; *) echo "usage: $0 rescue|full [candidate|stable]" >&2; exit 2;; esac
case "$source_lock" in candidate|stable) ;; *) echo "source must be candidate or stable" >&2; exit 2;; esac

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src="${H5000M_SOURCE:-$root/workspace/immortalwrt}"
"$root/scripts/prepare.sh" "$source_lock"
H5000M_SOURCE="$src" "$root/scripts/apply.sh"
cp "$root/configs/$profile.config" "$src/.config"
make -C "$src" defconfig
make -C "$src" download -j"${JOBS:-8}"
make -C "$src" -j"${JOBS:-2}" V=s
"$root/scripts/generate-manifest.sh" "$profile" "$source_lock"
