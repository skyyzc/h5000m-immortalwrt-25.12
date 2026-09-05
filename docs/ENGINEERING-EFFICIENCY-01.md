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

### Autonomy-first rule and current reassessment

`HUMAN_ASSIST_MINIMIZATION_RULE` now makes owner assistance an exception, not
a routine engineering loop. Required evidence must first pass evidence reuse,
safe autonomous investigation, actual tool/plugin/session capability checks,
alternative-path review, and owner-action minimization. Browser evidence is
classified from ordinary navigation through paused closure scope; Codex must
complete every level its tools support. This does not relax any evidence,
credential, modem, physical, build, RAM-first, or persistent gate.

Static reassessment of the Run 21 CPE bundle established:

1. `getNetworkMode()` performs GET `/cpe/network-mode` and returns the API
   wrapper's unwrapped value.
2. The only wrapper transform is `code`/`data` envelope removal; there is no
   network-mode normalize/map step before the component.
3. `F.value=h` is assigned by the read refresh. The only other whole-object
   assignment is after explicitly state-changing `setNetworkMode`, which was
   not invoked; no field mutation was found.
4. No other `selectedNetworks` mutation path was found in this component.
5. `mode` can match a `Ge` entry and return early; any such match returns a
   non-null entry with a title, so it does not statically explain the unknown
   fallback.
6. `st` is a Vue computed depending on `Ge`, `F.value.mode`, and
   `F.value.selectedNetworks`; its consumers evaluate it and those reactive
   dependencies invalidate it. Initial state and asynchronous refresh can each
   render, but the refreshed assignment invalidates the computed.
7. `Tt` depends only on `st` and maps null/untitled state to `未识别配置`.
8. Searches found one component-local `F`, one read assignment, one
   save-response assignment, and no watcher/effect that mutates it. No static
   evidence proves a second instance, second mode fetch, state replacement, or
   alternate visible-title source. Since `Jt` and `Tt` consume the same state,
   the observed `4G / 5G` badge plus unknown title remains a runtime
   contradiction whose cause is `UNKNOWN`, not a confirmed static RCA.

Actual browser autonomy precheck on 2026-09-06:

```text
BROWSER_CAPABILITY_CHECK=COMPLETE
CHROME_PLUGIN_AVAILABLE=NO
CHROME_PLUGIN_CONNECTED=NO
IN_APP_BROWSER_AVAILABLE=YES
BROWSER_AUTOMATION_AVAILABLE=YES
CURRENT_BROWSER_SESSION_ACCESSIBLE=NO
AUTHENTICATED_SESSION_ACCESSIBLE=NO
DEVTOOLS_ACCESS_AVAILABLE=NO
DEBUGGER_ACCESS_AVAILABLE=NO
BREAKPOINT_CAPABILITY_AVAILABLE=NO
PAUSED_SCOPE_INSPECTION_AVAILABLE=NO
EXACT_BROWSER_CAPABILITY_LIMIT=LEVEL_3_DOM_RUNTIME_VISIBLE_STATE_WITHOUT_EXISTING_SESSION; LEVEL_4_TO_6_DEVTOOLS_DEBUGGER_PAUSED_SCOPE_NOT_EXPOSED
```

The current browser inventory contained only an empty Codex in-app browser and
no Chrome surface or tab. Previous exact-run evidence already covers the
authenticated GET, requested chunk, response-body identity, and visible title,
so repeating Levels 1-4 would add no evidence. Only live paused closure values
at the already located resolver/title computation remain unavailable.

The old nine-step assist is therefore `REPLACED`, not invalidated. The reduced
assist asks only for paused values of `F.value`,
`Ie(F.value.selectedNetworks)`, `Ge.value`, `st.value`, and `Tt.value` at the
already identified computation; the owner need not repeat API capture,
response export, hashing, source search, or analysis.

```text
HUMAN_ASSIST_REQUIRED=YES
ASSIST_ID=CPE-RUN21-LIVE-STATE-01
BLOCKED_GATE=Run21 live Vue resolver/title state
BLOCKER_CLASS=BROWSER_EVIDENCE_LIMIT
AUTONOMOUS_WORK_COMPLETED=API wrapper/state/mutation/computed/render trace; loaded Run21 code and visible title already proved
AUTONOMOUS_METHODS_ATTEMPTED=repository/minified-bundle tracing; evidence reuse; actual browser inventory and capability precheck
AVAILABLE_TOOL_CAPABILITIES_CHECKED=in-app browser automation and current browser/tab/session inventory
WHY_CODEX_CANNOT_OBTAIN_THIS_EVIDENCE=current tools expose no Chrome surface, DevTools debugger, breakpoint, or paused local scope
WHY_THIS_EVIDENCE_IS_REQUIRED=the same reactive state statically implies a non-null patched result while the exact-run UI showed the fallback
WHY_EXISTING_EVIDENCE_IS_INSUFFICIENT=loaded-code identity and API JSON do not reveal the values inside the evaluated Vue closure
WHY_HUMAN_ACTION_IS_UNAVOIDABLE=only a desktop DevTools paused-scope capture crosses the verified Level-3 capability ceiling
MINIMUM_OWNER_ACTION=in an authorized exact Run21 session, pause at the already located resolver and title computed expressions and return only sanitized paused-scope values/screenshots
EXPECTED_RETURN_EVIDENCE=resolver F.value, local normalized key/candidates/result, then title-computed st.value; call stack identifies CPEManagement-CuEyMeyg.js
WHAT_OWNER_MUST_NOT_DO=save/apply CPE; change network/APN/bands; edit JavaScript; reboot/flash; perform persistent actions; disclose credentials or unique identifiers
WHAT_CODEX_WILL_DO_AFTER_RETURN=validate/sanitize evidence, classify the failing boundary, update durable state, and stop for repair review
INDEPENDENT_WORK_CAN_CONTINUE=NO
RESUME_CONDITION=sanitized paused values close the actual resolver-to-title branch
BROWSER_CAPABILITY_CHECK=COMPLETE
CHROME_PLUGIN_AVAILABLE=NO
CHROME_PLUGIN_CONNECTED=NO
IN_APP_BROWSER_AVAILABLE=YES
BROWSER_AUTOMATION_AVAILABLE=YES
DEVTOOLS_ACCESS_AVAILABLE=NO
DEBUGGER_ACCESS_AVAILABLE=NO
PAUSED_SCOPE_INSPECTION_AVAILABLE=NO
EXACT_BROWSER_CAPABILITY_LIMIT=Level 3 without an existing authenticated session; Levels 4-6 unavailable
```

No owner action is requested by this governance phase itself. If the reduced
gate is separately resumed, Codex must provide the two exact breakpoint
locations and require only the resulting paused-scope captures; prior login,
API, response-body, hash, and source-location evidence remain valid and must
not be repeated.

```text
CPE_API_CAPTURED=YES
CPE_SERVED_CHUNK_IDENTITY=RUN21_PATCHED
CPE_LOADED_CHUNK_IDENTITY=RUN21_PATCHED
CPE_VISIBLE_TITLE=未识别配置
CPE_RCA=UNKNOWN
CPE_REPAIR_UNBLOCKED=NO
CPE_NEXT_GATE=CPE-RUN21-LIVE-STATE-01
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
