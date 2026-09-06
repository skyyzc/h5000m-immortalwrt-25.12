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

- `CURRENT_PHASE`: `IPV6-RUN23-DISPATCH-REPAIR-01 / IMPLEMENTED`
- `CURRENT_TASK`: The Run 22 hotplug logical-interface mismatch has the
  Owner-approved minimal implementation and realistic fixture repair. Static
  gates pass; stop before any Run 23 build or device action.
- `CURRENT_RUN`: workflow `Build H5000M firmware`; Run ID `33987589482`; Run
  Number `22`; Attempt `1`; branch `rebuild-v1`; project SHA
  `ca75cc3d6a9b7ce1907656d585fa1c5b283c030b`; profile `rescue`; source
  `candidate`; status `COMPLETED`; result `SUCCESS`; duration `2h28m02s`.
- `CURRENT_GATE`: `IPV6_RUN23_DISPATCH_REPAIR_PERFORMED=YES`;
  `FIXTURE_TESTS=PASS`; `STATIC_GATES=PASS`; `RUN23_BUILD_READY=YES`.
- `STOP_CONDITION`: stop after implementation/evidence commit and push. Run 23
  build, RAM boot, device lifecycle operation, Full, stable promotion and
  persistent operation remain unauthorized.
- `CURRENT_TASK_REQUIRED_FILES`: `AGENTS.md`, `PROJECT_STATE.md`, `README.md`,
  latest relevant `CHANGELOG.md` section, current summary in
  `docs/DEVICE-01-STATE.md`, and the current task specification.

## Last accepted build

- Phase: `RUN22-BUILD`
- Workflow: `Build H5000M initramfs`
- Run ID / number / attempt: `33987589482` / `22` / `1`
- Result / acceptance: `SUCCESS` / `PASS`
- Build-input project SHA:
  `ca75cc3d6a9b7ce1907656d585fa1c5b283c030b`
- ImmortalWrt SHA:
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`
- Profile / source: `rescue` / `candidate`
- Firmware:
  `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`
- Firmware size: `19975104` bytes
- Firmware SHA256:
  `bacb594c5fcbfe37e562efc8bef584a635848bc6b7e27bc87f0f8a3e85bb7d4a`
- Artifact: `h5000m-rescue-ca75cc3d-1d34e7b8-run22-attempt1`, ID
  `9977722506`, archive digest
  `sha256:c29736f4f0f7d8ff5fdb9a0555a44a81e68ffa97bf2274ea34026fbc238c4d69`.
- Detailed build ledger: latest Run 22 section in `CHANGELOG.md` and Run 22
  build-acceptance block in `docs/DEVICE-01-STATE.md`.

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

- `RUN22_BUILD_OK`: `YES`
- `RUN22_ARTIFACT_ACCEPTANCE`: `PASS`
- `RUN22_RAM_BOOT_OK`: `PASS`
- `RUN22_DEVICE_OK`: `FAIL`
- `RUN22_FUNCTION_TESTED`: `FAIL`
- `RUN22_PERSISTENT_RECOVERY_OK`: `PASS`
- Run 22 contains the exact approved IPv6 helper/hotplug bytes and permissions,
  but netifd emitted logical interface `USBv6` while the hook required
  `INTERFACE=wwan0_1`; the helper never ran and the owned LAN route was absent.
  See `docs/RUN22-EXACT-RUN-RAM-VALIDATION-REPORT.md`.

## Current firmware candidate

- `LAST_ACCEPTED_BUILD_ARTIFACT`: `RUN22` (build/artifact acceptance only;
  exact-run device/function result is failed).
- `ACTIVE_FUNCTION_CANDIDATE`: `NONE` pending a separately authorized Run 23
  build and exact-run validation.
- `LAST_FUNCTION_TESTED_RESCUE`: `RUN21`.
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
  - Run 22 exact-run evidence confirmed the IPv6 hook dispatch mismatch. The
    minimal `USBv6` logical-interface plus `wwan0_1` device-guard repair and
    realistic fixtures now pass statically; build and exact-run maturity remain
    separately gated.
  - Notification storage contract remains `UNKNOWN`; Run 21 change is `NO`.
  - Neighbour repair remains `NO`; the observed Run 20 sample was modem-raw
    empty and does not prove non-empty parser behavior.
  - Wired WAN remains environment-blocked until a cable/link test exists.

## Authorization and prohibitions

- `CURRENT_AUTHORIZATION`: the approved Run 22 dispatch-only implementation,
  static/fixture validation, evidence commit and normal fast-forward push.
- Project-scoped authentication and read-only evidence rules are in
  `AGENTS.md`; they do not authorize state-changing operations.
- `CURRENT_PROHIBITIONS`: no Run 23/build, RAM boot or device lifecycle change,
  unrelated repair, Full, stable promotion, source-lock/package/profile changes,
  sysupgrade, eMMC/GPT/U-Boot/BL2/Factory or other persistent operations.
- Persistent storage modified: `NO`.
- Full started: `NO`.

## Next gate

- `NEXT_GATE`: Owner review for Run 23 build authorization. Build and later
  exact-run RAM validation remain separate gates.
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
