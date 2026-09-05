# H5000M Current Project State

This is the compact authoritative index for current execution state. Git,
GitHub runs, artifacts, locks, and linked evidence remain authoritative for
their underlying facts; this file points to them and does not replace history.

## Project goal

- `PROJECT_GOAL`: Maintain an evolvable ImmortalWrt 25.12 H5000M firmware with
  MT7987A/MT7992 hardware adaptation, permanent Higo compatibility, LuCI
  coexistence, RG520N-CN QMI/QMAP connectivity, modular integrations, safe
  Rescue/Full validation, and eventually safe owner-authorized online update.
- Permanent mainline: upstream -> hardware adaptation -> Higo -> LuCI -> RG520
  -> optional integrations -> Rescue RAM validation -> Full -> manual stable
  promotion -> persistent deployment only after recovery and rollback proof.

## Current repository

- `CURRENT_BRANCH`: `rebuild-v1`
- `CURRENT_HEAD`: the commit containing this file; verify with
  `git rev-parse HEAD` and its tracked `origin/rebuild-v1`.
- `GOVERNANCE_02_BASELINE_HEAD`:
  `d530a8f92982e3bf7ccfce2e1eabfd327f503178`
- Exact candidate/stable locks: `versions/candidate.json` and
  `versions/stable.json`.

## Current phase and task

- `CURRENT_PHASE`: `GOVERNANCE-02`
- `CURRENT_TASK`: consolidate current state, run-scoped maturity, selective
  context retrieval, upstream lifecycle, online-update target, and modular
  plugin architecture.
- `CURRENT_RUN`: Run 21 is complete and accepted; no external run is active.
- `CURRENT_GATE`: owner review of GOVERNANCE-02 before separate Run 21 RAM
  validation authorization.
- `STOP_CONDITION`: stop after governance validation, commit, and normal push;
  do not begin RAM validation, Full, another build, or device operations.
- `CURRENT_TASK_REQUIRED_FILES`: `AGENTS.md`, `PROJECT_STATE.md`, `README.md`,
  latest relevant `CHANGELOG.md` section, current summary in
  `docs/DEVICE-01-STATE.md`, and the current task specification.

## Last accepted build

- Phase: `BUILD-03 / RUN21`
- Workflow: `Build H5000M initramfs`
- Run ID / number / attempt: `33951063311` / `21` / `1`
- Result / acceptance: `SUCCESS` / `PASS`
- Build-input project SHA:
  `ab4d2cbaa8e1b9fa8742ae397b15399f535a50d1`
