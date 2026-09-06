# DEVICE-01 Current State

- Phase: `DEVICE-01`
- State: `REVIEW_REQUIRED`
- Date: `2026-09-05`
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
- Last Confirmed Gate: normal power-cycle recovery returned to the original
  ImmortalWrt 24.10 system with its expected identity, storage layout, radios,
  management services and RG520/QMI data path intact
- Next Action: review the recorded LAN-client IPv6 and Higo integration gaps;
  do not begin repair, another build, Full, or persistent deployment implicitly
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
- POWER_CYCLE_RECOVERY_FUNCTION_TESTED: `YES`
- POWER_CYCLE_RECOVERY_CONFIRMED: `YES`
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
- Higo logs: `PASS / FUNCTION_TESTED`; the page displays runtime logs normally.
- Higo scheduled tasks: `PASS / FUNCTION_TESTED` for runtime create/delete. The
  user created one task and then deleted it. A read-only follow-up found no task
  state file; `/` remains tmpfs and the original partition remains read-only.
- Higo notifications: page display is `UI_OK`, but every attempted notification
  operation fails with `system configuration operation failed: not found`.
  Operational maturity is `FAIL`.
- Higo terminal: `PASS / FUNCTION_TESTED` for the read-only `uptime` command,
  which returned normally at about 16h04m uptime.
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
- Additional runtime action: the user created and deleted one Higo scheduled
  task. The task is no longer present, and all inspected state remained in the
  initramfs/tmpfs environment. This action is recorded rather than omitted.
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

## Power-Cycle Recovery and DEVICE-01 Decision

- Recovery: `PASS / FUNCTION_TESTED`. After the user performed a normal power
  cycle, the device returned to its original ImmortalWrt `24.10-SNAPSHOT`,
  revision `r33418-34bb738192`, Linux `6.6.94`, board `hiveton,h5000m`, with
  `rootfs_type=squashfs`.
- Storage: `PASS`. The original `/dev/mmcblk0p5` squashfs is mounted read-only at
  `/rom`; the original F2FS overlay is active. The 7.3 GiB eMMC and its five
  partitions retain the baseline sizes. The Run 20 `/etc/h5000m-build.json` is
  absent, as expected on the original system.
- Services and networking: `PASS`. SSH, Higo on port 80 and LuCI on port 8080
  are reachable; Higo, uhttpd, dropbear, DHCP/DNS, odhcpd, QModem and
  `quectel-CM-M` are running. LAN and both AP interfaces are up.
- Radio recovery: `PASS`. The original system reports 2.4 GHz channel 6 and
  5 GHz channel 44, matching the captured baseline; the temporary Rescue
  channel action did not survive the power cycle.
- Cellular recovery: `PASS`. RG520N-CN remains enumerated as `2c7c:0801`, the
  ttyUSB and cdc-wdm nodes exist, and `wwan0_1` is up with IPv4 and IPv6.
- Critical recovery log gate: `PASS` for the bounded check; no panic, oops,
  segmentation fault, storage I/O error or MMC error matched after startup.
- Persistent modification conclusion: `NO`. No evidence of a persistent change
  to eMMC, GPT, U-Boot, BL2, factory data or modem configuration was found.
- DEVICE-01 core RAM-validation gates passed, including boot, identity,
  traceability, LAN/DHCP/SSH, Higo/LuCI coexistence, dual-band real-client
  traffic, RG520/QMI/QMAP, stability and power-cycle recovery.
- Overall validation result: `PASS_WITH_KNOWN_ISSUES`; state is
  `REVIEW_REQUIRED`, not automatic repair. The observed LAN-client IPv6 failure,
  Higo notification-operation failure, unrecognized CPE profile and absent
  neighbour-cell data remain explicit repair candidates. Wired WAN remains
  `BLOCKED_BY_ENVIRONMENT`.
- DEVICE-01R root-cause and Original -> Rescue -> Full audit is `COMPLETE` in
  `docs/DEVICE-01R-GAP-AUDIT.md`. It preserves all Rescue core PASS evidence,
  separates per-feature maturity, and leaves the four demonstrated issues for
  review rather than starting an implicit repair or Full build.
