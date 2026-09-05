# ENGINEERING-EFFICIENCY-01

Date: 2026-09-06

## Purpose and preserved governance

This governance-only phase reduces duplicate retries, builds, context reads,
owner interruptions, and unnecessary cross-item blocking without weakening
evidence. Existing three-layer reload, run-scoped maturity, issue closure,
vendor UI live-path proof, client diversity, authentication/host-key/session
rules, provenance/build ledgers, quota governance, Rescue/Full boundaries,
manual promotion, RAM-first testing, modem ownership, durable sanitization, and
persistent safety remain authoritative.

## Added execution rules

`AGENTS.md` now permanently defines:

- `EFFICIENCY_MUST_NOT_WEAKEN_EVIDENCE`: less duplicate work must still reach
  the same evidence and acceptance outcome.
- `ISSUE_SEVERITY_ROUTING`: `SEV_CORE`, `SEV_INTEGRATION`, and `SEV_OPTIONAL`
  tune execution depth without replacing `OPEN_P0/P1` or independent evidence.
- `BATCH_WHEN_READY_RULE` and `BUILD_EFFICIENCY_GATE`: batch only closed,
  designed, compatible changes with a concrete build/RAM acceptance contract.
- `DEFER_NON_BLOCKING_GAPS`: durable deferral is allowed but is never closure.
- `PLUGIN_BATCH_INTEGRATION_RULE`: a batch shares infrastructure, never package
  provenance or maturity.
- `NO_BLIND_RETRY_RULE`, stall classifications, and `NO_SILENT_SKIP_RULE`:
  retry according to information gain and never lose a required gate.
- `HUMAN_ASSIST_GATE`, its fixed request/return contracts, and
  `DEPENDENCY_AWARE_CONTINUATION`: request the minimum owner action and resume
  only the blocked branch while independent work continues.
- `TEMP_DIAGNOSTIC_LIFECYCLE` and `GOVERNANCE_ANTI_BLOAT`: temporary evidence
  stays temporary unless deliberately promoted; governance uses existing file
  responsibilities and avoids a phase/document per minor item.

## Current CPE human-assist continuation

```text
HUMAN_ASSIST_REQUIRED=YES
ASSIST_ID=CPE-RUN21-LIVE-BODY-01
BLOCKED_GATE=CPE browser-evaluated resource identity
BLOCKER_CLASS=BROWSER_EVIDENCE_LIMIT
WHY_HUMAN_IS_NEEDED=current browser tooling exposes the request URL but not the evaluated response body
WHAT_CODEX_ALREADY_PROVED=API/QModem agree; device serves Run21 patched chunk; new tab still shows 未识别配置
WHAT_CODEX_ALREADY_TRIED=isolated in-app tab, resource inventory, server-byte/hash and cache-metadata capture
OWNER_ACTION_EXACT=fresh/private desktop browser DevTools Network capture for the exact CPE chunk
EXPECTED_EVIDENCE=response body or HAR with content, or equivalent debugger resolver/live-input proof
RETURN_TO_CODEX=the exported local evidence file
DO_NOT=save/apply CPE; change network/APN/bands; reboot; flash; perform persistent actions
SENSITIVE_DATA_HANDLING=keep credentials and identifiers local; Codex sanitizes durable records
RESUME_CONDITION=loaded code identity or evaluated resolver/live-input branch becomes directly provable
INDEPENDENT_WORK_CAN_CONTINUE=YES
```

Codex already proved the authenticated API and QModem semantics agree, the
device currently serves the Run 21 patched CPE chunk, and a new browser tab
still displays `未识别配置`. The browser evidence interface did not expose the
already evaluated response body. `CPE_RCA=UNKNOWN`,
`CPE_REPAIR_UNBLOCKED=NO`, and `CPE_LOADED_CHUNK_IDENTITY=UNKNOWN` remain.