- ImmortalWrt SHA:
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`
- Profile / source: `rescue` / `candidate`
- Firmware:
  `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`
- Firmware size: `19970460` bytes
- Firmware SHA256:
  `17d771fc5a1f469c0a56e5c92e8877bc0f8b700321de8860254304503b78d960`
- Detailed build ledger: latest Run 21 section in `CHANGELOG.md` and current
  Run 21 block in `docs/DEVICE-01-STATE.md`.

## Run-scoped maturity

- `RUN20_BUILD_OK`: `YES`
- `RUN20_RAM_BOOT_OK`: `YES`
- `RUN20_DEVICE_OK`: `YES`
- `RUN20_FUNCTION_TESTED`: `YES`
- Run 20 is the `LAST_FUNCTION_TESTED_DEVICE_BASELINE`.
- Detailed Run 20 device proof: `docs/DEVICE-01-STATE.md`.

- `RUN21_BUILD_OK`: `YES`
- `RUN21_ARTIFACT_ACCEPTANCE`: `PASS`
- `RUN21_RAM_BOOT_OK`: `UNVERIFIED`
- `RUN21_DEVICE_OK`: `UNVERIFIED`
- `RUN21_FUNCTION_TESTED`: `UNVERIFIED`
- `RUN21_CPE_REPAIR_BUILT`: `YES`
- `RUN21_CPE_FUNCTION_TESTED`: `UNVERIFIED`
- `RUN21_IPV6_PACKET_TOOL_BUILT`: `YES`
- `RUN21_IPV6_ROOT_CAUSE`: `UNKNOWN`
- Run 20 device maturity is not inherited by Run 21.

## Current firmware candidate

- `CURRENT_FIRMWARE_CANDIDATE`: accepted Run 21 Rescue initramfs above.
- CPE repair: display-only `[4G,5G] -> 4G + 5G` frontend normalization is built
  and hash-traced, not device-function-tested.
- IPv6 evidence tool: manual-only `tcpdump-mini 4.99.6-r1` with
  `libpcap1 1.10.6-r1` is built; no automatic capture exists.
- Higo CPE implementation evidence:
  `docs/DEVICE-01F-II-IMPLEMENTATION-REVIEW.md`.
- Component provenance: `docs/PACKAGES.md`.
- Higo gaps and next steps: `docs/HIGO-FEATURES.md`.

## Open priorities

- `OPEN_P0`: none authorized in the current governance phase.
- `OPEN_P1`:
  - Run 21 RAM validation of the CPE display repair.
  - Bounded Run 21 IPv6 packet attribution; root cause remains `UNKNOWN`.
  - Notification storage contract remains `UNKNOWN`; Run 21 change is `NO`.
  - Neighbour repair remains `NO`; the observed Run 20 sample was modem-raw
    empty and does not prove non-empty parser behavior.
  - Wired WAN remains environment-blocked until a cable/link test exists.

## Authorization and prohibitions

- `CURRENT_AUTHORIZATION`: governance/documentation edits, validation, commit,
  and normal fast-forward push to `rebuild-v1` only.
- Project-scoped authentication and read-only evidence rules are in
  `AGENTS.md`; they do not authorize state-changing operations.
- `CURRENT_PROHIBITIONS`: no build/Run 22, RAM boot, device access/change,
  Full, stable promotion, source-lock/package/profile/firmware changes,
  sysupgrade, eMMC/GPT/U-Boot/BL2/Factory or other persistent operations.
- Persistent storage modified: `NO`.
- Full started: `NO`.

## Next gate

- `NEXT_GATE`: owner-reviewed, separately authorized Run 21 Rescue RAM
  validation.
- That validation must establish Run 21 maturity independently and must not
  reuse Run 20 `RUNNING`, `UI_OK`, or `FUNCTION_TESTED` conclusions.
- Online update remains blocked and is not the next gate.

## Long-term targets

- `UPSTREAM_LIFECYCLE`: `REQUIRED`
- Lifecycle: detection -> candidate -> provenance review -> static gates ->
  build -> RAM regression -> manual stable promotion.
- `ONLINE_UPDATE_TARGET`: `REQUIRED`
- `ONLINE_UPDATE_STATUS`: `BLOCKED_BY_PERSISTENT_SAFETY`
- Prerequisites: validated Full -> storage model -> backup -> recovery ->
  rollback/failure recovery -> sysupgrade compatibility -> artifact integrity
  -> explicit owner authorization.
- `PLUGIN_ARCHITECTURE`:
  `MODULAR / OPTIONAL / INDEPENDENTLY_PROVENANCED`
- `CORE_RESCUE`: hardware adaptation, Higo/LuCI coexistence, RG520 base
  connectivity, and required hardware management foundations.
- `FULL_REQUIRED`: required Higo Full integrations and hardware/product
  functions, including fan; current candidates include wrtbwmon/Higo client
  integration, OAF, and DiskMan/KSMBD.
- `FULL_OPTIONAL`: owner-selected integrations such as ZeroTier and Watchcat.
- `FUTURE_PLUGIN`: separately selected, sourced, adapted, built, and validated.

## Context pointers

- Permanent rules: `AGENTS.md`
- Architecture/mainline: `README.md`
- Chronological history/build ledger: `CHANGELOG.md`
- Current detailed device evidence: `docs/DEVICE-01-STATE.md`
- CPE repair: `docs/DEVICE-01F-II-IMPLEMENTATION-REVIEW.md`
- Package/integration provenance: `docs/PACKAGES.md`
- Higo gap matrix: `docs/HIGO-FEATURES.md`
- Read older evidence only when the active task or a conflict requires it.
