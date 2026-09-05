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

- `CURRENT_PHASE`: `IPV6-RUN22-IMPLEMENTATION-01 / COMPLETE`
- `CURRENT_TASK`: the reviewed IPv6-only dynamic preferred LAN shared-prefix
  route helper, iface lifecycle hook, deterministic fixtures, and static/build
  gates are implemented; stop for owner review without building Run 22.
- `CURRENT_RUN`: Run 21 RAM validation is complete; no external run is active.
- `CURRENT_GATE`: `IPV6_IMPLEMENTATION_COMPLETE=YES`;
  `RUN22_CHANGESET_READY=YES`; `STATIC_GATES_PASS=YES`;
  `BUILD_WORTH_TRIGGERING=YES`. Run 22 remains separately unauthorized and
  untriggered.
- `STOP_CONDITION`: stop after implementation/evidence synchronization,
  validation, commit, and normal push; do not build Run 22, begin Full, change
  the device, or perform a persistent operation.
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
- Run 20 remains the prior function-tested Rescue baseline; Run 21 below is
  the latest Rescue whose defined validation contract passed as a whole.
- Detailed Run 20 device proof: `docs/DEVICE-01-STATE.md`.

- `RUN21_BUILD_OK`: `YES`
- `RUN21_ARTIFACT_ACCEPTANCE`: `PASS`
- `RUN21_RAM_BOOT_OK`: `YES`
- `RUN21_DEVICE_OK`: `YES`
- `RUN21_FUNCTION_TESTED`: `YES` (mandatory CPE repair gate closed by the
  later exact-run paused-scope and resumed visible-title evidence)
- `RUN21_CPE_REPAIR_BUILT`: `YES`
- `RUN21_CPE_FUNCTION_TESTED`: `YES`; live state resolved `mode=auto` and
  `[4G,5G]` to `4G + 5G`, and the resumed UI visibly displayed that title.
- `RUN21_IPV6_PACKET_TOOL_BUILT`: `YES`
- `RUN21_IPV6_ROOT_CAUSE`: `CONFIRMED_RETURN_ROUTE_PREFIX_COLLISION`; packet
  capture saw requests on LAN and cellular, replies on cellular but not LAN,
  and route lookup selected the cellular interface for the LAN client because
  the same delegated `/64` was installed on both interfaces.
- Run 20 device maturity is not inherited by Run 21.

## Current firmware candidate

- `CURRENT_FIRMWARE_CANDIDATE`: accepted Run 21 Rescue initramfs above.
- CPE repair: display-only `[4G,5G] -> 4G + 5G` frontend normalization is built,
  hash-traced, and function-tested on Run 21. The earlier unknown-title
  observation is retained as a non-reproduced timing/state discrepancy.
- IPv6 evidence tool: manual-only `tcpdump-mini 4.99.6-r1` with
  `libpcap1 1.10.6-r1` is built; no automatic capture exists.
- Higo CPE implementation evidence:
  `docs/DEVICE-01F-II-IMPLEMENTATION-REVIEW.md`.
- Component provenance: `docs/PACKAGES.md`.
- Higo gaps and next steps: `docs/HIGO-FEATURES.md`.

## Open priorities

- `OPEN_P0`: none authorized in the current governance phase.
- `OPEN_P1`:
  - CPE live-state evidence proved the Run 21 resolver and computed/rendered
    title produce `4G + 5G`. The earlier unknown-title observation remains a
    `PARTIAL_TIMING_OR_STATE_EVALUATION_BOUNDARY`; no additional CPE repair is
    currently required.
  - IPv6 dynamic preferred LAN route implementation for the confirmed
    same-prefix return-route collision is statically ready; Run 22 build and
    exact-run RAM/lifecycle validation require separate owner authorization.
  - Notification storage contract remains `UNKNOWN`; Run 21 change is `NO`.
  - Neighbour repair remains `NO`; the observed Run 20 sample was modem-raw
    empty and does not prove non-empty parser behavior.
  - Wired WAN remains environment-blocked until a cable/link test exists.

## Authorization and prohibitions

- `CURRENT_AUTHORIZATION`: completed IPv6-only implementation, static
  validation, documentation/evidence edits, commit, and normal fast-forward
  push to `rebuild-v1`; no build or device action.
- Project-scoped authentication and read-only evidence rules are in
  `AGENTS.md`; they do not authorize state-changing operations.
- `CURRENT_PROHIBITIONS`: no build/Run 22, further RAM boot, device change,
  Full, stable promotion,
  source-lock/package/profile/firmware changes,
  sysupgrade, eMMC/GPT/U-Boot/BL2/Factory or other persistent operations.
- Persistent storage modified: `NO`.
- Full started: `NO`.

## Next gate

- `NEXT_GATE`: owner review for Run 22 build authorization. The IPv6-only
  implementation and static gates pass; Run 22 is untriggered.
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