- DEVICE-01F repair design is `COMPLETE` in
  `docs/DEVICE-01F-REPAIR-DESIGN.md`. Notification and RG520 profile designs
  are ready for owner review; IPv6 and neighbour-cell root causes remain
  `UNKNOWN` and therefore have evidence-first plans rather than speculative
  fixes. Run 21 has not been triggered.
- DEVICE-01F-I implementation review applied approved CASE C. Notification
  request delegation is statically proved, but its safe atomic UCI backend is
  not; the RG520 label predicate was corrected to the network-mode response,
  whose Run 20 fixture is unavailable. Both repairs remain `BLOCKED`, no
  speculative firmware change was made, and Run 21 was not triggered. Details
  are in `docs/DEVICE-01F-I-IMPLEMENTATION.md`.
- DEVICE-01F-E completed one Run 20 RAM evidence session. It confirmed the
  QModem network preference (`3G=0, 4G=1, 5G=1`), the contradictory Higo
  network-mode presentation, delegated IPv6 topology, two-protocol real-client
  IPv6 failure, and empty LTE/NR arrays from the formal QModem neighbour call.
  The authenticated network-mode JSON, IPv6 packet boundary, raw neighbour
  response and safe notification storage contract remain unknown. No raw AT,
  firmware/source change or Run 21 occurred. Details are in
  `docs/DEVICE-01F-E-EVIDENCE.md`.
- DEVICE-01F-E2 closed the authenticated CPE and observed neighbour boundaries.
  Higo HTTP `200` reported `mode=auto` and selected `4G + 5G`, exactly matching
  QModem `3G=0,4G=1,5G=1`; the frontend has no preset for that combination, so
  `FRONTEND_NORMALIZATION` is confirmed. One bounded QModem-owned raw neighbour
  query returned `OK` without any data row, confirming `MODEM_RAW_EMPTY` for
  this sample. QMI/QMAP session continuity passed. Notification storage and
  IPv6 root cause remain unknown. Details are in
  `docs/DEVICE-01F-E2-EVIDENCE.md`.

## Run 21 Rescue RAM Validation

