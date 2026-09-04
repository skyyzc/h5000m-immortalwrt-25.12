# DEVICE-01 Current State

- Phase: `DEVICE-01A`
- State: `WAITING_EXTERNAL`
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
- Device: Hiveton H5000M (`CONFIRMED` by DT, ubus and running system)
- Connection Method: direct Ethernet to the running original system (`CONFIRMED` link and DHCP)
- Current Firmware Baseline: ImmortalWrt `24.10-SNAPSHOT`, revision
  `r33418-34bb738192`, Linux `6.6.94`, squashfs plus F2FS overlay on eMMC
- Last Confirmed Gate: DEVICE-01A pre-RAM-boot readiness passed for the current
  Yuzhii0718/bl-mt798x-dhcpd Recovery WebUI `Load initramfs` path
- Next Action: wait for the user to enter the Recovery WebUI and manually use
  only `Load initramfs` with the exact Run 20 image; DEVICE-01B may start only
  after the user reports that Run 20 Rescue initramfs has started
- Blocked Reason: none; waiting at the mandatory human authorization gate
- Wait Reason: `USER_MANUAL_RECOVERY_WEBUI_LOAD_INITRAMFS`
- Persistent Storage Modified: `NO`

## DEVICE-01A Readiness

- DEVICE_IDENTITY_OK: `YES`
- ORIGINAL_BASELINE_CAPTURED: `YES`
- FIRMWARE_HASH_OK: `YES`
- CUSTOM_UBOOT_PRESENT: `YES` (device-owner evidence)
- UBOOT_ENTRY_CONFIRMED: `YES` (device-owner evidence)
- UBOOT_WEBUI_CONFIRMED: `YES` (device-owner evidence)
- WEBUI_LOAD_INITRAMFS_AVAILABLE: `YES` (current UI plus upstream documentation)
- WEBUI_RAM_ONLY_PATH_CONFIRMED: `YES`
- POWER_CYCLE_RECOVERY_DESIGN_CONFIRMED: `YES`
- POWER_CYCLE_RECOVERY_FUNCTION_TESTED: `NO` (pending DEVICE-01B proof)
- POWER_CYCLE_RECOVERY_CONFIRMED: `PENDING_DEVICE-01B_PROOF`
- NO_PERSISTENT_WRITE_PATH_CONFIRMED: `YES`
- NO_TTL_CONSTRAINT_RECORDED: `YES`
- RAM_LOAD_METHOD_CONFIRMED: `YES` (`Recovery WebUI -> Load initramfs`)
- RAM_LOAD_ADDRESS_CONFIRMED: `NOT_REQUIRED_FOR_WEBUI_PATH`
- RAM_BOOT_COMMAND_CONFIRMED: `NOT_REQUIRED_FOR_WEBUI_PATH`

- DEVICE-01A: `PASS`
- READY_FOR_MANUAL_RAM_BOOT: `YES`

## Original-System Baseline

- LAN link: `CONFIRMED`
- DHCP lease: `CONFIRMED`
- IPv4 gateway / ICMP: `CONFIRMED`
- Original-system stability: observed for at least 20 minutes; power and both
  Wi-Fi indicators illuminated (`CONFIRMED`; user observation plus uptime)
- Identity: DT, ubus and kernel identify `Hiveton H5000M`, compatible
  `hiveton,h5000m` / `mediatek,mt7987`; four Cortex-A53 CPUs and about 1 GiB RAM
- Original firmware: ImmortalWrt `24.10-SNAPSHOT`, revision
  `r33418-34bb738192`, Linux `6.6.94`
- SSH: TCP 22 and authenticated read-only command execution `CONFIRMED`; the
  changed host key was accepted only for this direct session without modifying
  the workstation's persistent known-hosts file
- Higo: HTTP 200 on TCP 80 and page opens for user (`CONFIRMED` reachable;
  authenticated UI `UNKNOWN`)
- LuCI: HTTP 200 on TCP 8080 and page opens for user (`CONFIRMED` reachable;
  authenticated UI `UNKNOWN`)
