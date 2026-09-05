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

- `CURRENT_PHASE`: `CPE-RUN21-LIVE-BODY-01 / PARTIAL`
- `CURRENT_TASK`: human-assisted loaded-code identity is closed; live Vue
  resolver state/input/output remains the sole CPE evidence blocker.
- `CURRENT_RUN`: Run 21 RAM validation is complete; no external run is active.
- `CURRENT_GATE`: `CPE-RUN21-LIVE-STATE-01` human-assisted read-only debugger
  evidence for `F.value`, normalized networks, `Ge`, `st`, and `Tt` before
  selecting another CPE repair.
- `STOP_CONDITION`: stop after evidence synchronization, commit, and normal
  push; do not implement CPE/IPv6 repair, begin Full, build Run 22, change the
  device, or perform a persistent operation.
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
- Run 20 remains the last Rescue whose defined validation contract passed as a
  whole and is the `LAST_FUNCTION_TESTED_DEVICE_BASELINE`.
- Detailed Run 20 device proof: `docs/DEVICE-01-STATE.md`.

- `RUN21_BUILD_OK`: `YES`
- `RUN21_ARTIFACT_ACCEPTANCE`: `PASS`
- `RUN21_RAM_BOOT_OK`: `YES`
- `RUN21_DEVICE_OK`: `YES`
- `RUN21_FUNCTION_TESTED`: `NO` (mandatory CPE repair gate failed)
- `RUN21_CPE_REPAIR_BUILT`: `YES`
- `RUN21_CPE_FUNCTION_TESTED`: `NO`; live UI still displayed the unknown
  fallback even though QModem remained `3G=0,4G=1,5G=1`.
- `RUN21_IPV6_PACKET_TOOL_BUILT`: `YES`
- `RUN21_IPV6_ROOT_CAUSE`: `CONFIRMED_RETURN_ROUTE_PREFIX_COLLISION`; packet
  capture saw requests on LAN and cellular, replies on cellular but not LAN,
  and route lookup selected the cellular interface for the LAN client because
  the same delegated `/64` was installed on both interfaces.
- Run 20 device maturity is not inherited by Run 21.

## Current firmware candidate

- `CURRENT_FIRMWARE_CANDIDATE`: accepted Run 21 Rescue initramfs above.
- CPE repair: display-only `[4G,5G] -> 4G + 5G` frontend normalization is built
  and hash-traced, but its Run 21 real-device function test failed: the UI
  still shows the unknown fallback.
- IPv6 evidence tool: manual-only `tcpdump-mini 4.99.6-r1` with
  `libpcap1 1.10.6-r1` is built; no automatic capture exists.
- Higo CPE implementation evidence:
  `docs/DEVICE-01F-II-IMPLEMENTATION-REVIEW.md`.
- Component provenance: `docs/PACKAGES.md`.
- Higo gaps and next steps: `docs/HIGO-FEATURES.md`.

## Open priorities

- `OPEN_P0`: none authorized in the current governance phase.
- `OPEN_P1`:
  - CPE-RUN21-LIVE-BODY-01 proved the browser response contains the Run 21
    patched resolver and rejects stale canonical cache selection. The supplied
    excerpt is not a full byte-identical response, so its full loaded SHA256 is
    `UNKNOWN`. The title still fails; live Vue state/resolver proof remains and
    `CPE_RCA=UNKNOWN`.
  - IPv6 dynamic preferred LAN route design for the confirmed same-prefix
    return-route collision; implementation is not authorized in DEVICE-01G.
  - Notification storage contract remains `UNKNOWN`; Run 21 change is `NO`.
  - Neighbour repair remains `NO`; the observed Run 20 sample was modem-raw
    empty and does not prove non-empty parser behavior.
  - Wired WAN remains environment-blocked until a cable/link test exists.

## Authorization and prohibitions

- `CURRENT_AUTHORIZATION`: documentation/evidence edits, validation, commit,
  and normal fast-forward push to `rebuild-v1` only.
- Project-scoped authentication and read-only evidence rules are in
  `AGENTS.md`; they do not authorize state-changing operations.
- `CURRENT_PROHIBITIONS`: no build/Run 22, further RAM boot, repair
  implementation, device change, Full, stable promotion,
  source-lock/package/profile/firmware changes,
  sysupgrade, eMMC/GPT/U-Boot/BL2/Factory or other persistent operations.
- Persistent storage modified: `NO`.
- Full started: `NO`.

## Next gate

- `NEXT_GATE`: `CPE-RUN21-LIVE-STATE-01`, a minimal read-only debugger capture
  of the exact Vue network-mode object, normalized key, candidate modes,
  resolved mode, and visible-title computed value. CPE remains unready; the
  IPv6 repair design remains ready; Run 22 remains unapproved and untriggered.
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