- Session identity: accepted Run 21 (`33951063311`, number `21`, attempt `1`),
  profile `rescue`, source `candidate`, build-input project
  `ab4d2cbaa8e1b9fa8742ae397b15399f535a50d1`, and locked ImmortalWrt
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`. The exact local initramfs was
  `19970460` bytes with SHA256
  `17d771fc5a1f469c0a56e5c92e8877bc0f8b700321de8860254304503b78d960`.
- Human gate: the owner alone used Recovery WebUI `Load initramfs`. Codex did
  not operate U-Boot, upload firmware, or invoke a persistent WebUI action.
- Identity and RAM safety: `PASS`. The runtime identified Hiveton H5000M,
  ImmortalWrt 25.12-SNAPSHOT / Linux 6.12.103 and `rootfs_type=initramfs`.
  `/` was tmpfs, with the original eMMC squashfs mounted read-only. Embedded
  build identity matched every Run/project/source/profile value above.
- Core regression: `PASS`. LAN, DHCP, SSH, authenticated Higo, authenticated
  LuCI, Higo/LuCI coexistence, RG520 `2c7c:0801`, `qmi_wwan_q`, `wwan0_1`,
  QModem, QMI/QMAP, device-side IPv4, and device-side IPv6 were operational.
  Final bounded log review found no panic, oops, service crash, modem reset, or
  new critical storage failure.
- Wi-Fi 2.4 GHz: `PASS / FUNCTION_TESTED`. A real Android client associated,
  obtained DHCP, reached Higo, and reached the Internet. Client identity and
  address are omitted.
- Wi-Fi 5 GHz: `PASS / FUNCTION_TESTED`. A real Mac client associated, obtained
  DHCP, reached Higo, and completed an IPv4 HTTPS request with HTTP 200. Client
  identity and addresses are omitted.
- LuCI: `PASS / FUNCTION_TESTED` for authenticated Overview. DHCPv4 leases were
  visible; the DHCPv6 lease table was empty. The latter is retained as an
  observation and is not treated as the IPv6 root cause because the client
  independently held SLAAC global addresses and an IPv6 default route.
- CPE repair gate: `FAIL / FUNCTION_TESTED`. The same-window QModem read-only
  action returned `3G=0,4G=1,5G=1`. The live Higo page showed a `4G / 5G` badge
  but still rendered `未识别配置` as the current-configuration title. Backend
  semantics were not changed, no save/apply action was used, and the built
  display normalization did not close the actual live presentation path.
- IPv6 client preconditions: `PASS`. The real Wi-Fi client had SLAAC global and
  ULA addresses plus a link-local IPv6 default gateway. Numeric IPv6 ICMP and
  numeric-target HTTPS both failed, while router-side cellular IPv6 passed.
- IPv6 packet attribution: `PASS / ROOT_CAUSE_CONFIRMED`. Four controlled echo
  requests appeared on `br-lan` and left `wwan0_1`; matching replies arrived on
  `wwan0_1`, but none returned through `br-lan`. The same delegated `/64` was
  installed as connected on both LAN and cellular; read-only route lookup for
  the client destination selected `wwan0_1`, whose connected route had the
  preferred metric. This confirms a local same-prefix return-route collision,
  not an absent upstream reply. The failing boundary is
  `ROUTER/QMAP/ROUTING_RETURN_PATH`.
- Packet safety: captures were short and bounded, written only to initramfs
  `/tmp`, inspected locally, never uploaded or committed, and deleted before
  session end. Durable evidence omits public and device-unique addresses.
- Non-targets: Notification received no Run 21 change and its storage contract
  remains `UNKNOWN`. Neighbour received no Run 21 change and raw AT was not
  repeated. No repair, Full work, or Run 22 was started.
- Power-cycle recovery: `PASS`. After the owner performed a normal physical
  power cycle, the original ImmortalWrt 24.10-SNAPSHOT / Linux 6.6.94 returned
  with `rootfs_type=squashfs`, read-only `/rom`, and the original F2FS overlay.
  Run 21 build identity was absent. Higo/LuCI, LAN, both APs, RG520,
  `qmi_wwan_q`, QModem/QMI/QMAP, and device-side IPv4/IPv6 recovered.
- Persistent safety conclusion: `PASS`; no evidence of modification to eMMC,
  GPT, U-Boot, BL2, factory data, persistent firmware, or modem configuration.
- Overall Run 21 decision: `RUN21_RAM_BOOT_OK=YES`, `RUN21_DEVICE_OK=YES`, but
  `RUN21_FUNCTION_TESTED=NO` because the mandatory CPE repair function gate in
  this Run-scoped contract failed. Run 20 evidence is retained unchanged.

## CPE-EVIDENCE-01 Run 21 follow-up

- Run 21 identity and RAM-only safety were reconfirmed; `/` remained tmpfs and
  the original eMMC squashfs remained read-only.
- Authenticated HTTP 200 evidence again showed `mode=auto`, selected
  `4G + 5G`, supported `3G/4G/5G`, matching QModem `3G=0,4G=1,5G=1`.
- A newly created isolated Higo tab requested
  `/assets/CPEManagement-CuEyMeyg.js` and visibly retained `未识别配置`.
  The device currently serves the Run 21 patched 85584-byte chunk at that URL,
  SHA256 `f8eef73d3abe39a5170c3d84f952bbf5683690b6f240a23a9d58a783d2e33ad0`.
- The browser evidence interface did not expose the body/hash of the already
  loaded response. Cache selection versus patched-resolver runtime input is
  therefore still unresolved: `CPE_RCA=UNKNOWN`,
  `CPE_REPAIR_UNBLOCKED=NO`. See `docs/CPE-EVIDENCE-01.md`.
- This follow-up changed no device, modem, network, firmware, source, package,
  configuration, lock, or persistent-storage state.

`CPE-RUN21-LIVE-BODY-01` subsequently supplied human-assisted Chrome Incognito
DevTools response evidence for the exact CPE chunk request. The excerpt contains
the Run 21 patched resolver and excludes the canonical resolver, so
`CPE_LOADED_CHUNK_IDENTITY=RUN21_PATCHED` and stale canonical cache selection is
rejected. Because the excerpt is not the full byte-identical response,
`CPE_LOADED_CHUNK_HASH=UNKNOWN` remains. The live title still failed;
`CPE_RCA=UNKNOWN`, `CPE_REPAIR_UNBLOCKED=NO`, and the next gate is bounded live
Vue resolver-state evidence. No device or persistent state changed.

## CPE-RUN21-LIVE-STATE-01 closure

Later exact Run 21 read-only debugger evidence closed the outstanding CPE gate.
At the completed render boundary, `F.mode=auto`, selected networks were
`[4G,5G]`, the normalized key was `4G|5G`, `st.value.title` and `Tt.value` were
`4G + 5G`, and `Jt.value` was `4G / 5G`. After execution resumed, the real Higo
current-configuration card visibly showed `4G + 5G`. No save/apply or device
state change occurred. Earlier intermediate `undefined` reads were taken while
the computed getters were paused/running and are debugger re-entry artifacts.
The earlier unknown-title observation remains historical evidence; its precise
timing/state cause is only `PARTIAL`, but it no longer blocks the demonstrated
Run 21 function result.

RUN20_SOURCE_LOCKED: `YES`
RUN20_CONFIG_RESOLVED: `YES`
RUN20_BUILD_OK: `YES`
RUN20_RAM_BOOT_OK: `YES`
RUN20_DEVICE_OK: `YES`
RUN20_FUNCTION_TESTED: `YES`
HIGO_UI_OK: `PARTIAL`
LUCI_UI_OK: `YES`
LAN_OK: `YES`
DHCP_OK: `YES`
WIFI_2G_OK: `YES`
WIFI_5G_OK: `YES`
RG520_USB_OK: `YES`
QMI_OK: `YES`
QMAP_OK: `YES`
IPV4_OK: `YES`
IPV6_OK: `NO` (device-side cellular IPv6 passed; LAN-client external IPv6 failed)
PERSISTENT_STORAGE_MODIFIED: `NO`
POWER_CYCLE_RECOVERY_OK: `YES`
RESCUE_CORE_VALIDATED: `YES`
FINAL_FEATURE_COMPLETE: `NO`
FULL_INTEGRATION_COMPLETE: `NO`
DEVICE-01R_ANALYSIS: `COMPLETE`
REPAIR_PLAN_READY: `YES`
DEVICE-01F_DESIGN: `COMPLETE`
RUN21_CHANGESET_DESIGN: `READY`
DEVICE01F_DESIGN_RUN21_TRIGGERED: `NO`
DEVICE-01F-I: `BLOCKED`
NOTIFICATION_IMPLEMENTATION: `BLOCKED`
RG520_PROFILE_IMPLEMENTATION: `BLOCKED`
DEVICE-01F-E: `PARTIAL`
CPE_NETWORK_MODE_FIXTURE: `CONFIRMED`
CPE_FAILURE_BOUNDARY: `FRONTEND_NORMALIZATION`
CPE_CONTRACT_CLOSED: `YES`
NOTIFICATION_STORAGE_CONTRACT: `UNKNOWN`
IPV6_ROOT_CAUSE: `UNKNOWN`
IPV6_PACKET_EVIDENCE_REQUIRED: `YES`
NEIGHBOUR_FAILURE_BOUNDARY: `MODEM_OR_RADIO_ENVIRONMENT`
NEIGHBOUR_ROOT_CAUSE: `MODEM_RAW_EMPTY_AT_SAMPLE`
NEIGHBOUR_RAW_AT_REQUIRED: `NO`
DEVICE-01F-E2: `COMPLETE`
NEIGHBOUR_OWNERSHIP_GATE: `PASS`
NEIGHBOUR_RAW_AT: `EXECUTED`
NEIGHBOUR_RAW_RESULT: `MODEM_RAW_EMPTY`
NEIGHBOUR_CONTRACT_CLOSED: `YES`
QMI_QMAP_AFTER_AT: `PASS`
READY_FOR_DEVICE-01F-II: `PARTIAL`
DEVICE-01F-II: `COMPLETE`
DEVICE01FII_PREBUILD_CPE_REPAIR: `IMPLEMENTED_BUILD_UNVERIFIED`
CPE_FIXTURE_TEST: `PASS`
VENDOR_SOURCE_PAYLOAD_PRESERVED: `YES`
PATCHED_RUNTIME_TRACEABLE: `YES`
NOTIFICATION_RUN21_CHANGE: `NO`
IPV6_PACKET_TOOL: `tcpdump-mini`
IPV6_RUN21_CHANGE: `YES`
NEIGHBOUR_RUN21_CHANGE: `NO`
RUN21_CHANGESET: `READY`
BUILD_PHASE: `BUILD-03 / RUN21`
BUILD_STATE: `SUCCESS`
BUILD_WORKFLOW: `Build H5000M initramfs`
RUN21_ID: `33951063311`
RUN21_NUMBER: `21`
RUN21_ATTEMPT: `1`
RUN21_PROJECT_SHA: `ab4d2cbaa8e1b9fa8742ae397b15399f535a50d1`
RUN21_IMMORTALWRT_SHA: `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`
RUN21_PROFILE: `rescue`
RUN21_SOURCE: `candidate`
RUN21_TRIGGERED: `YES`
RUN21_RESULT: `SUCCESS`
RUN21_DURATION: `2h38m08s`
RUN21_ARTIFACT_NAME: `h5000m-rescue-ab4d2cba-1d34e7b8-run21-attempt1`
RUN21_ARTIFACT_ID: `9967061702`
RUN21_ARTIFACT_ARCHIVE_SIZE: `20037155`
RUN21_ARTIFACT_GITHUB_DIGEST: `sha256:23f3c17efec1633621b30f4fdc002db2f5565931bc2dbfe2b56256afb3a26b82`
RUN21_FIRMWARE: `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`
RUN21_FIRMWARE_SIZE: `19970460`
RUN21_FIRMWARE_SHA256: `17d771fc5a1f469c0a56e5c92e8877bc0f8b700321de8860254304503b78d960`
RUN21_ARTIFACT_ACCEPTANCE: `PASS`
RUN21_BUILD_OK: `YES`
RUN21_CPE_REPAIR_BUILT: `YES`
RUN21_CPE_BACKEND_UNCHANGED: `PARTIAL` (QModem and rendered `4G / 5G` semantics
matched; a sanitized raw authenticated API response was not captured)
RUN21_CPE_LABEL: `4G + 5G (4G / 5G)`
RUN21_CPE_FUNCTION_TESTED: `YES`
RUN21_IPV6_PACKET_TOOL_BUILT: `YES`
RUN21_CLIENT_IPV6_RESULT: `FAIL`
RUN21_IPV6_PACKET_BOUNDARY: `ROUTER_QMAP_ROUTING_RETURN_PATH`
RUN21_IPV6_ROOT_CAUSE: `CONFIRMED_SAME_PREFIX_RETURN_ROUTE_COLLISION`
RUN21_RAM_BOOT_OK: `YES`
RUN21_IDENTITY_OK: `YES`
RUN21_PERSISTENT_SAFETY_OK: `YES`
RUN21_LAN_OK: `YES`
RUN21_DHCP_OK: `YES`
RUN21_SSH_OK: `YES`
RUN21_HIGO_OK: `YES`
RUN21_LUCI_OK: `YES`
RUN21_WIFI_2G_OK: `YES`
RUN21_WIFI_5G_OK: `YES`
RUN21_RG520_OK: `YES`
RUN21_QMI_OK: `YES`
RUN21_QMAP_OK: `YES`
RUN21_DEVICE_IPV4_OK: `YES`
RUN21_DEVICE_IPV6_OK: `YES`
RUN21_DEVICE_OK: `YES`
RUN21_FUNCTION_TESTED: `YES`
POWER_CYCLE_RECOVERY_RUN21_OK: `YES`
RUN21_LAST_CONFIRMED_GATE: `POWER_CYCLE_RECOVERY_PASS`
RUN21_WAIT_REASON: `NONE_BUILD_COMPLETE`
RUN21_NEXT_ACTION: `OWNER_REVIEW_BEFORE_SEPARATE_REPAIR_DESIGN`
READY_FOR_NEXT_REPAIR_DESIGN: `YES`
DEVICE_01G_REPAIR_DESIGN: `PASS`
CPE_LIVE_PATH_CLOSED: `NO`
CPE_LOADED_CHUNK_IDENTITY: `RUN21_PATCHED`
CPE_LOADED_CHUNK_HASH: `UNKNOWN` (human evidence is a curated resolver excerpt)
CPE_BROWSER_CACHE_OLD_CANONICAL_HYPOTHESIS: `REJECTED`
CPE_RCA: `PARTIAL` (initial unknown-title timing/state discrepancy not reproduced)
CPE_ADDITIONAL_DEVICE_EVIDENCE_REQUIRED: `NO` for the Run 21 CPE function gate
IPV6_REPAIR_DESIGNED: `YES`
IPV6_SELECTED_DESIGN: `DYNAMIC_PREFERRED_LAN_SHARED_PREFIX_ROUTE`
IPV6_NATIVE_ROUTED_DESIGN: `YES`
IPV6_NAT66_REQUIRED: `NO`
IPV6_PROXY_NDP_REQUIRED: `NO`
AUTH_FRICTION_02: `PASS`
ISSUE_CLOSURE_RULE: `PASS`
RUN22_CHANGESET_DESIGNED: `YES` (IPv6-only implementation contract; no CPE delta)
RUN22_TRIGGERED: `NO`
CURRENT_PHASE_IMPLEMENTATION_AUTHORIZED: `NO`

IPV6_IMPLEMENTATION_UNBLOCKED: `YES`
RUN22_CHANGESET_READY: `YES`
BUILD_WORTH_TRIGGERING: `NO` (implementation not present)

## Run 22 build and artifact acceptance

Run 22 is build evidence only; no RAM boot or device operation occurred.

- Workflow / Run ID / number / attempt: `Build H5000M firmware` /
  `33987589482` / `22` / `1`.
- Result / duration: `SUCCESS` / `2h28m02s`.
- Build-input project / ImmortalWrt SHA:
  `ca75cc3d6a9b7ce1907656d585fa1c5b283c030b` /
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`.
- Profile / source: `rescue` / `candidate`.
- Artifact: `h5000m-rescue-ca75cc3d-1d34e7b8-run22-attempt1`; ID
  `9977722506`; downloaded archive size `20042327`; digest
  `sha256:c29736f4f0f7d8ff5fdb9a0555a44a81e68ffa97bf2274ea34026fbc238c4d69`.
