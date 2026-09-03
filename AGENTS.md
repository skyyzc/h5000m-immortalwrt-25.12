# H5000M project rules

This file is the permanent operating contract for maintainers and coding agents.

## Start every task

1. Read this file and `PROJECT_STATE.md` first.
2. Read only files related to `Current Task`; expand scope only when evidence is insufficient.
3. Do not repeat a whole-repository audit unless the user explicitly requests one.
4. Treat the two V1 baseline/remediation reports as historical inputs, not mandatory daily context.

## Permanent requirements (UR-01–UR-20)

- **UR-01:** Target Hiveton H5000M on ImmortalWrt 25.12 while retaining Higo as completely as practical.
- **UR-02:** Quectel RG520N-CN is core hardware; preserve its USB/QMAP, dialling and recovery path.
- **UR-03:** Keep both `rescue` and `full` build profiles.
- **UR-04:** Never silently remove a Higo page, API, dependency or user-visible function. Record any loss, reason and recovery direction.
- **UR-05:** Build success is not device validation. Never present inference, package presence or service startup as functional validation.
- **UR-06:** Use these exact evidence levels: `CONFIGURED`, `BUILT`, `INSTALLED`, `RUNNING`, `UI_OK`, `FUNCTION_TESTED`.
- **UR-07:** Mark unknown or untested claims as `UNKNOWN` or unverified; never turn assumptions into facts.
- **UR-08:** Every functional, configuration, dependency or workflow change must update `CHANGELOG.md`.
- **UR-09:** Every task must leave `PROJECT_STATE.md` reflecting results, blockers, current and next tasks.
- **UR-10:** Update `README.md` when user-visible behavior, plugin/version data, compatibility, build usage or validation changes.
- **UR-11:** Keep device, source version and technical-route summaries current in README.
- **UR-12:** Keep the Higo matrix current, including retained/missing/incompatible functions, reasons and direction.
- **UR-13:** Keep actually built major plugins, purpose and traceable source/version in README and state.
- **UR-14:** Pin build inputs where practical. Label upstream-following inputs and drift risk explicitly.
- **UR-15:** A QModem compatibility-patch failure should normally warn and preserve upstream behavior, not block all builds without a safety reason.
- **UR-16:** Upstream updates follow `candidate -> build -> RAM test -> manual promote`; never auto-promote an untested candidate.
- **UR-17:** GitHub Actions remains the reproducible build path. Record meaningful builds, updates and optimizations with run/artifact identity.
- **UR-18:** No GPT, U-Boot, sysupgrade, partition or persistent-device write without explicit approval and a verified recovery path.
- **UR-19:** Do not default-scan full U-Boot/ImmortalWrt reference trees, factory materials, backups, generated directories or all Higo assets.
- **UR-20:** Preserve factory backups and rescue materials. Deletion, bulk movement or history rewriting requires explicit approval.

## Evidence and change gates

- Status advances only with evidence: `CONFIGURED -> BUILT -> INSTALLED -> RUNNING -> UI_OK -> FUNCTION_TESTED`.
- Core code/workflow/plugin/device-config changes require a `CHANGELOG.md` check.
- User-visible feature/version/compatibility changes require a `README.md` check.
- Build, test or validation-state changes require a `PROJECT_STATE.md` check.
- Run `scripts/check-h5000m-governance.sh` before committing.

## Reference Evidence Policy

- `REFERENCE_EVIDENCE.md` is the index for external evidence location, provenance, recoverability, protection, and access timing.
- **ACTIVE:** by default read only `AGENTS.md`, `PROJECT_STATE.md`, and files directly related to Current Task.
- **EVIDENCE:** read by explicit path only when Current Task involves the corresponding function.
- **DERIVED:** use as analysis assistance only; never unconditionally replace available original evidence with a derived asset.
- **RECOVERY:** read only for approved recovery, high-risk write, partition, or boot-chain tasks. Verify the backup integrity manifest first.
- **UPSTREAM:** read only for scoped build, source, kernel, plugin, or U-Boot tasks.
- Do not recursively scan large EVIDENCE, RECOVERY, DERIVED, or UPSTREAM trees by default. “Not read by default” does not mean “not permitted to use.”
- Fact precedence is: current-device original evidence > verified original backup > original-firmware extract > traceable DERIVED analysis > `PROJECT_STATE.md` / `README.md` > historical chat / model memory.
- If high-confidence evidence conflicts, mark the fact `CONFLICT / UNKNOWN`, do not choose automatically, stop any dependent high-risk operation, and obtain more evidence.
- Critical derived assets should trace `SOURCE -> EXTRACTED -> DERIVED`; if the chain is not confirmed, mark it `UNKNOWN`. Never call a derived report original evidence.
- Recoverability labels are `IRREPLACEABLE`, `REGENERATABLE`, `REDOWNLOADABLE`, and `UNKNOWN`. Never delete, overwrite, modify, or automatically organize `IRREPLACEABLE` assets. Before deleting `REGENERATABLE` assets, verify inputs and method. `REDOWNLOADABLE` requires a traceable repository/URL plus version, tag, or SHA.

## Git worktree protection

- `h5000m-project` and `immortalwrt-25.12` share Git repository/worktree management. `h5000m-project\.git` points to `C:/Users/skyyz/Documents/Codex/2026-09-01/w/work/immortalwrt-25.12/.git/worktrees/h5000m-project`.
- Treat `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\immortalwrt-25.12` as **GIT COMMON-DIR HOST / PROTECTED**, not as a disposable or redownloadable cache.
- Without specific approval and a migration plan, do not move, delete, recreate, reclone over, `reset --hard`, clean, modify `.git/worktrees`, or perform any Git management operation that could break the canonical worktree.

## High-risk evidence gate

- Before changing or writing DTS/DTB, MTD, GPT, partitions, U-Boot, bootloader, sysupgrade, persistent flashing, backup/restore, or the recovery chain, re-read the applicable current-device/original evidence.
- Critical hardware, partition, and boot-chain conclusions require in principle two independent evidence sources, for example MTD/block + DTB/DTS or GPT + boot log/bootloader evidence.
- One source alone must not be promoted to `CONFIRMED`. Conflicting high-confidence sources require `CONFLICT / UNKNOWN` and a stop to the high-risk operation.

## Source Folder policy

- Keep `h5000m-project` as the only daily Codex Source Folder. Phase 1.1B confirmed external ACTIVE, EVIDENCE, DERIVED, RECOVERY, and UPSTREAM assets are reachable by exact path; no additional Source Folder is needed.
- Unless the Codex access model changes and is revalidated, do not add `immortalwrt-25.12`, `bl-mt798x-dhcpd`, `h5000m-materials`, `overlay-inspect`, `outputs\h5000m-backup`, large Higo assets, `build_dir`, `staging_dir`, `tmp`, `dl`, `bin`, caches, or logs as daily Source Folders.

## Scope and safety

- This repository is the canonical GitHub project worktree. ImmortalWrt/U-Boot trees are read-only references.
- Factory materials and device backups are protected references; never publish, delete or relocate them implicitly.
- Ignore routine `build_dir`, `staging_dir`, `tmp`, `dl`, `bin`, caches, logs, extracted overlays and generated artifacts unless needed.
- Do not reformat or inspect unrelated proprietary/minified Higo assets.
- Prefer RAM boot tests and identify the exact profile, Actions run and artifact in every test record.
- Preserve unrelated user changes. Do not trigger firmware builds unless requested or approved.
