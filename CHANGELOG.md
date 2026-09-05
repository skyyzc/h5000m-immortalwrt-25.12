# Changelog

## Rebuild V1 / DEVICE-01

### BUILD-03 / Run 21 dispatched

- Owner-approved Rescue/candidate build dispatched as GitHub Actions Run 21
  (`33951063311`), attempt 1, from `rebuild-v1` project commit
  `ab4d2cbaa8e1b9fa8742ae397b15399f535a50d1` with locked ImmortalWrt
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`.
- Pre-build gates passed for the seven-case CPE fixture, strict patch-anchor
  rejection and idempotence, canonical/vendor and PROJECT_LOCAL runtime hashes,
  single intended runtime-asset delta, unchanged QModem inputs,
  `tcpdump-mini` selection/provenance/no-autostart, and tracked-secret scan.
- Initial workflow evidence confirms the correct branch and project SHA, with
  checkout complete and dependency installation running normally. Result and
  artifact identity remain `UNKNOWN` while the external build runs; no device,
  Full, RAM-boot or persistent operation is authorized or performed.

### DEVICE-01F-II implementation review

- Prepared the minimal Run 21 Rescue delta without triggering a build: a
  deterministic display-only Higo `4G + 5G` normalization patch plus
  `tcpdump-mini` for future bounded IPv6 packet attribution.
- Preserved the canonical vendor frontend and added distinct PROJECT_LOCAL
  patch, transformed-asset and patched-runtime-tree hashes. Extended Higo
  validation and build manifest/report semantics so patched runtime bytes are
  never described as byte-identical vendor payload.
- Added seven CPE fixtures preserving every existing profile label, recognizing
  `4G + 5G`, retaining the unknown fallback, and proving patch idempotence.
- Compared native-helper and narrow-ubus notification architectures; neither
  has a proved Higo invocation boundary, so Notification remains out of Run 21.
  IPv6 remains root-cause `UNKNOWN`, neighbour receives no firmware change,
  and no device, Full, persistent-storage or workflow action occurred.

### DEVICE-01F-E2 evidence closure

- Captured an authenticated Run 20 CPE network-mode fixture and correlated it
  with QModem in the same window. The backend/API correctly represented
  `4G + 5G`; the Higo frontend lacks a matching preset, confirming the failure
  boundary at frontend normalization.
- Proved the existing QModem AT ownership path and executed exactly one bounded
  read-only neighbour query. The modem returned `OK` without a neighbour data
  row; Higo and QModem consistently returned empty LTE/NR arrays. QMI/QMAP
  session continuity passed after the query.
- Kept notification storage `UNKNOWN` because no callable end-to-end
  typed/atomic UCI transaction boundary exists. Kept IPv6 root cause `UNKNOWN`
  and recorded the need for packet-attributed evidence. No firmware, source
  lock, Run 21, Full build or persistent state was changed.

### Project authorization policy

- Made H5000M authentication, read-only evidence acquisition and local raw
  analysis default-authorized while retaining sanitized durable records.
  Credentials may be used through normal protected local mechanisms without
  repeated approval, but remain prohibited from Git, documentation, firmware,
  CI, artifacts and public/shared logs.
- Classified bounded query-only AT commands by semantics rather than the
  presence of `=`. They are allowed only through a proved existing ownership
  path with before/after data-path checks; competing direct tty access remains
  prohibited. Persistent, destructive and state-changing operations retain
  their explicit owner gates.
- `AUTH_POLICY_UPDATED = YES`. This governance change does not modify firmware,
  configuration, packages, profiles or source locks.

### DEVICE-01F-E Missing Evidence Acquisition

- Completed a read-only Run 20 Rescue RAM evidence session without firmware,
  source-lock, persistent-device or build changes. Identity, tmpfs/read-only
  storage, LAN/SSH and RG520/QMI/QMAP sanity gates passed.
- Captured QModem network preference (`3G=0`, `4G=1`, `5G=1`) and the Higo
  current/pending presentation contradiction. The credential-safe boundary did
  not expose authenticated raw API JSON, so no profile/mode fix is inferred.
- Confirmed DHCPv6 delegation to LAN, forwarding and fw4/QMAP paths while a
  real client failed numeric IPv6 ICMP and numeric IPv6 HTTPS. Root cause stays
  `UNKNOWN` without packet-attributed evidence.
- Confirmed successful structured QModem neighbour output with empty LTE/NR
  arrays, closing the first empty boundary at `QMODEM_CONTROLLER_EMPTY` but not
  modem-versus-parser root cause. No raw AT command was issued.
- Found no callable typed/atomic UCI transaction contract for a PROJECT_LOCAL
  notification adapter. DEVICE-01F-II remains blocked and Run 21 was not
  triggered.

### DEVICE-01F-I Implementation Review

- Applied the approved CASE C rather than manufacturing a Run 21 changeset.
  Both compatibility implementations are blocked on missing proof; no firmware,
  profile, package or source-lock input changed and Run 21 was not triggered.
- Confirmed the Higo loader can select a PROJECT_LOCAL `api.lua` wrapper and
  delegate to an unchanged vendor dispatcher, but found no proved safe typed/
  atomic UCI transaction boundary for notification settings. An in-memory or
  shell-based speculative implementation was rejected.
- Corrected the CPE current-configuration contract from the earlier inferred
  `profileName` model to the frontend's proved `/cpe/network-mode` `mode` or
  normalized `selectedNetworks` match. The actual failing Run 20 response and
  closed-backend conversion remain `UNKNOWN`, so no profile/mode UCI change was
  made and the proven QMI/QMAP path remains untouched.
- Retained IPv6 and neighbour work as manual, bounded diagnostic plans. Image-
  resident collectors alone do not justify a complete build and would not
  resolve either unknown root cause.

### DEVICE-01F Repair Design

- Added a review-only Rescue compatibility repair design covering exactly the
  four DEVICE-01 gaps: LAN-client IPv6, Higo notification settings, RG520
  canonical profile recognition and neighbour-cell reporting.
- Defined a bounded, sanitized IPv6 evidence plan and hypothesis matrix. The
  IPv6 root cause remains `UNKNOWN`; no NAT66, proxy-NDP, fw4, odhcpd, QModem
  or policy-routing change is proposed without runtime boundary evidence.
- Defined a project-local Higo notification settings adapter contract and an
  additive RG520N-CN normalized profile contract that preserves the proven
  QMI/QMAP dial path. Defined exclusive AT/QMI ownership and a read-only,
  evidence-first neighbour-cell plan; its root cause remains `UNKNOWN`.
- Defined the proposed Run 21 changeset, build gates and RAM retest plan without
  implementing code, changing source/profile/package locks, triggering Run 21,
  starting Full or modifying the device.

### DEVICE-01R Analysis

- Added a durable Original 24.10 -> Run 20 Rescue -> expected Full feature-gap
  audit with an explicit Rescue/Full contract, per-feature frontend/backend,
  ownership, provenance, validation, dependency and priority classification.
- Preserved all accepted Rescue core evidence while clarifying that
  `DEVICE_OK=YES` and `FUNCTION_TESTED=YES` do not mean final feature
  completeness. `RESCUE_CORE_VALIDATED=YES`, `FINAL_FEATURE_COMPLETE=NO`, and
  `FULL_INTEGRATION_COMPLETE=NO` are now explicit.
- Traced the Higo notification failure to frontend routes without matching
  handlers in the current hash-pinned Lua dispatcher, and the CPE profile label
  to the generic project-seeded RG520N-CN profile lacking a canonical shared
  Higo/QModem mapping. LAN-client IPv6 and neighbour cells remain accurately
  `ROOT_CAUSE=UNKNOWN` with narrowed boundaries and explicit evidence plans.
- Confirmed read-only on the restored original system that the original Full
  package set includes wrtbwmon, OAF, fancontrol, DiskMan, KSMBD, UPnP, DDNS,
  Watchcat and ZeroTier foundations. Presence was not promoted to function
  evidence, and unknown source SHAs remain unknown.
- No firmware/config/source lock was changed; no Run 21, Full build, device
  write or mutating AT command was performed.

### DEVICE-01B Validation

- Completed the mandatory power-cycle recovery test. The device returned to the
  original ImmortalWrt `24.10-SNAPSHOT` / Linux `6.6.94` system with its
  squashfs/F2FS storage layout, five-partition eMMC layout, Higo, LuCI, SSH,
  both radios and RG520/QMI data path intact. The original 2.4/5 GHz channels
  are 6/44, and the Run 20 embedded build-identity file is absent as expected.
  No persistent eMMC, GPT, U-Boot, BL2, factory or modem change was found.
- DEVICE-01 RAM validation is recorded as `PASS_WITH_KNOWN_ISSUES` with
  `RAM_BOOT_OK=YES`, `DEVICE_OK=YES`, and power-cycle recovery passed. It remains
  `REVIEW_REQUIRED` because LAN-client IPv6, Higo notification operations, CPE
  profile recognition and neighbour-cell reporting have explicit unresolved
  results; no repair or new build is implied by this evidence update.
- Run 20 Rescue passed independent real-client tests on both 2.4 GHz and 5 GHz:
  association, DHCP lease, Higo access through Wi-Fi, and Internet traffic all
  succeeded on each band. Both Wi-Fi gates are `FUNCTION_TESTED`; unrelated
  device gates retain their independently observed status.
- Authenticated Higo login, dashboard, system status and 5G/signal reads passed.
  Device/connection/application widgets lacked useful data, and the CPE current
  configuration reported an unrecognized 4G/5G profile; these remain explicit
  feature/integration gaps rather than being hidden by the working data path.
- Authenticated LuCI Overview, network-interface and system-log reads passed;
  Higo and LuCI were usable concurrently on their required ports.
- Higo CPE connection status displayed correctly. SMS, SIM, band-lock and
  traffic-management pages reached `UI_OK` for read-only display; their
  mutating operations remain untested. The neighbour-cell page repeatedly
  reported no neighbour data despite registration, and the existing
  unrecognized-current-profile gap remained visible.
- Higo logs and the safe terminal `uptime` command passed. A runtime scheduled
  task was created successfully and then deleted; no residual task state was
  found and the original partition remained read-only. The notifications page
  rendered, but every attempted operation failed with a `not found` system
  configuration error, establishing a backend integration gap.
- The same Run 20 initramfs remained stable for about 15h57m with its embedded
  identity unchanged, persistent root still tmpfs, original squashfs still
  read-only, core services/interfaces running, and RG520/QMAP Internet intact.
  The bounded review found no panic, oops, service crash, modem reset or QMI
  failure.
- Run 20 device-side cellular IPv6 passed, but a real LAN client with RA-derived
  IPv6 addresses and a live default route could not reach an external numeric
  IPv6 endpoint by ICMP or HTTPS. The LAN-client IPv6 data path is a recorded
  `FAIL`, distinct from the working device-side path and not attributed only to
  DNS or ICMP filtering.
- The user unintentionally performed one 5 GHz channel write and one AT command.
  Read-only follow-up found the channel at 44, the initramfs root in tmpfs, the
  original partition read-only, and Wi-Fi/RG520/data paths healthy. The channel
  write is runtime-only for this boot. The command was identified as read-only
  `ATI`; it returned module identification without changing modem configuration
  or interrupting the observed QMI/QMAP data path.
- Added project-scoped credential authorization to `AGENTS.md`. Explicitly
  provided or securely configured local H5000M credentials may be reused for
  ordinary project authentication without repeated authorization, while
  plaintext storage/logging/transmission remains prohibited and all persistent
  or destructive device-operation gates remain unchanged.

### Pre-RAM-Boot Readiness

- Corrected the readiness model for the device's confirmed
  `Yuzhii0718/bl-mt798x-dhcpd` Recovery WebUI path. `Load initramfs`, rather
  than manual TFTP/load-address/`bootm`/`booti`, is the selected temporary RAM
  boot mechanism; manual RAM address and boot-command fields remain in the
  ledger as `NOT_REQUIRED_FOR_WEBUI_PATH` for auditability.
- Recorded the permanent current constraint `NO_TTL = YES` and
  `NO_SERIAL_CONSOLE = YES`; absence of TTL is not a device failure.
- Reconfirmed the exact Run 20 image size and SHA256 locally. The user-confirmed
  Recovery WebUI and its visible `Load initramfs` function agree with upstream
  documentation for booting OpenWrt/ImmortalWrt initramfs images.
- Separated `Load initramfs` from prohibited persistent WebUI functions,
  including firmware, U-Boot, BL2 and Factory updates, Flash Editor,
  Environment Manager and UBI management.
- DEVICE-01A is ready for the mandatory user-operated RAM boot. Codex has not
  entered U-Boot, uploaded or started an image, rebooted the device, or modified
  persistent storage. Power-cycle recovery is design-confirmed and remains to
  be function-tested at the end of DEVICE-01B.

## Rebuild V1 / BUILD-02

### Project Memory

- Added durable repository rules in `AGENTS.md`.
- Added the H5000M firmware engineer SOP Skill.
- Added concise reference evidence, asset, and migration maps.

### Source

- Starting project commit: `de73dcd2090a2d28c593f77a3f2882029d086d47`.
- Candidate source locks are unchanged from BUILD-01.5.

### Added

- Exact resolved-config, Higo payload/install-tree, native board and image gates.
- Per-build firmware identity, manifest, build report and SHA256SUMS generation.
- Run-specific GitHub Actions artifact identity and retained build log.
- A deterministic 60-file frontend tree digest beside the preserved canonical
  historical frontend payload digest.
- Codex Resource / Quota Governance: healthy long-running external builds enter
  `WAITING_EXTERNAL`, repeated polling is prohibited, context is preserved
  before waiting, resume requires Context Reload, and quota optimization cannot
  weaken validation or evidence requirements. This is project governance, not
  a firmware functional change.
- Added the Formal Build Ledger Rule for durable `SUCCESS`, `FAILURE`, and
  `CANCELLED` build records without deleting earlier failed-run evidence.
- Added the Package / Integration Provenance Rule, including Origin/Ownership
  categories and mandatory adaptation, validation, issue, and update history.
- Clarified the non-overlapping responsibilities of `CHANGELOG.md`,
  `docs/PACKAGES.md`, `docs/HIGO-FEATURES.md`, and the candidate/stable locks,
  and preserved the permanent upstream-to-safe-persistent project mainline.

### Fixed

- ERROR: Run 19 (ID `33828304097`, attempt 1, project
  `8bb925f39f27b547fd0b5d065fd5cd9ec20552b8`, Rescue/candidate, FAILURE after
  about 1h52m) completed `make world` through `checksum`, then the project
  artifact gate reported no H5000M initramfs image. ROOT CAUSE: artifact
  collection and manifest generation assumed an `.itb` suffix, while the
  locked H5000M image definition inherits the generic
  `-initramfs-kernel.bin` suffix. DOWNSTREAM ERROR: BUILD-MANIFEST,
  BUILD-REPORT, SHA256SUMS and success upload were not produced. WARNINGS: the
  Node.js 20 Actions deprecation and unselected package dependency warnings are
  deferred and were not causal. REPAIR: select and hash the exact H5000M
  `initramfs-kernel.bin` output without changing source locks, configuration,
  packages, or acceptance gates. REPAIR COMMIT: `78f622f`. Next Run: Run 20,
  ID `33836565597`, attempt 1, project `698aecdc52218c3565239e97bfd224b6c4af8f02`,
  Rescue/candidate.
- ERROR: Run 18 passed every source/config/H5000M/Higo/RG520 gate, then failed
  before download at unsupported make target `kernelversion`. ROOT CAUSE: this
  ImmortalWrt tree exposes evaluated variables through the generic `val.%`
  target. CHANGED FILES: `scripts/build.sh`, `scripts/generate-manifest.sh`.
  BEFORE: `make kernelversion`; AFTER: `make val.LINUX_VERSION`. IMPACT: build
  identity only; no firmware selection or source/package behavior change.
  EVIDENCE: Run 18 diagnostics and locked `include/toplevel.mk`.
- ERROR: Run 17 failed the resolved-config gate before compile because
  `CONFIG_PACKAGE_mt7992-23-firmware` resolved to not selected. ROOT CAUSE: the
  requested symbol omitted the kernel-package `kmod-` prefix; the native device
  definition and mt76 Makefile use `kmod-mt7992-23-firmware`. CHANGED FILES:
  `configs/rescue.config`, `scripts/validate-config.sh`. BEFORE: invalid symbol.
  AFTER: exact package symbol. IMPACT: restores the mandatory MT7992 firmware
  gate; no source lock, Higo, RG520 or network behavior change. EVIDENCE: Actions
  Run 17 first causal error and locked source Makefiles.
- ERROR: workflow dispatch returned HTTP 404 before creating a run. ROOT CAUSE:
  BUILD-02 used a workflow filename not registered on the default branch.
  CHANGED FILE: `.github/workflows/build-h5000m-private.yml`. FIX: place the
  branch workflow at the already registered path and hard-code the authorized
  candidate source while retaining the accepted Rescue profile input. IMPACT:
  CI dispatch only; no source lock, Higo, RG520, network or Wi-Fi change.
- Feed preparation now indexes exact locked commits and verifies every feed HEAD
  before package installation; the previous branch-index/late-checkout sequence
  could leave stale indexes even when final Git HEADs appeared locked.
- Rescue explicitly requests uhttpd, dnsmasq, USB3 and the MT7996 driver so
  `defconfig` cannot silently rely on target defaults for mandatory gates.

### Changed

- Repository state, not chat history, is now the authoritative project memory.
- Parallel compile now retries once with `-j1 V=s` to preserve the real root
  cause, without ignoring failure or reducing the Rescue target.
- Failed runs upload available requested/resolved configs and logs under a
  diagnostics-only artifact name; they cannot be confused with firmware.

### Build

- Run 17 (`33827585087`): FAILURE at resolved config; corrected the MT7992
  firmware symbol.
- Run 18 (`33827939372`): FAILURE after gates; corrected kernel identity target
  invocation.
- Run 19 (`33828304097`): FAILURE after successful compile; corrected the
  H5000M initramfs artifact suffix selector.
- Run 20 (`33836565597`), attempt 1: SUCCESS on project
  `698aecdc52218c3565239e97bfd224b6c4af8f02`, branch `rebuild-v1`, profile
  `rescue`, source `candidate`, locked ImmortalWrt
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`.
- Run 20 passed exact source/feed preparation, double apply/idempotence,
  defconfig, resolved config, H5000M, Higo, RG520/QModem, compile, artifact
  generation and upload.