- Firmware:
  `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`;
  `19975104` bytes; SHA256
  `bacb594c5fcbfe37e562efc8bef584a635848bc6b7e27bc87f0f8a3e85bb7d4a`.
- Manifest, report, requested/resolved config, checksums, source/feed identities,
  Higo and RG520/QModem/qmi_wwan_q gates all passed. Embedded build identity
  matches the exact run/project/source/profile.
- The initramfs contains exact approved `0755` helper and hotplug hook bytes:
  helper SHA256
  `bbcb9fdc43c402e1d98e0eb12e1bf019f7d993c811fd4e1593f94249fda9cdcd`;
  hook SHA256
  `a786c8c45bffa0cd09863faa0b195156bd3f850e8557e62200ddd8eac3ea7a97`.
- Run 21/22 requested and resolved configs are identical. No source lock,
  package selection, profile, unrelated source/feature, Full, device or
  persistent change occurred. Byte-for-byte reproducibility remains
  `UNVERIFIED`.

RUN22_TRIGGERED: `YES`
RUN22_BUILD_RESULT: `SUCCESS`
RUN22_ARTIFACT_ACCEPTANCE: `PASS`
RUN22_BUILD_OK: `YES`
RUN22_IPV6_HELPER_PRESENT: `YES`
RUN22_IPV6_HOTPLUG_PRESENT: `YES`
RUN22_BUILD_IDENTITY_MATCH: `YES`
RUN22_RAM_BOOT_OK: `UNVERIFIED`
RUN22_DEVICE_OK: `UNVERIFIED`
RUN22_FUNCTION_TESTED: `UNVERIFIED`
RUN22_RAM_BOOT_AUTHORIZED: `NO`
DEVICE_MODIFIED_RUN22_BUILD: `NO`
PERSISTENT_STORAGE_MODIFIED_RUN22_BUILD: `NO`

