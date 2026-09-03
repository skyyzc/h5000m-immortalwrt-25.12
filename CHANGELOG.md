# Changelog

This is the single chronological record of project changes. Build success and device validation remain separate.

## 2026-09-03 - Phase 1: Project Governance Baseline

### Added

- Permanent maintainer/agent rules in `AGENTS.md`.
- Concise current-state entry point in `PROJECT_STATE.md`.
- Lightweight local governance documentation check.

### Changed

- Reworked README as a current project guide instead of a historical log.
- Defined the canonical project worktree and separated upstream references, factory materials and backups conceptually.
- Reduced routine scan scope with project rules and generated-output ignores.

### Fixed

- Separated `CONFIGURED`, `BUILT`, `INSTALLED`, `RUNNING`, `UI_OK` and `FUNCTION_TESTED` claims.
- Removed the stale implication that Actions #16 was still building; final status is `UNKNOWN` pending evidence.
- Distinguished the workflow build branch/kernel line from newer upstream content visible on `master`.

### Build

- No firmware build was triggered.
- `.github/workflows/build-h5000m-private.yml` remains active; build logic was unchanged.

### Validation

- No new device validation was performed.
- Existing RAM-test evidence was normalized without promoting package/service presence to function success.

### Known Issues

- OpenAppFilter/wrtbwmon revisions and standard feeds are not fully pinned.
- Exact identity of the most recently tested `full` artifact is unknown.
- Higo device-list/application-filter compatibility is incomplete.
- Persistent eMMC/sysupgrade and rollback remain unverified and out of scope.
