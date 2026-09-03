#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src="${H5000M_SOURCE:-$root/workspace/immortalwrt}"
[ -d "$src" ] || { echo "source tree not found: $src" >&2; exit 1; }

require_text() {
  file=$1 pattern=$2 label=$3
  grep -q "$pattern" "$src/$file" || { echo "missing locked H5000M baseline: $label" >&2; exit 1; }
  echo "verified: $label"
}
require_text target/linux/mediatek/dts/mt7987a-hiveton-h5000m.dts 'compatible = "hiveton,h5000m"' DTS
require_text target/linux/mediatek/image/filogic.mk 'Device/hiveton_h5000m' image-definition
require_text target/linux/mediatek/filogic/base-files/etc/board.d/01_leds 'hiveton,h5000m)' LED-defaults
require_text target/linux/mediatek/filogic/base-files/etc/board.d/02_network 'hiveton,h5000m)' network-defaults
require_text target/linux/mediatek/filogic/base-files/etc/hotplug.d/ieee80211/11_fix_wifi_mac 'hiveton,h5000m)' Wi-Fi-MAC-handling

for patch in "$root"/patches/immortalwrt/*.patch; do
  [ -e "$patch" ] || break
  git -C "$src" apply --check "$patch"
  git -C "$src" apply "$patch"
  echo "applied: $(basename "$patch")"
done

mkdir -p "$src/package/hiveton"
rm -rf "$src/package/hiveton/higoros"
cp -a "$root/package/hiveton/higoros" "$src/package/hiveton/higoros"
if [ -d "$root/files" ]; then cp -a "$root/files/." "$src/"; fi
echo "Applied H5000M package and root files"
