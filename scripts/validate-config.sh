#!/bin/sh
set -eu

config=${1:-}
profile=${2:-rescue}
[ -f "$config" ] || { echo "resolved config not found: $config" >&2; exit 1; }
case "$profile" in rescue|full) ;; *) echo "profile must be rescue or full" >&2; exit 2;; esac

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
require_y CONFIG_PACKAGE_kmod-mt7992-23-firmware 'MT7992 2.4/5 GHz Wi-Fi firmware is mandatory'
require_y CONFIG_PACKAGE_kmod-usb3 'USB host support is mandatory'
require_y CONFIG_PACKAGE_kmod-usb-serial-option 'Quectel option serial support is mandatory'
require_y CONFIG_PACKAGE_kmod-usb-wdm 'cdc-wdm support is mandatory'
require_y CONFIG_PACKAGE_uqmi 'QMI userspace is mandatory'
require_y CONFIG_PACKAGE_kmod-qmi_wwan_q 'RG520 QMI/QMAP data path is mandatory'
require_y CONFIG_PACKAGE_qmodem 'RG520 management is mandatory'
require_y CONFIG_PACKAGE_luci-app-qmodem-next 'QModem LuCI application is mandatory'
require_y CONFIG_PACKAGE_tcpdump-mini 'bounded IPv6 forwarding-path packet attribution is mandatory for Run 21 Rescue evidence'

if [ "$profile" = full ]; then
  require_y CONFIG_PACKAGE_wrtbwmon 'Full client accounting is required'
  require_y CONFIG_PACKAGE_luci-app-wrtbwmon 'Full wrtbwmon LuCI integration is required'
  require_y CONFIG_PACKAGE_luci-app-oaf 'Full application filtering is required'
  require_y CONFIG_PACKAGE_fancontrol 'Full thermal fan policy is required'
  require_y CONFIG_PACKAGE_h5000m-full-compat 'Higo Full compatibility contracts are required'
  require_y CONFIG_PACKAGE_block-mount 'Full external storage discovery is required'
  require_y CONFIG_PACKAGE_kmod-usb-storage 'Full external USB storage is required'
  require_y CONFIG_PACKAGE_luci-app-diskman 'Full disk inventory UI is required'
  require_y CONFIG_PACKAGE_ksmbd-server 'Full SMB service is required'
  require_y CONFIG_PACKAGE_luci-app-ksmbd 'Full SMB UI is required'
  require_y CONFIG_PACKAGE_miniupnpd-nftables 'Full nftables UPnP service is required'
  require_y CONFIG_PACKAGE_luci-app-upnp 'Full UPnP UI is required'
  require_y CONFIG_PACKAGE_ddns-scripts 'Full DDNS service is required'
  require_y CONFIG_PACKAGE_luci-app-ddns 'Full DDNS UI is required'
  require_y CONFIG_PACKAGE_watchcat 'Full connectivity watchdog is required'
  require_y CONFIG_PACKAGE_luci-app-watchcat 'Full watchdog UI is required'
  require_y CONFIG_PACKAGE_zerotier 'Full optional ZeroTier package must resolve'
  require_y CONFIG_PACKAGE_luci-app-zerotier 'Full optional ZeroTier UI must resolve'
fi

[ "$failed" -eq 0 ] || exit 1
echo "Resolved $profile config gate passed"
