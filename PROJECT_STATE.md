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
- `CURRENT_PHASE=RESCUE_ENGINEERING`
- `CURRENT_GATE=OWNER_REVIEW_RUN23_RAM_FAILURE`
- `STOP_CONDITION=await Owner review of the Run 23 RAM failure evidence`
- `NEXT_GATE=OWNER_REVIEW_RUN23_RAM_FAILURE`
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
- `RUN23_CAUSAL_BOUNDARY=the exact installed USBv6/wwan0_1 hook and reconciler
  matched the accepted source, and live USBv6 exposed one shared global /64,
  but no reconciler-owned br-lan metric-1 protocol-242 route, runtime state, or
  helper log was produced after the actual interface lifecycle; failure remains
  at the hotplug dispatch-or-helper-execution boundary`
- `IPV6_SELECTED_DESIGN=DYNAMIC_PREFERRED_LAN_SHARED_PREFIX_ROUTE`
- Run 23 changes only the reviewed dispatch boundary: `USBv6` logical-interface
  lifecycle with the `wwan0_1` device guard where netifd provides it.

## Current authorization

- Run 23 RAM validation is complete and failed its primary runtime repair gate;
  no automatic repair or subsequent build is authorized.
- No runtime, firmware, config, package selection, source lock, Full, stable,
  sysupgrade, device mutation, or persistent operation is authorized.
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
