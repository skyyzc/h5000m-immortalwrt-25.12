# Changelog

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