Owner action for the next separately authorized task: use a fresh/private
desktop browser; open Developer Tools -> Network before entering `/cpe`; enable
Disable cache while DevTools is open if available; load `/cpe` once; select the
exact `CPEManagement-CuEyMeyg.js` request; export its Response body or a HAR
containing content. Equivalent debugger proof of the patched resolver and its
exact live input is acceptable. Return the export to Codex for hashing and
interpretation. Do not save/apply CPE settings, change network mode/APN/bands,
reboot, flash, or perform persistent actions. Treat credentials and unique
device data as local sensitive material; durable results must be sanitized.

`RESUME_CONDITION`: identify the browser-evaluated code, or directly prove the
resolver/live-input branch. This assist is prepared, not completed.

```text
CPE_API_CAPTURED=YES
CPE_SERVED_CHUNK_IDENTITY=RUN21_PATCHED
CPE_LOADED_CHUNK_IDENTITY=UNKNOWN
CPE_VISIBLE_TITLE=未识别配置
CPE_RCA=UNKNOWN
CPE_REPAIR_UNBLOCKED=NO
CPE_NEXT_GATE=CPE-RUN21-LIVE-BODY-01
IPV6_ROOT_CAUSE=CONFIRMED_SAME_PREFIX_RETURN_ROUTE_COLLISION
IPV6_REPAIR_DESIGN=DYNAMIC_PREFERRED_LAN_SHARED_PREFIX_ROUTE
IPV6_REPAIR_DESIGN_READY=YES
IPV6_IMPLEMENTED=NO
IPV6_READY_FOR_BATCH=YES
CPE_READY_FOR_BATCH=NO
```

## Run 22 scheduling

```text
READY_FIXES=IPv6 native shared-prefix return-route repair design
BLOCKED_FIXES=CPE live-render repair
BATCHABLE_FIXES=NONE_YET_FOR_COMBINED_CPE_AND_IPV6
DEFERRED_NON_BLOCKING=Notification,Neighbour,Wired_WAN
WHY_SEPARATE_BUILD_REQUIRED=NOT_APPLICABLE
EXPECTED_BUILD_SCOPE=UNAPPROVED
EXPECTED_RAM_TEST_SCOPE=UNAPPROVED
BUILD_WORTH_TRIGGERING=NO
RUN22_CHANGESET_READY=NO
RUN22_TRIGGERED=NO
```

The confirmed IPv6 design remains ready; CPE is not ready. After direct CPE
evidence closes the boundary, review whether both repairs are still safe to
batch. Do not add Notification, neighbour, Full packages, upgrades, refactors,
or persistent work simply to enlarge the run.

## Temporary diagnostic decision

Repository checks found `tmp/run21_cpe_probe.sh` is not tracked and has no Git
history. It is a run-specific local probe and does not justify promotion as a
permanent tool in this phase.

```text
TEMP_PROBE_TRACKED=NO
TEMP_PROBE_LONG_TERM_VALUE=NO
TEMP_PROBE_ACTION=UNTRACKED_NO_ACTION
```

No ambiguous tracked tool was deleted.

## Scope conclusion

This phase changed governance/documentation only. It did not access the device
for new evidence, change firmware/runtime/source/packages/configuration/version
locks/workflows, trigger a build or Run 22, begin Full, or modify persistent
storage.

```text
FIRMWARE_AFFECTING_FILES_CHANGED=NO
SOURCE_LOCK_CHANGED=NO
PACKAGE_LOCK_CHANGED=NO
CANDIDATE_CHANGED=NO
STABLE_CHANGED=NO
WORKFLOW_CHANGED=NO
BUILD_TRIGGERED=NO
RUN22_TRIGGERED=NO
DEVICE_ACCESSED_FOR_NEW_EVIDENCE=NO
DEVICE_MODIFIED=NO
PERSISTENT_STORAGE_MODIFIED=NO
FULL_STARTED=NO
```
