# Changelog

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

### Fixed

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

- GitHub Actions Run ID/number/attempt/result: pending.

### Artifacts

- Pending first reproducible Rescue artifact.

### Validation

- SOURCE_LOCKED: CONFIRMED
- CONFIG_RESOLVED: UNVERIFIED
- BUILD_OK: UNVERIFIED
- RAM_BOOT_OK: UNVERIFIED
- DEVICE_OK: UNVERIFIED
- FUNCTION_TESTED: UNVERIFIED

### Known Issues

- Linux defconfig and compile gates have not yet run for this project.

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
