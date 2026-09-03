# Changelog

This is the single chronological record of project changes. Build success and device validation remain separate.

## 2026-09-03 - Phase 1.1A–1.1C: Reference Evidence Governance Baseline

### Added

- Recorded Phase 1.1A's external asset/evidence map as the historical source for asset IDs AM-001–AM-035.
- Recorded Phase 1.1B's `PASS WITH CONDITIONS` result: ACTIVE, EVIDENCE, DERIVED, RECOVERY, and UPSTREAM assets are reachable by explicit path without another Source Folder.
- Added `REFERENCE_EVIDENCE.md` in Phase 1.1C as the maintained location, provenance, recoverability, protection, and access index.

### Changed

- Added permanent evidence precedence, conflict, provenance, recoverability, scoped-access, and high-risk double-evidence rules to `AGENTS.md`.
- Classified `immortalwrt-25.12` as the protected Git common-dir host for the canonical `h5000m-project` worktree.
- Kept `h5000m-project` as the only daily Codex Source Folder and documented excluded large/reference directories.
- Updated `PROJECT_STATE.md` to retain incomplete recovery evidence and prohibit the claim `FULL RECOVERY READY`.

### Validation

- Reused only Phase 1.1A/1.1B findings; no asset rescan or evidence promotion was performed.
- No firmware build, workflow dispatch, device access, or persistent write was performed.

### Known Issues

- Complete factory firmware/rootfs/overlay recovery inputs, raw boot and runtime captures, full GPT/block evidence, device-origin calibration evidence, and a complete eMMC/GPT-sector backup remain `UNKNOWN` or `PARTIAL/UNKNOWN`.
- Several legacy/derived assets retain `INFERRED` provenance or `UNKNOWN` reproducibility and must be preserved pending separate review.

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
