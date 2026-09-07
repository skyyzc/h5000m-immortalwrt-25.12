# H5000M Current Project State

Compact current-state index; Git, formal runs, artifacts and linked evidence
remain authoritative.

## Current repository and gate

- `ACTIVE_PRODUCT_BRANCH=rebuild-v1`
- `PROJECT_CONSOLIDATION_V2=ACCEPTED`
- `ANTI_DRIFT_CONTRACT=ACCEPTED`
- `CANONICAL_GOVERNANCE_FINAL_CORRECTION=ACCEPTED`
- `H5000M_CANONICAL_GOVERNANCE=ACCEPTED`
- `GITHUB_CANONICAL_ENTRYPOINT=PASS`
- `DISASTER_RECOVERY_CONTEXT_TEST=PASS`
- `GOVERNANCE_FREEZE=YES`
- `READY_TO_RESUME_ENGINEERING=YES`
- `CODEX_TASK_LOG_V1=IMPLEMENTED`
- `GOVERNANCE_HEAD=HEAD` (resolve the exact current identity with
  `git rev-parse HEAD`; a Git commit cannot embed its own hash)
- `RUN23_FIRMWARE_IMPLEMENTATION_SHA=32e385cbbdfeace84d7bb9032cad18c753debb21`
- `RUN23_FIRMWARE_BASELINE_PRESERVED=YES`
- `RUNTIME_DELTA_FROM_RUN23_FIRMWARE_BASELINE=NONE`
- `RUN23_BUILD_STARTED=YES`
- `H5000M_FULL_CANDIDATE_V1_SOURCE_HEAD=d05325d34fe0dbbeb48ec1b2717e8495dc1081ec`
- `CURRENT_PHASE=FULL_CANDIDATE_V1_BUILD_CLOSURE`
- `CURRENT_GATE=OWNER_REVIEW_RUN25_BUILD_CLOSURE`
- `STOP_CONDITION=await Owner review before any further build`
- `NEXT_GATE=OWNER_REVIEW_RUN25_BUILD_CLOSURE`
- Exact locks: `versions/candidate.json`, `versions/stable.json`

## Current run maturity

- `LAST_FUNCTION_TESTED_RESCUE=Run21`
- `RUN21_BUILD=PASS`; `RUN21_RAM_BOOT=PASS`;
  `RUN21_DEVICE_FUNCTION=PASS`; `RUN21_CPE_FUNCTION_TESTED=YES`
- `RUN21_IPV6_RCA=CONFIRMED_SAME_PREFIX_RETURN_ROUTE_COLLISION`

- `RUN22_BUILD=PASS`; `RUN22_ARTIFACT_ACCEPTANCE=PASS`;
  `RUN22_RAM_BOOT=PASS`; `RUN22_DEVICE_FUNCTION=FAIL`;
  `RUN22_PERSISTENT_RECOVERY=PASS`
- `RUN22_CAUSAL_BOUNDARY=netifd emitted logical INTERFACE=USBv6 over
  DEVICE=wwan0_1, while the hook required INTERFACE=wwan0_1; helper was not
  dispatched`

- `RUN23_IMPLEMENTATION=PASS`
- `RUN23_STATIC_FIXTURE=PASS`
- `RUN23_BUILD=PASS`; `RUN23_ARTIFACT_ACCEPTANCE=PASS`;
  `RUN23_RAM_BOOT=PASS`; `RUN23_DEVICE_FUNCTION=FAIL`;
  `RUN23_PERSISTENT_RECOVERY=PASS`
- `RUN23_DEVICE=FAIL`; `RUN23_ROOT_CAUSE=PROVEN`
- `RUN23_CAUSAL_BOUNDARY=the exact installed USBv6/wwan0_1 hook and reconciler
  matched the accepted source, and live USBv6 exposed one shared global /64,
  but no reconciler-owned br-lan metric-1 protocol-242 route, runtime state, or
  helper log was produced after the actual interface lifecycle; failure remains
  at the hotplug dispatch-or-helper-execution boundary`
