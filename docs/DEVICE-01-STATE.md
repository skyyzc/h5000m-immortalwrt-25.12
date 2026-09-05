# DEVICE-01 Current State

- Phase: `DEVICE-01B`
- State: `ACTIVE_ENGINEERING`
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
- Last Confirmed Gate: the same Run 20 initramfs remained healthy for about
  15h57m with core services/interfaces and the RG520 data path still running;
  Higo CPE read-only page validation is recorded
- Next Action: validate the remaining safe Higo Rescue system pages without
  configuration changes, then perform the required user-controlled power-cycle
  recovery and original-system integrity comparison
- Blocked Reason: none
- Wait Reason: `NONE`
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

The user performed the authorized Recovery WebUI RAM load. Codex has performed
no reboot, U-Boot command, image upload, flash, sysupgrade, persistent write, or
device configuration change.

## DEVICE-01B Runtime Validation

- Entry evidence: the device owner reported successful manual Recovery WebUI
  `Load initramfs` startup of the exact Run 20 image.
- Boot: `PASS`. Linux `6.12.103` reached usable userspace, identifies
  `Hiveton H5000M` / `hiveton,h5000m`, and reports `rootfs_type=initramfs`.
- Build identity: `PASS`. `/etc/h5000m-build.json` matches Run ID
  `33836565597`, Run number `20`, project
  `698aecdc52218c3565239e97bfd224b6c4af8f02`, ImmortalWrt
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`, and profile `rescue`.
- Persistent safety: `PASS` so far. `/` is tmpfs; there is no persistent overlay.
  The original squashfs partition is mounted read-only under `/mnt`; no
  persistent write command or persistent WebUI function was used.
- LAN/DHCP: `PASS`. The real Ethernet client obtained a lease and reached the
  gateway; `eth0` and `br-lan` are up.
- SSH: `PASS`. A real root SSH session executed read-only commands.
- Higo: authenticated login `PASS`; maturity `UI_OK` with `PARTIAL` feature
  validation. Dashboard, system status and 5G/signal status read successfully.
  Device distribution, connected-device data and application ranking do not
  render useful data. Those components belong to later Full integrations in
  the current matrix and are not promoted to Rescue failures, but the observed
  gaps remain recorded.
- LuCI: `PASS`, maturity `UI_OK / FUNCTION_TESTED`. A real authenticated session
  loaded Overview/status, network interfaces and system logs without changing
  configuration.
- Higo/LuCI coexistence: `PASS`. Both authenticated Higo and LuCI were usable in
  the same Run 20 boot, with Higo on port 80 and LuCI on port 8080.
- Wi-Fi 2.4 GHz: `PASS`, maturity `FUNCTION_TESTED`. A real client associated,
  received a DHCP lease in the expected LAN subnet, opened Higo through the
  Wi-Fi path, and accessed the Internet. The exact client identity is omitted.
- Wi-Fi 5 GHz: `PASS`, maturity `FUNCTION_TESTED`. A real client associated,
  received a DHCP lease in the expected LAN subnet, opened Higo through the
  Wi-Fi path, and accessed the Internet. The exact client identity is omitted.
- Dual-band conclusion: 2.4 GHz and 5 GHz were each independently validated by
  a real client; neither result is inferred from the other.
- Higo CPE configuration: `PARTIAL`. Live network type and signal are readable,
  but the current configuration card reports an unrecognized 4G/5G profile.
  This is a real Run 20 compatibility gap even though dialing and traffic work.
- Higo CPE pages: connection status `FUNCTION_TESTED`; SMS management, SIM-card
  management, band lock and modem traffic management are `UI_OK` for read-only
  display. SMS send/delete, SIM controls, band mutation and traffic-limit
  mutation were not exercised and remain `UNVERIFIED`.
- Higo neighbour-cell page: `FAIL / PARTIAL`; it continuously reports that no
  neighbour-cell information was found despite the modem being registered.
- RG520 USB: `PASS`. The RG520N-CN enumerates as `2c7c:0801`; four ttyUSB nodes
  and `/dev/cdc-wdm0` exist.
- QMI/QMAP: `PASS`. `qmi_wwan_q`, `wwan0`, and `wwan0_1` are active;
  `quectel-CM-M` owns cdc-wdm, and QMAP byte counters advance.
- IPv4/IPv6 cellular: `PASS` at the device. Device-side IPv4 HTTP and DNS
  succeed, an IPv6 default route exists, and external IPv6 traffic succeeds.
  Public addresses and carrier/SIM identity are intentionally omitted.
- LAN client IPv6: `FAIL`. A real Ethernet client received Router Advertisement
  IPv6 addresses and a live default route, but both external IPv6 ICMP and an
  HTTPS request to a numeric IPv6 endpoint timed out. This is distinct from the
  working device-side IPv6 path and is not classified as DNS-only or ICMP-only.
- Port ownership: a bounded sample found `quectel-CM-M -> /dev/cdc-wdm0`; no
  persistent ttyUSB owner was observed. No AT command or competing QMI command
  was sent.
- Higo/QModem race: no modem reset, QMI interruption or data-path loss was
  observed during the initial bounded sample. Longer/reconnect behavior remains
  `UNVERIFIED`.
- Unplanned runtime actions: the user reports one 5 GHz channel write and one
  Higo `ATI` query. The current 5 GHz channel is 44 and both Wi-Fi/data paths
  remain operational. Because the initramfs root is tmpfs and the original
  partition remains read-only, the Wi-Fi configuration write is runtime-only
  in this boot. `ATI` returned module identification and is a read-only query;
  it did not modify modem configuration. No additional AT command was sent by
  Codex.
- Firewall: `PASS` baseline. nftables/fw4 is active with LAN and WAN zones,
  default reject input/forward policy, LAN acceptance and WAN masquerading.
- WAN: `BLOCKED_BY_ENVIRONMENT` because no wired WAN cable is connected.
- Boot warnings retained for review: initial PCIe deferred-probe messages,
  eMMC/GPT warnings, MT7992 EEPROM/default-bin fallback, a hostapd transient
  interface/scan warning, and QModem scanner `profile not matched` messages.
  The relevant Ethernet, Wi-Fi, storage and cellular functions are presently
  running, so these are not promoted to functional failures without contrary
  evidence.
- Stability: `PASS` for a bounded observation of about 15h57m. The embedded Run
  20 identity remained unchanged; Higo, uhttpd/LuCI, SSH, DHCP, QModem and
  `quectel-CM-M` remained running; LAN, both APs and QMAP remained up; device-side
  Internet remained available. No panic, oops, service crash, modem reset or
  QMI failure was found in the bounded log review. Ordinary client disconnect
  events were observed and are not failures by themselves.
- Device eMMC/GPT/U-Boot persistent storage modified: `NO` based on current
  mount and action evidence. Modem-internal persistent state modified: `NO` by
  the classified read-only `ATI` query.
