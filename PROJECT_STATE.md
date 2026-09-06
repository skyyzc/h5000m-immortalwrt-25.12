# H5000M Current Project State

Compact current-state index; Git, formal runs, artifacts and linked evidence
remain authoritative.

## Current repository and gate

- `ACTIVE_PRODUCT_BRANCH=rebuild-v1`
- `RUN23_FIRMWARE_IMPLEMENTATION_SHA=32e385cbbdfeace84d7bb9032cad18c753debb21`
- `RUN23_BUILD_STARTED=NO`
- `CURRENT_PHASE=PROJECT_CONSOLIDATION_V2`
- `CURRENT_GATE=DOCUMENTATION_GOVERNANCE_ONLY`
- `STOP_CONDITION=commit/push consolidation; no build or device operation`
- `NEXT_GATE=OWNER_REVIEW_PROJECT_CONSOLIDATION_V2`
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
- `RUN23_BUILD=NOT_STARTED`
- `RUN23_DEVICE=UNVERIFIED`
- `IPV6_SELECTED_DESIGN=DYNAMIC_PREFERRED_LAN_SHARED_PREFIX_ROUTE`
- Run 23 changes only the reviewed dispatch boundary: `USBv6` logical-interface
  lifecycle with the `wwan0_1` device guard where netifd provides it.

## Current authorization

- Governance/documentation consolidation only.
- No runtime, firmware, config, package selection, source lock, build, RAM boot,
  Full, stable, sysupgrade, device, or persistent operation is authorized.
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
