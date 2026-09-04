# DEVICE-01 Current State

- Phase: `DEVICE-01A`
- State: `REVIEW_REQUIRED`
- Date: `2026-09-04`
- Branch: `rebuild-v1`
- Repository HEAD: `28bdcc6f5c5347d37b9a0c0e4039e55ab7f319df`
- Firmware Run: Run `20`, ID `33836565597`, attempt `1`
- Firmware Profile / Source: `rescue` / `candidate`
- Firmware Project SHA: `698aecdc52218c3565239e97bfd224b6c4af8f02`
- ImmortalWrt SHA: `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`
- Firmware: `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`
- Firmware Size: `19778796` bytes
- Firmware SHA256: `af4f129d68cbb0b2e6d06ed2dbccd64e100bc7403cf69f62b95093d7e86af13e` (`CONFIRMED` locally)
- Device: Hiveton H5000M / AirPi H5000M (`UNVERIFIED` current identity)
- Current Firmware Baseline: `UNKNOWN`
- Connection Method: direct Ethernet to the running original system (`PENDING`)
- Last Confirmed Gate: authoritative Run 20 firmware filename, size, and SHA256
- Next Action: user connects one PC Ethernet port directly to an H5000M LAN port while leaving the device powered and running; then resume read-only discovery
- Blocked Reason: both PC Ethernet adapters report `Media disconnected`; historical `192.168.88.1` is unreachable from the current Wi-Fi network and TCP 22/80/8080 are closed from this path
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

- DEVICE-01A: `BLOCKED` pending a physical network connection to the running
  original system; no device identity or baseline conclusion has been inferred.

No reboot, U-Boot command, RAM load, flash, sysupgrade, persistent write, or
device configuration change has been performed.