- `RUN23_RUNTIME_OBSERVATION=PASS`; natural `ifup` reached hook 95 with
  `INTERFACE=USBv6` and `DEVICE=wwan0_1`, passed every guard, invoked the helper,
  and entered its exact original implementation.
- `RUN23_ROOT_CAUSE=the helper enables set -u before sourcing the locked
  jshn.sh; json_init calls json_cleanup, which reads unset JSON_PREFIX and exits
  with parameter-not-set status 2 before json_load or route reconciliation`
- `RUN24_FIRMWARE_IMPLEMENTATION_SHA=895b679d1778ab9a2fbde553774104df99a7c0ae`
- `RUN24_IMPLEMENTATION=PASS`; `RUN24_BUILD=FAIL`;
  `RUN24_DEVICE=UNVERIFIED`
- `RUN24_STATIC_GATES=PASS`: locked-jshn nounset regression, all 16 route
  fixtures, hotplug contract, shell syntax, double apply, exact install and
  ownership/prohibited-mutation checks passed.
- `RUN24_BUILD_RUN_ID=34041525997`; Run Number `24`, Attempt `1`, project
  `c5a3819fc237dfb07c4ad88899b339bfb9e86eea`; the Rescue build stopped before
  compile/artifact at the new jshn regression harness because its mock command
  environment was not exported reliably. This is test-infrastructure failure,
  not evidence that the Run24 production helper regressed.
- `FULL_CANDIDATE_V1_SOURCE=READY_FOR_BUILD_REVIEW`: Full external sources are
  exact-lock prepared; Core/Full profiles share one baseline; project-local fan
  and OAF compatibility packages plus unified preflight are integrated. No Full
  build or device maturity is implied.
- `RUN25_BUILD=FAIL`; Run ID `34072182262`, Run Number `25`, Attempt `1`,
  profile `both`, source `candidate`, project
  `6932baa896c9f6849d80f603fb0b53039c01166b`. Both Rescue and Full failed at
  the same shared preflight boundary after source preparation and idempotent
  apply: shell syntax validation passed the AArch64 ELF `higorosd` to `sh -n`.
  Config validation, defconfig and compile were not reached; no firmware
  artifacts were produced. Commit `d05325d34fe0dbbeb48ec1b2717e8495dc1081ec`
  classifies package payloads by declared interpreter and preserves production
  IPv6 and Full capability code unchanged. Build confirmation is pending.
- `IPV6_SELECTED_DESIGN=DYNAMIC_PREFERRED_LAN_SHARED_PREFIX_ROUTE`
- Run 23 changes only the reviewed dispatch boundary: `USBv6` logical-interface
  lifecycle with the `wwan0_1` device guard where netifd provides it.

## Current authorization

- The Full Candidate source milestone changed firmware/package/config/source
  preparation and workflow validation. A formal build, RAM/device validation,
  stable promotion, sysupgrade, device mutation, or persistent operation is not
  authorized without a separate Owner gate.
- `PERSISTENT_STORAGE_MODIFIED=NO`; `FULL_STARTED=NO`.

## Durable pointers

- Highest policy: `H5000M-PROJECT-CHARTER.md`
- Product domains/status: `docs/PRODUCT-MATRIX.md`
- Vendor migration: `docs/VENDOR-COMPATIBILITY-MATRIX.md`
- Agent execution/safety: `AGENTS.md`
- Chronology/formal run ledger: `CHANGELOG.md`
- Device/run evidence: `docs/DEVICE-01-STATE.md`
- Higo gaps: `docs/HIGO-FEATURES.md`
- Component provenance: `docs/PACKAGES.md`
- Run 22 failure: `docs/RUN22-EXACT-RUN-RAM-VALIDATION-REPORT.md`

## Automation follow-up

- `RUN_LEDGER_STATUS=DEFERRED_AFTER_RUN23`: the durable ledger remains in
  CHANGELOG/evidence; schema/generator automation is a later isolated change.
- `CAPABILITY_MANIFEST_STATUS=DEFERRED_AFTER_RUN23`: integrating the new product
  matrices into build output requires separate review of the formal build
  contract.
