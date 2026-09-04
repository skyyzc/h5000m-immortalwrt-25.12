# Changelog

## Rebuild V1 / DEVICE-01A

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
