#!/bin/sh
set -eu

lock_name=${1:-candidate}
root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src=${H5000M_SOURCE:-$root/workspace/immortalwrt}
external=$src/package/h5000m-full

for package in wrtbwmon luci-app-wrtbwmon oaf open-app-filter luci-app-oaf; do
  [ -f "$external/$package/Makefile" ] || { echo "FULL_GATE FAIL: missing locked package $package" >&2; exit 1; }
done
find "$external/oaf" -type f -name '*.ko' -print -quit | grep -q . && {
  echo 'FULL_GATE FAIL: legacy OAF kernel binary present' >&2; exit 1;
}
grep -q '$(KERNEL_MAKE_FLAGS)' "$external/oaf/Makefile" || { echo 'FULL_GATE FAIL: OAF is not source-built' >&2; exit 1; }
grep -q 'INTERFACE:-.*= lan' "$external/wrtbwmon/net/etc/hotplug.d/iface/99-wrtbwmon" || {
  echo 'FULL_GATE FAIL: wrtbwmon lifecycle patch absent' >&2; exit 1;
}
continue_line=$(grep -n 'kill -CONT' "$external/wrtbwmon/net/etc/init.d/wrtbwmon" | cut -d: -f1)
kill_line=$(grep -n 'procd_kill wrtbwmon' "$external/wrtbwmon/net/etc/init.d/wrtbwmon" | cut -d: -f1)
[ -n "$continue_line" ] && [ -n "$kill_line" ] && [ "$continue_line" -lt "$kill_line" ] || {
  echo 'FULL_GATE FAIL: safe wrtbwmon stop order absent' >&2; exit 1;
}
for package in fancontrol h5000m-full-compat; do
  [ -f "$src/package/hiveton/$package/Makefile" ] || { echo "FULL_GATE FAIL: missing PROJECT_LOCAL $package" >&2; exit 1; }
done
grep -Eq "option[[:space:]]+enabled[[:space:]]+['\"]?0" "$src/feeds/packages/net/miniupnpd/files/upnpd.config" || {
  echo 'FULL_GATE FAIL: locked miniupnpd safe default not proven' >&2; exit 1;
}
grep -Eq "option[[:space:]]+enabled[[:space:]]+['\"]?0" "$src/feeds/packages/net/zerotier/files/etc/config/zerotier" || {
  echo 'FULL_GATE FAIL: locked ZeroTier safe default not proven' >&2; exit 1;
}
if grep -q '^config watchcat' "$src/feeds/packages/utils/watchcat/files/watchcat.config"; then
  echo 'FULL_GATE FAIL: Watchcat retains an implicit recovery action' >&2; exit 1
fi
api=$src/package/hiveton/higoros/files/usr/share/higoros/lua/handlers/api.lua
for contract in /api/v1/network/dmz /api/v1/network/upnp /api/v1/network/ddns; do
  grep -Fq "$contract" "$api" || { echo "FULL_GATE FAIL: Higo contract missing $contract" >&2; exit 1; }
done
echo 'FULL_GATE PASS: traffic, OAF, fan, storage, service and optional package chains are source-ready'