## Run 22 exact-run Rescue RAM validation

- Exact local firmware name, size and SHA256 matched the accepted Run 22
  artifact. Runtime identity matched Run ID `33987589482`, project
  `ca75cc3d6a9b7ce1907656d585fa1c5b283c030b`, ImmortalWrt
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0` and profile `rescue`.
- RAM safety passed: `rootfs_type=initramfs`, `/` was tmpfs and the original
  squashfs was mounted read-only.
- IPv6 implementation failed before function validation. netifd brought up
  logical interface `USBv6` on device `wwan0_1`; the hook required
  `INTERFACE=wwan0_1` and therefore never dispatched the helper. No helper
  state/log or owned `br-lan` metric `1`, protocol `242` route existed. The
  ordinary cellular metric `256` route remained preferred over LAN metric
  `1024` for the shared `/64`.
- Higo/LuCI HTTP, LAN, both APs, RG520, QModem/QMI/QMAP and device-side IPv6
  passed bounded sanity, but reconnect/lifecycle and two-client tests were not
  run after the critical failure and remain `UNVERIFIED`.
- Owner power-cycle recovery passed. Original ImmortalWrt 24.10 squashfs/F2FS
  overlay, Higo/LuCI, LAN, radios and RG520/QMI/QMAP returned; Run 22 identity
  was absent. Persistent storage modified: `NO`.
- Full evidence: `docs/RUN22-EXACT-RUN-RAM-VALIDATION-REPORT.md`.

RUN22_RAM_BOOT_OK: `PASS`
RUN22_RUNTIME_IDENTITY_MATCH: `PASS`
RUN22_DEVICE_OK: `FAIL`
RUN22_FUNCTION_TESTED: `FAIL`
RUN22_FAILURE_BOUNDARY: `HOTPLUG_LOGICAL_INTERFACE_FILTER_MISMATCH`
RUN22_PERSISTENT_RECOVERY_OK: `PASS`
PERSISTENT_STORAGE_MODIFIED_RUN22_RAM: `NO`

## IPV6-RUN23-DISPATCH-REPAIR-01 static implementation

Run 22 remains `DEVICE_OK=FAIL` and `FUNCTION_TESTED=FAIL`. Its first causal
error was repaired without reinterpreting that historical result. The locked
netifd contract sets `INTERFACE` to the logical name, supplies `DEVICE` only
for `ifup`/`ifupdate`, and omits it for `ifdown`. Accordingly, the hook now
requires `USBv6` plus `wwan0_1` for up/prefix update, and `USBv6` with absent
`DEVICE` for teardown. The helper's ubus selector is now logical `USBv6`.

The Run 22-equivalent event and fail-closed negatives pass deterministic
fixtures alongside all 16 existing route cases. This is static evidence only:
real helper invocation, protocol-242 route ownership, client forwarding,
prefix replacement/cleanup, reconnect/recovery, foreign preservation and
ifdown remain `UNVERIFIED` until a future separately authorized exact-run RAM
test.

IPV6_RUN23_DISPATCH_REPAIR_PERFORMED: `YES`
IMPLEMENTATION_CONFORMS_TO_FAILURE_EVIDENCE: `YES`
HOTPLUG_RUNTIME_CONTRACT_DOCUMENTED: `YES`
REALISTIC_HOTPLUG_FIXTURE_ADDED: `YES`
FIXTURE_TESTS_RUN23_PREBUILD: `PASS`
STATIC_GATES_RUN23_PREBUILD: `PASS`
RUN23_BUILD_READY: `YES`
RUN23_TRIGGERED: `NO`
DEVICE_MODIFIED_RUN23_PREBUILD: `NO`
PERSISTENT_STORAGE_MODIFIED_RUN23_PREBUILD: `NO`

## Run 24 Rescue build bookkeeping

GitHub Actions Run ID `34041525997`, Run Number `24`, Attempt `1`, project
source `c5a3819fc237dfb07c4ad88899b339bfb9e86eea`, failed before firmware compile
or artifact creation. The first causal failure was confined to the new jshn
regression harness: the mock command environment was not exported reliably, so
its expected post-initialization probe was not observed. This is not device
evidence and does not promote or demote the preserved Run 21/22/23 technical
maturity. The production helper was not changed by the harness correction.

RUN24_BUILD: `FAIL`
RUN24_DEVICE: `UNVERIFIED`
RUN24_ARTIFACT_AVAILABLE: `NO`
DEVICE_MODIFIED_RUN24_BUILD: `NO`
PERSISTENT_STORAGE_MODIFIED_RUN24_BUILD: `NO`
