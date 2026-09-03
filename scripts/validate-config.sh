#!/bin/sh
set -eu

config=${1:-}
[ -f "$config" ] || { echo "resolved config not found: $config" >&2; exit 1; }

failed=0
require_y() {
  symbol=$1 reason=$2
  requested=$(grep -E "^${symbol}=y$" "$config" || true)
  if [ "$requested" = "${symbol}=y" ]; then
    printf 'CONFIG_GATE PASS: %s\n' "$symbol"
  else
    printf 'CONFIG_GATE FAIL: REQUESTED=%s=y RESOLVED=%s REASON=%s\n' \
      "$symbol" "${requested:-not selected}" "$reason" >&2
    failed=1
  fi
}

require_y CONFIG_TARGET_mediatek 'H5000M target architecture is mandatory'
require_y CONFIG_TARGET_mediatek_filogic 'H5000M target subtarget is mandatory'
require_y CONFIG_TARGET_mediatek_filogic_DEVICE_hiveton_h5000m 'H5000M device is mandatory'
require_y CONFIG_TARGET_ROOTFS_INITRAMFS 'Rescue must produce initramfs'
require_y CONFIG_PACKAGE_dropbear 'SSH recovery access is mandatory'
require_y CONFIG_PACKAGE_higoros 'Higo is a permanent core requirement'
require_y CONFIG_PACKAGE_luci 'LuCI is a permanent core requirement'
require_y CONFIG_PACKAGE_luci-ssl 'LuCI web stack is mandatory'
require_y CONFIG_PACKAGE_uhttpd 'dual web UI requires uhttpd'
require_y CONFIG_PACKAGE_firewall4 'IPv4/IPv6 firewall is mandatory'
require_y CONFIG_PACKAGE_dnsmasq 'IPv4 DHCP/DNS is mandatory'
require_y CONFIG_PACKAGE_odhcp6c 'IPv6 client is mandatory'
require_y CONFIG_PACKAGE_odhcpd-ipv6only 'IPv6 server is mandatory'
require_y CONFIG_PACKAGE_kmod-mt7996e 'MT7992 2.4/5 GHz Wi-Fi driver is mandatory'
require_y CONFIG_PACKAGE_mt7992-23-firmware 'MT7992 2.4/5 GHz Wi-Fi firmware is mandatory'
require_y CONFIG_PACKAGE_kmod-usb3 'USB host support is mandatory'
require_y CONFIG_PACKAGE_kmod-usb-serial-option 'Quectel option serial support is mandatory'
require_y CONFIG_PACKAGE_kmod-usb-wdm 'cdc-wdm support is mandatory'
require_y CONFIG_PACKAGE_uqmi 'QMI userspace is mandatory'
require_y CONFIG_PACKAGE_kmod-qmi_wwan_q 'RG520 QMI/QMAP data path is mandatory'
require_y CONFIG_PACKAGE_qmodem 'RG520 management is mandatory'
require_y CONFIG_PACKAGE_luci-app-qmodem-next 'QModem LuCI application is mandatory'

[ "$failed" -eq 0 ] || exit 1
echo 'Resolved Rescue config gate passed'
