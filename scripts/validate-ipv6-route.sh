#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
src=${H5000M_SOURCE:-$root/workspace/immortalwrt}
python_cmd=${PYTHON:-python3}
package=$root/package/hiveton/higoros
installed=$src/package/hiveton/higoros
helper=files/usr/libexec/h5000m-ipv6-route-reconcile
hook=files/etc/hotplug.d/iface/95-h5000m-ipv6-shared-prefix

for rel in "$helper" "$hook"; do
	[ -f "$package/$rel" ] || { echo "IPV6_ROUTE_GATE FAIL: missing $rel" >&2; exit 1; }
	[ -x "$package/$rel" ] || { echo "IPV6_ROUTE_GATE FAIL: not executable $rel" >&2; exit 1; }
	[ -f "$installed/$rel" ] || { echo "IPV6_ROUTE_GATE FAIL: missing installed $rel" >&2; exit 1; }
	[ -x "$installed/$rel" ] || { echo "IPV6_ROUTE_GATE FAIL: installed file not executable $rel" >&2; exit 1; }
	cmp "$package/$rel" "$installed/$rel" >/dev/null || { echo "IPV6_ROUTE_GATE FAIL: installed mismatch $rel" >&2; exit 1; }
	sh -n "$package/$rel"
done

"$python_cmd" "$root/tests/test-ipv6-shared-prefix-route.py"
"$root/tests/test-jshn-nounset-compat.sh"

grep -q '^PKG_VERSION:=1\.37\.0$' "$src/package/utils/busybox/Makefile" || {
	echo 'IPV6_ROUTE_GATE FAIL: locked BusyBox version changed' >&2; exit 1;
}
for symbol in BUSYBOX_DEFAULT_IP BUSYBOX_DEFAULT_FEATURE_IP_ROUTE; do
	grep -A2 "^config $symbol$" "$src/package/utils/busybox/Config-defaults.in" | grep -q '^[[:space:]]*default y$' || {
		echo "IPV6_ROUTE_GATE FAIL: $symbol unavailable" >&2; exit 1;
	}
done
if grep -R -E 'rtnl_rtprot_a2n|networking/libiproute/(iproute|rt_names)\.c' "$src/package/utils/busybox/patches" >/dev/null 2>&1; then
	echo 'IPV6_ROUTE_GATE FAIL: locked BusyBox patches alter route-protocol parsing' >&2
	exit 1
fi

# BusyBox 1.37 ip route passes proto values through rtnl_rtprot_a2n(), whose
# numeric path accepts an unsigned protocol byte. The runtime helper also runs
# a read-only `ip -6 route show proto 242` parser probe before any mutation.
grep -q '^ROUTE_PROTOCOL=242$' "$package/$helper"
grep -Fq 'ip -6 route show proto "$ROUTE_PROTOCOL"' "$package/$helper"
grep -q '^CELLULAR_INTERFACE=USBv6$' "$package/$helper"
grep -q '^LOGICAL_INTERFACE=USBv6$' "$package/$hook"
grep -q '^UNDERLYING_DEVICE=wwan0_1$' "$package/$hook"

for forbidden in 'nat66' 'proxy_ndp' 'proxy-ndp' 'nft ' 'fw4' 'qmodem' 'uqmi' 'network reload'; do
	if grep -iF "$forbidden" "$package/$helper" "$package/$hook" >/dev/null; then
		echo "IPV6_ROUTE_GATE FAIL: forbidden mutation token $forbidden" >&2
		exit 1
	fi
done

echo 'IPV6_ROUTE_GATE PASS: exact executable install and shell syntax'
echo 'IPV6_ROUTE_GATE PASS: locked jshn nounset compatibility regression'
echo 'IPV6_ROUTE_GATE PASS: BusyBox 1.37 numeric protocol parser + runtime fail-closed probe'
echo 'IPV6_ROUTE_GATE PASS: fixtures, ownership, lifecycle and mutation boundaries'