### Artifacts

- `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`
  (`19778796` bytes), SHA256
  `af4f129d68cbb0b2e6d06ed2dbccd64e100bc7403cf69f62b95093d7e86af13e`.
- `BUILD-MANIFEST.json`, `BUILD-REPORT.md`, `resolved.config`, and
  `SHA256SUMS` were present and all recorded hashes verified locally.
- The FIT ramdisk contains `/etc/h5000m-build.json`; its Run ID/number,
  project SHA, ImmortalWrt SHA and Rescue profile match Run 20 and the manifest.

### Validation

- SOURCE_LOCKED: CONFIRMED
- CONFIG_RESOLVED: CONFIRMED
- BUILD_OK: CONFIRMED (single Linux clean Rescue/candidate build)
- RAM_BOOT_OK: UNVERIFIED
- DEVICE_OK: UNVERIFIED
- FUNCTION_TESTED: UNVERIFIED

### Reproducibility

- Source reconstruction: CONFIRMED.
- Configuration resolution: CONFIRMED.
- Single Linux clean Rescue/candidate build: CONFIRMED.
- Byte-for-byte reproducibility: UNVERIFIED; Run 20 is one clean build and no
  second-build binary comparison was performed.

### Known Issues

- The optional kernel-version identity field is empty and explicitly listed as
  UNKNOWN in Run 20's manifest/report. Exact project/source revision, target,
  profile and Run identity are present and consistent; this does not weaken the
  BUILD-02 acceptance gates.