- WAN: `BLOCKED_BY_ENVIRONMENT` (no WAN cable connected)
- LAN/network: `eth0` is the active LAN bridge member at `192.168.88.1/24` with
  DHCP, DNS and IPv6 RA; `eth1` has no carrier because no WAN cable is present
- Wi-Fi: 2.4 GHz and 5 GHz AP interfaces are up on the current system; actual
  client association/data traffic remains `UNVERIFIED`
- RG520: USB `2c7c:0801` identifies Quectel RG520N-CN; four ttyUSB nodes,
  `/dev/cdc-wdm0`, `qmi_wwan_q`, `wwan0` and `wwan0_1` are present. QModem,
  `quectel-CM-M` and Higo services are running; no tty/cdc-wdm owner was reported
  by `fuser` at the sampling instant. No AT command was sent.
- Cellular data: `wwan0_1` is up with IPv4/IPv6 routes; DNS and HTTP over the
  device succeed, and external IPv6 ping succeeds. External IPv4 ICMP did not
  reply, but IPv4 HTTP succeeded, so this is not treated as a data-path failure.
- RG520 indicator: modem/5G module indicator remains off (`OBSERVED` by user)
  despite the confirmed modem and data path; recorded as a baseline indicator
  discrepancy, not a modem failure
- Storage: 7.3 GiB eMMC with five partitions; the original squashfs root is
  read-only and the existing F2FS overlay is mounted read-write by the original
  system. DEVICE-01 issued no storage write command.
- Boot baseline: kernel command line selects `PARTLABEL=rootfs`; serial console
  is `ttyS0,115200n1`. No serial-console operation is authorized or required for
  the selected Recovery WebUI path.

## Baseline Issues / Environment Limits

- Wired WAN: `BLOCKED_BY_ENVIRONMENT` because no WAN cable is connected.
- Wi-Fi client association and traffic: `UNVERIFIED`; only radio/AP operation is
  confirmed in DEVICE-01A so far.
- The original vendor Wi-Fi driver logs initialization-time warnings/errors while
  both AP interfaces remain operational. These are original-system baseline
  evidence and must not be attributed to the Run 20 image without comparison.
- The 5G module indicator is off while the RG520 data plane is operational; lamp
  semantics/root cause are `UNKNOWN`.

## Pre-RAM-Boot Path

- Constraint: `NO_TTL = YES`; `NO_SERIAL_CONSOLE = YES`. Do not request TTL,
  UART, soldering or device disassembly unless the user later changes this rule.
- Current custom U-Boot: `Yuzhii0718/bl-mt798x-dhcpd` (`CONFIRMED` by the device
  owner as installed and stable).
- Entry and UI: the device owner can reliably enter the Recovery/Failsafe WebUI
  and currently observes the `Load initramfs` function (`CONFIRMED`).
- Upstream design evidence: the project's README identifies failsafe WebUI
  Initramfs as the path for booting an OpenWrt/ImmortalWrt initramfs image:
  <https://github.com/Yuzhii0718/bl-mt798x-dhcpd#fit-support>.
- Selected method: `U-Boot Recovery WebUI -> Load initramfs -> Run 20 Rescue`.
  The WebUI owns the low-level RAM address and boot command, so manual address
  and CLI command gates are not required for this path.
- Persistent boundary: only `Load initramfs` is authorized. Firmware update,
  U-Boot/BL2/Factory update, Flash Editor, Environment Manager, UBI management
  and every other persistent-write function are prohibited.
- Recovery design: because the selected image is initramfs and no persistent
  update function is used, reboot/power cycle is expected to return to the
  existing original system. This design is confirmed; actual recovery remains
  untested until the DEVICE-01B completion power cycle.
- Human gate: Codex did not enter U-Boot, open or operate the Recovery WebUI,
  upload the image, or start initramfs. Only the user may perform that step.

No reboot, U-Boot command, RAM load, flash, sysupgrade, persistent write, or
device configuration change has been performed.
