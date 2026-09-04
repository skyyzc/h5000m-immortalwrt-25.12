# DEVICE-01 Current State

- Phase: `DEVICE-01A`
- State: `REVIEW_REQUIRED`
- Date: `2026-09-04`
- Branch: `rebuild-v1`
- Repository HEAD at DEVICE-01 start: `28bdcc6f5c5347d37b9a0c0e4039e55ab7f319df`
- Firmware Run: Run `20`, ID `33836565597`, attempt `1`
- Firmware Profile / Source: `rescue` / `candidate`
- Firmware Project SHA: `698aecdc52218c3565239e97bfd224b6c4af8f02`
- ImmortalWrt SHA: `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`
- Firmware: `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`
- Firmware Size: `19778796` bytes
- Firmware SHA256: `af4f129d68cbb0b2e6d06ed2dbccd64e100bc7403cf69f62b95093d7e86af13e` (`CONFIRMED` locally)
- Device: Hiveton H5000M / AirPi H5000M (`UNVERIFIED` current identity)
- Connection Method: direct Ethernet to the running original system (`CONFIRMED` link and DHCP)
- Current Firmware Baseline: original-system LAN answered DHCP at the historical
  `192.168.88.1/24` gateway; firmware and device identity remain `UNKNOWN`
- Last Confirmed Gate: Ethernet link, client DHCP lease, IPv4 gateway, ARP, and
  ICMP to `192.168.88.1` are `CONFIRMED`
- Next Action: confirm the device has completed normal original-system boot,
  then repeat the bounded read-only service reachability check
- Blocked Reason: TCP 22, 80, and 8080 are not reachable and direct HTTP
  requests fail immediately; SSH, Higo, LuCI, device identity, and the required
  original-system baseline therefore cannot yet be collected
- Persistent Storage Modified: `NO`

## DEVICE-01A Readiness

- DEVICE_IDENTITY_OK: `UNKNOWN`
- ORIGINAL_BASELINE_CAPTURED: `NO`
- FIRMWARE_HASH_OK: `YES`
- RAM_LOAD_METHOD_CONFIRMED: `UNKNOWN`
- RAM_LOAD_ADDRESS_CONFIRMED: `UNKNOWN`
- RAM_BOOT_COMMAND_CONFIRMED: `UNKNOWN`
- POWER_CYCLE_RECOVERY_CONFIRMED: `UNKNOWN`
- NO_PERSISTENT_WRITE_PATH_CONFIRMED: `UNKNOWN`

- DEVICE-01A: `BLOCKED` pending availability of the running original system's
  management services; no device identity or firmware
  conclusion has been inferred.

## Original-System Baseline (partial)

- LAN link: `CONFIRMED`
- DHCP lease: `CONFIRMED`
- IPv4 gateway / ICMP: `CONFIRMED`
- SSH: `BASELINE ISSUE` (TCP 22 unavailable)
- Higo: `BASELINE ISSUE` (TCP 80 unavailable)
- LuCI: `BASELINE ISSUE` (TCP 8080 unavailable)
- Device identity, firmware, WAN, Wi-Fi, RG520, storage, and bootloader:
  `UNKNOWN`

No reboot, U-Boot command, RAM load, flash, sysupgrade, persistent write, or
device configuration change has been performed.