- Runtime Higo, RG520/QMAP, Wi-Fi, IPv6 and device behavior remain untested by
  this build and belong to DEVICE-01.

### Deferred

- All device, RAM boot, persistent installation, Full-profile, and upstream
  update work remains outside BUILD-02.

## Rebuild V1 / BUILD-01.5

### Source Locked

- Locked QModem 3.2.0-r1 to FUjr/QModem commit `c1db0fe2067955d6b9c6b43efff1b69259f4b096`.
- Locked `qmi_wwan_q` 1.5-r1 to the same source commit, which contains RG520
  `2c7c:0801`, QMAP and Linux 6.x compatibility code.

### Static Validated

- Fresh ImmortalWrt, four standard feeds and QModem checkouts matched every
  candidate SHA.
- `prepare.sh` fetch-only mode completed without historical workspace input.
- `apply.sh` passed all five H5000M baseline checks, installed Higo, and
  detected an identical second application.
- Rescue selections and package definitions were statically closed. GNU Make
  and a Linux build environment are unavailable on this host, so
  `make defconfig` remains explicitly blocked rather than reported as passed.

### Push Authorized

- The project owner explicitly authorized storing and pushing the proprietary
  Higo runtime payload; device-unique data and credentials remain forbidden.

### Remaining Unknown

- OpenAppFilter and wrtbwmon exact source commits remain outside Rescue closure.
- The post-`defconfig` resolved configuration remains unverified until run in a
  Linux build environment.

## Rebuild V1 / BUILD-01

### Added

- Independent `h5000m-firmware` Git project, source locks, profiles, scripts and
  GitHub Actions workflow skeleton.

### Migrated

- H5000M Rescue baseline through the locked native board port.
- Hash-matched Higo package, RG520 fixed profile, QMAP redial protection,
  network/Wi-Fi defaults and Higo/LuCI dual-entry configuration.

### Changed

- Long-lived workflow logic is separated into `scripts`, `patches`, `package`
  and `files` rather than embedded in workflow YAML.

### Deferred

- Actual build and RAM hardware validation.
- Exact feed, QModem, qmi_wwan_q and optional package source locks.
- QModem long-term reconnect/scanner cleanup, device list/wrtbwmon and
  OpenAppFilter integration, DiskMan/KSMBD and other Full validation.
- eMMC/sysupgrade safety.

### Known Issues

- Historical latest-full proved RG520 first dial, not reconnect reliability.
- Historical Wi-Fi defaults are intentionally open for isolated RAM testing.
- The historical GPT warning remains out of scope; no disk write is permitted.
