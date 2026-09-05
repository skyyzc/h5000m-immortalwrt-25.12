# H5000M project rules

## Three-layer context reload

Treat repository evidence as project memory; never rely on chat history alone.
At every new/resumed task, after compaction, and after an interrupted build:

1. Layer 1, always read: `AGENTS.md`, `PROJECT_STATE.md`, and the current task
   specification. Then inspect `git status`, branch, HEAD, its tracked remote
   SHA, and a short log.
2. Layer 2, task-scoped: read only current files named by `PROJECT_STATE.md`,
   the task, and the applicable Skill. Higo work normally needs
   `docs/HIGO-FEATURES.md`; provenance work needs `docs/PACKAGES.md` and the
   relevant version lock; device work needs the current run's device evidence.
3. Layer 3, on demand: read historical evidence, old build reports/logs, full
   CHANGELOG history, reference/asset/migration documents, old investigations,
   and recovery evidence only for conflict, regression, root cause, provenance,
   recovery, historical comparison, or an uncertain current-state pointer.

`CHANGELOG.md` remains mandatory output where required, but a full read is not
mandatory startup context. Search by run, phase, commit, or subsystem, read the
latest relevant section, and expand only the needed range. Context minimization
means selective durable retrieval, never skipped verification.

Every active phase must keep the lightweight Current Task contract in
`PROJECT_STATE.md`: `CURRENT_TASK`, `CURRENT_TASK_REQUIRED_FILES`,
`CURRENT_GATE`, and `STOP_CONDITION`. Future work orders should normally state
only `TASK`, `BASELINE`, `SCOPE`, `REQUIRED_CONTEXT`, `DO`, `DO_NOT`,
`ACCEPTANCE`, and `STOP`, referencing permanent rules rather than repeating
them.

## Evidence and maturity

Use only `CONFIRMED`, `PARTIAL`, `INFERRED`, `UNVERIFIED`, and `UNKNOWN`.
`CONFIRMED` requires direct source, command, build, artifact, or device evidence;
never promote inference or unknown state without new direct evidence.

Keep maturity distinct: `CONFIGURED`, `BUILT`, `INSTALLED`, `RUNNING`, `UI_OK`,
`FUNCTION_TESTED`. A build does not prove device behavior, package presence does
not prove a running service, and a visible page does not prove functionality.

Maturity is scoped to the exact firmware run and evidence generation. Current
and future state must namespace `BUILD_OK`, `RAM_BOOT_OK`, `DEVICE_OK`, and
`FUNCTION_TESTED` by run. A later build may inherit design intent and source
history, but must not inherit `RUNNING`, `UI_OK`, or `FUNCTION_TESTED` maturity
without new evidence from that exact firmware.

When evidence conflicts, prefer: current device test; current candidate test;
latest-full analysis; run13; run10; older material; inference. Preserve the old
conclusion and record `OLD`, `NEW`, `EVIDENCE`, `REASON`, and `IMPACT`.

### Issue closure and repair-path rules

`ISSUE_CLOSURE_RULE`: the project goal is issue closure, not issue
identification. For every in-scope defect, progress through `DISCOVERED` ->
`EVIDENCE_COLLECTED` -> `ROOT_CAUSE_CONFIRMED` -> `REPAIR_DESIGNED` ->
`IMPLEMENTED` -> `BUILT` -> `DEVICE_TESTED` -> `FUNCTION_TESTED` -> `CLOSED`.
Diagnosis is not completion. Neither `ROOT_CAUSE_CONFIRMED` nor `BUILT` closes
an issue. Close it only after the target function passes on its applicable
real-device/runtime path and all required regression gates pass.

Continue from diagnosis into design and implementation when the root cause is
sufficiently supported, the next action is authorized, and safety, evidence,
and provenance gates are satisfied. Stop before implementation only when
critical evidence is missing; materially different designs remain unresolved;
the implementation exceeds current scope or an owner gate; persistent,
destructive, or state-changing risk requires approval; or source, provenance,
or safety cannot be satisfied. On such a stop, record `BLOCKER`,
`MISSING_EVIDENCE`, `NEXT_ACTION`, and `REPAIR_CONTINUATION_GATE`. Do not
re-diagnose a confirmed cause without new contradictory evidence.

`VENDOR_UI_REPAIR_RULE`: before building a vendor UI repair, prove the chain
API -> loaded asset -> runtime resolver/renderer -> visible field whenever
technically possible. Build-time patch and hash success alone do not prove the
live UI path or function.

`CLIENT_NETWORK_VALIDATION`: final function validation for network-stack fixes
should use at least two client OS families where practical. The next H5000M
IPv6 repair must include macOS and either Android or Windows. This diversity
gate does not invalidate a root cause already confirmed by router-side packet
and route evidence.

## Permanent product requirements

Target Hiveton H5000M with ImmortalWrt 25.12, MT7987A, MT7992 and RG520N-CN
(`2c7c:0801`). Permanently retain Higo on port 80, LuCI on port 8080, IPv6,
Wi-Fi, QModem, QMI/QMAP and `qmi_wwan_q`. Do not reduce Rescue requirements to
make a build pass.

Use `versions/candidate.json` and `versions/stable.json` as source truth. Formal
builds require exact source SHA, profile, project commit and Actions Run ID;
never use `latest` as identity. Flow is upstream check -> candidate -> build ->
RAM validation -> manual promote -> stable. Stable promotion is always manual.

`UPSTREAM_LIFECYCLE = REQUIRED`. This is an evolving product, not a one-time
25.12 build. Controlled updates follow detection -> candidate -> source and
provenance review -> static compatibility gates -> build -> RAM regression ->
manual stable promotion. Never replace or deploy stable merely because an
upstream changed; automation may later detect/build updates but cannot silently
promote them.

`ONLINE_UPDATE_TARGET = REQUIRED`, while
`ONLINE_UPDATE_STATUS = BLOCKED_BY_PERSISTENT_SAFETY`. Online update and Higo
firmware-upgrade paths remain prohibited until validated Full -> persistent
storage model -> backup -> recovery -> rollback/failure recovery -> sysupgrade
compatibility -> artifact identity/integrity -> explicit owner authorization
have all passed. A current prohibition does not remove online update from the
long-term goal.

`PLUGIN_ARCHITECTURE = MODULAR / OPTIONAL / INDEPENDENTLY_PROVENANCED`.
`CORE_RESCUE` must not depend on optional plugins. `FULL_REQUIRED` contains
hardware/product-critical integrations such as fan management and required Higo
Full integrations; current candidates include wrtbwmon/Higo client integration,
OAF, fan, and DiskMan/KSMBD. `FULL_OPTIONAL` may include owner-selected
ZeroTier, Watchcat, and future integrations. Categories can evolve, but every
component retains independent provenance, adaptation, build/device evidence,
and update policy.

## Documentation and scope

Firmware-affecting changes update `CHANGELOG.md`; package/source/profile changes
also update `docs/PACKAGES.md`; Higo behavior or implementation changes update
`docs/HIGO-FEATURES.md`. Keep README architectural and durable.

`CHANGELOG.md` owns actual engineering changes, formal build history, failures,
and repairs. `PROJECT_STATE.md` is the compact current-state index and points to
detailed evidence without replacing it. `docs/PACKAGES.md` owns component
provenance, ownership class, and integration state. `docs/HIGO-FEATURES.md`
remains the Higo feature gap and next step matrix. `versions/candidate.json` and
`versions/stable.json` own exact version locks. Do not create overlapping
records when these files can carry the evidence.

The permanent project mainline is: ImmortalWrt 25.12 upstream -> H5000M
hardware adaptation -> permanent Higo compatibility -> LuCI coexistence ->
RG520N-CN -> optional integrations -> Rescue RAM validation -> Full -> manual
stable promotion -> persistent/eMMC only after recovery and rollback are
proven. A phase-specific task must not omit, rewrite, or bypass this mainline.

Work may analyze, modify, validate, commit, push and rerun Actions only within
the current explicit task. Stop before changing source locks or core
architecture, removing core functions, making persistent device writes, doing a
large refactor, or bulk-upgrading packages unless the task explicitly permits it.

Never autonomously write eMMC, GPT, U-Boot or partitions; run sysupgrade or
format operations; modify factory backups; or delete irreplaceable originals.
Never commit credentials, passwords, tokens, private keys, IMEI/ICCID/SIM or
phone identifiers, unique MAC/serial values, carrier accounts, real Wi-Fi
passwords, or askpass contents. The proprietary Higo payload is explicitly
allowed in commits and pushes and is not itself a sensitive-data blocker.

## Project-Scoped Credential Authorization

`PROJECT_SCOPED_CREDENTIAL_USE = AUTHORIZED` for H5000M and
`h5000m-immortalwrt-25.12` engineering only. Codex may reuse credentials that
the user explicitly provides or securely configures locally for H5000M SSH,
Higo, LuCI, device APIs, validation scripts, Rescue/Full device validation,
diagnosis, and regression testing without requesting authorization for every
ordinary login. This is not global credential authorization; any target outside
this project requires new user authorization.

Prefer a project-specific SSH key stored only in the local user's secure
storage. A public key may be deployed to an H5000M when the current device task
permits it. For Higo, LuCI, and APIs, prefer Windows Credential Manager or an
equivalent OS secret store and a local helper that supplies authentication
without printing secrets. If a password is technically required, use the
minimum-exposure local mechanism and never expose it as a normal command-line
argument, process-list value, shell history entry, stdout/stderr, debug/build/CI
log, or external request unrelated to the target H5000M service.

Never place a plaintext credential in repository files, tracked `.env` files,
documentation, Git history, Actions workflows, artifacts, build outputs,
manifests, or reports; never commit or push one. Do not upload a credential as a
GitHub Actions secret unless the user separately requests that action. Never
send it to a third-party service, external API, unrelated website, account,
device, project, or model, and never reproduce it in a response or state record.

Authentication authority does not authorize destructive or persistent device
operations. Existing gates for configuration changes, eMMC/GPT/partition or
factory writes, sysupgrade, U-Boot/BL2 updates, environment changes, and every
other persistent or destructive action remain fully effective. Credentials
must never be used to bypass or weaken those gates.

### Authentication and local evidence policy

For H5000M project targets, `AUTHENTICATION`, `READ_ONLY_EVIDENCE`, and
`LOCAL_RAW_ANALYSIS` are default-authorized. Do not block ordinary evidence
acquisition merely because a credential, cookie, bearer/session token, or raw
device identifier participates locally. Reuse an explicitly provided,
currently authenticated, locally secured, or project-helper credential for
SSH, Higo/LuCI, authenticated HTTP/API, browser automation, and read-only
runtime debugging without repeated owner approval.

Credentials may exist transiently in stdin, environment, process memory, a
permission-protected temporary file, an authenticated client/session, OS secret
storage, or a project-local credential helper. Prefer mechanisms that keep them
out of shell history, command-line process listings, stdout/stderr, and debug
logs. If accidental credential output occurs, stop durable persistence and
sanitize it. Passwords, cookies, bearer/session/API tokens, private credential
material, and other secrets remain prohibited in Git, Markdown, source,
firmware, manifests/reports, Actions, uploaded artifacts, and public/shared
logs.

Raw local analysis may contain IMEI, ICCID, IMSI, SIM identifiers, unique MAC,
public IPv6, cell ID, PCI, ARFCN, carrier/operator data, device serial, and
other device-specific identifiers. Codex may read and correlate these locally;
before any Git record, durable Markdown, uploaded artifact, build report, or
public/shared log, sanitize them. `LOCAL_RAW_ANALYSIS = ALLOWED` and
`DURABLE_PROJECT_RECORD = SANITIZED`.

Default-authorized read-only operations include SSH commands; ubus calls;
authenticated Higo/API GETs; local authenticated fixture capture; logs and
process/interface status; IP address/rule/route, nft counter, sysctl and UCI
reads; QModem controller and QMI status reads; ownership inspection; browser
inspection; and local source/binary analysis.

`H5000M_DEFAULT_CREDENTIAL_PROBING = AUTHORIZED_FINITE`. For H5000M project
targets only, use this authentication order without first asking the owner:

1. Level A: an existing SSH key, authenticated connection/session or cookie;
   then the known project username with an empty password.
2. Level B: the finite project default supplied out of band by the owner, then
   any securely stored project credential. Never spell the default secret in a
   tracked file merely to document this authorization.
3. Level C: if those explicitly authorized candidates fail, stop with
   `AUTH_BLOCKED` and request owner intervention.

SSH uses username `root`; Higo/LuCI/API use the known project username when one
is required. No dictionary attack, brute force, password spraying, repeated
loop, or use against another target is authorized.

`H5000M_EPHEMERAL_HOSTKEY_POLICY`: original and Rescue firmware may expose
different Dropbear host keys. Use project-local or temporary `known_hosts` for
an explicitly known original <-> Rescue transition, after establishing the
direct/local H5000M target context. Never edit or delete the user's global
`~/.ssh/known_hosts`, and never globally disable host-key verification. An
expected key change at such a known transition is not by itself compromise;
an unexpected change outside it requires review.

`AUTH_SESSION_REUSE = REQUIRED_WHEN_SAFE`. Reuse a safe project SSH connection
and authenticate Higo/LuCI/API once per related read-only evidence session,
reusing the local cookie/session rather than logging in per endpoint. Keys,
passwords, cookies, and tokens retain all existing no-log, no-Git, no-artifact,
no-firmware, no-CI, and no-public-output restrictions.

Bounded query-only AT commands are default-authorized only through a proved
existing owner/arbitration path. This includes `ATI`, `AT+CSQ`, `AT+COPS?`,
`AT+QNWINFO`, `AT+QENG="servingcell"`, and
`AT+QENG="neighbourcell"`. The presence of `=` does not make a command a
mutation; classify its semantics. Confirm the modem/data path before and after,
run once or a stated finite count, never poll, and prefer the existing
QModem/Higo/controller path. An apparently idle tty is not ownership proof;
never create a competing direct serial writer when arbitration is unproved.

The following still require a separate explicit owner gate: sysupgrade,
firmware/eMMC/GPT/partition/U-Boot/BL2/Factory writes, persistent configuration
migration or original-system package installation; band/cell lock, network
mode/APN/SIM mutation, modem reset, USB unbind, connectivity-impacting service
stop/restart, write/configuration AT, persistent modem NVRAM changes; and every
other persistent, destructive, or state-changing operation.

Project authorization summary:

- `AUTHENTICATION_FRICTION = MINIMIZED`
- `AUTHENTICATION = DEFAULT_AUTHORIZED`
- `READ_ONLY_EVIDENCE = DEFAULT_AUTHORIZED`
- `LOCAL_RAW_ANALYSIS = ALLOWED`
- `DURABLE_PUBLIC_RECORD = SANITIZED`
- `READ_ONLY_AT = DEFAULT_AUTHORIZED_WITH_SAFE_OWNERSHIP`
- `PERSISTENT_CHANGE = EXPLICIT_GATE`
- `DESTRUCTIVE_CHANGE = EXPLICIT_GATE`
- `STATE_CHANGING_MODEM_OPERATION = EXPLICIT_GATE`

## Formal Build Ledger Rule

Every formal GitHub firmware build must leave a durable record whether its
result is `SUCCESS`, `FAILURE`, or `CANCELLED`. Record at least Phase, Run ID,
Run Number, Attempt, Profile, Source, Project SHA, ImmortalWrt SHA, Result,
critical gates, artifact or diagnostics identity, failure root cause, repair
commit when applicable, and firmware SHA256 on success. Preserve failed and
cancelled runs after later success; never delete or rewrite their history.

## Package / Integration Provenance Rule

Every core package, official package, third-party plugin, vendor component, and
project-local compatibility layer must remain inventoried in
`docs/PACKAGES.md`. Classify Origin/Ownership as `IMMORTALWRT_CORE`,
`IMMORTALWRT_FEED`, `OPENWRT_FEED`, `THIRD_PARTY`, `VENDOR_HIGO`, or
`PROJECT_LOCAL`. Maintain package/version, repository or source, exact SHA or
`UNKNOWN`, profile, purpose, integration/patch state, build validation, device
validation, known issue, and update policy.

When an upstream or third-party version changes, record `OLD -> NEW`, reason,
compatibility impact, build result, and device result; changing only the version
number is prohibited. Exact locks remain in `versions/candidate.json` and
`versions/stable.json`.

## Codex Resource / Quota Governance

Codex quota is a limited engineering resource. Prioritize it for root-cause
analysis, source and configuration inspection, code changes, validation,
failure diagnosis, minimal repair, artifact verification, and documentation
and evidence synchronization. Avoid repeated polling, heartbeats,
elapsed-time narration, unchanged reads, continuous `gh run watch`, and manual
waiting on healthy long-running tasks.

External work uses these states:

- `ACTIVE_ENGINEERING`: analyzing, changing, repairing, validating, reading a
  failure, or accepting artifacts.
- `EXTERNAL_RUNNING`: GitHub Actions or another external task is running.
- `WAITING_EXTERNAL`: the external task is healthy, there is no actionable
  engineering work, and Codex has stopped active work.
- `REVIEW_REQUIRED`: the external task ended and Codex must analyze failure or
  accept success.

For GitHub Actions, clean ImmortalWrt/OpenWrt builds, package builds, artifact
generation, and other long CI tasks, enter `WAITING_EXTERNAL` when the task is
healthy and there is no actionable failure. First preserve workflow, Run ID,
Run Number, Run Attempt, branch, project SHA, profile, source, last confirmed
gate, wait reason, phase, state, and next action in durable project evidence.

In `WAITING_EXTERNAL`, continuous `gh run watch`, five- or ten-minute polling,
heartbeats, repeated running reports, and repeated elapsed-time reports are
prohibited. A healthy external task expected to exceed about 15 minutes should
normally enter `WAITING_EXTERNAL`; 15 minutes is not a hard timeout. Continue
`ACTIVE_ENGINEERING` while analyzing a real error.

Resume only when the user explicitly asks, reports an external status change,
or an explicitly authorized event-driven mechanism exists. On resume, perform
Context Reload, Git State Reload, query the target run once, and continue from
its real result. Session, quota, or conversational context loss must not cause
work with durable PASS evidence to be repeated.

Repository, Git, GitHub Run, Build Artifact, Build Report, and Manifest evidence
take priority over conversational memory. Before waiting, preserve Phase,
State, Branch, Project SHA, Workflow, Run ID, Run Number, Run Attempt, Profile,
Source, Last Confirmed Gate, Wait Reason, and Next Action so a later session can
resume without chat history.

A failed run transitions `WAITING_EXTERNAL` -> `REVIEW_REQUIRED` ->
`ACTIVE_ENGINEERING` -> diagnostics -> first causal error -> minimal repair ->
commit -> push -> new run. When that run reaches a healthy long compile, return
to `WAITING_EXTERNAL`.

GitHub Actions `SUCCESS` does not itself establish `BUILD_OK`. Firmware,
`BUILD-MANIFEST`, `BUILD-REPORT`, `resolved.config`, `SHA256SUMS`, embedded build
identity, and documentation consistency must all pass acceptance first.

For repository investigation, search for the exact run, phase, commit,
subsystem, or heading before reading large files when practical. Do not
re-parse historical evidence that has a valid `PROJECT_STATE.md` pointer unless
conflict or the active task requires the underlying proof. After an external
state change, reload Layer 1 and retrieve only task-relevant evidence.

Quota governance eliminates low-value waiting. It must never be used to skip
validation, log analysis, documentation, artifact verification, or necessary
evidence; weaken acceptance gates; guess a root cause; use an unverified
shortcut; or hide a failure.

## Engineering Efficiency and Human-Assist Governance

`EFFICIENCY_MUST_NOT_WEAKEN_EVIDENCE`: efficiency may reduce duplicate
analysis/context reads, equivalent retries, unnecessary builds, owner
interruptions, and blocking between independent items. It must not reduce or
bypass direct evidence, provenance, source identity, build/artifact acceptance,
exact-run device validation, `FUNCTION_TESTED` or issue-closure criteria, owner
authorization, persistent/state-changing gates, modem ownership, recovery and
rollback proof, candidate/stable separation, or secret handling. Faster is
valid only when the same required evidence and acceptance result is reached
with less duplicate work.

### Issue severity and batching

`ISSUE_SEVERITY_ROUTING` is an execution class and does not replace `OPEN_P0`
or `OPEN_P1` priority:

- `SEV_CORE`: boot/kernel/storage safety; LAN/DHCP/routing; base Wi-Fi;
  RG520/QMI/QMAP/modem data; IPv4/IPv6 forwarding; Higo/LuCI core coexistence;
  hardware foundations; persistent/recovery/update safety. Default path is
  strict evidence -> RCA -> design -> implementation -> build -> exact-run
  RAM/device validation -> `FUNCTION_TESTED`.
- `SEV_INTEGRATION`: required Full integrations, fan, Higo client/traffic,
  wrtbwmon, OAF, DiskMan/KSMBD, and required management adapters. Use bounded
  contract/provenance review -> implementation -> batch-preferred build ->
  per-feature function validation. Escalate to `SEV_CORE` only when it touches
  or regresses a core subsystem.
- `SEV_OPTIONAL`: ordinary optional Full/LuCI applications and owner-selected
  modular plugins. Use provenance/static compatibility -> batch integration ->
  smoke/function test; do not require a standalone heavyweight RCA phase when
  no defect or core interaction exists.

Every integration retains independent provenance and functional evidence.

`BATCH_WHEN_READY_RULE`: a change is `READY_FOR_BATCH` only when its cause is
sufficiently closed, design selected, required inputs known, no prerequisite
evidence remains unresolved, it fits the same profile/validation phase, and
batching preserves fault isolation and safety. Safely compatible ready changes
should share a firmware build and RAM session. Separate builds require a real
reason: core/persistent-risk isolation, observational interference, causal A/B,
source/profile incompatibility, material rollback/failure isolation, or an
explicit owner request. Batching changes scheduling only; every feature keeps
independent acceptance, and one failure may not be hidden by another pass.

Before a formal build, record:

```text
READY_FIXES=
BLOCKED_FIXES=
BATCHABLE_FIXES=
DEFERRED_NON_BLOCKING=
WHY_SEPARATE_BUILD_REQUIRED=
EXPECTED_BUILD_SCOPE=
EXPECTED_RAM_TEST_SCOPE=
BUILD_WORTH_TRIGGERING=YES/NO
```

`BUILD_EFFICIENCY_GATE`: do not build when no firmware-affecting work is ready
or when the evidence is obtainable without rebuilding. Run static/unit/fixture
checks first. Do not batch an `UNKNOWN` speculative repair with a confirmed
repair, and require a concrete acceptance plan before dispatch. Do not hold a
ready core repair forever for unrelated optional work. Build duration never
lowers exact-run validation requirements.

`DEFER_NON_BLOCKING_GAPS`: a gap may be `DEFERRED_NON_BLOCKING`,
`BLOCKED_BY_EVIDENCE`, `BLOCKED_BY_ENVIRONMENT`, or `HUMAN_ASSIST_REQUIRED`
when it is outside the current acceptance contract, does not threaten safety,
recovery, core connectivity, or another accepted result, no ready repair is
silently abandoned, and its evidence, impact, and next gate remain durable.
Deferral is not closure and cannot set `FUNCTION_TESTED` or `CLOSED`. A deferred
item blocks unrelated mainline work only when the phase contract says so.

`PLUGIN_BATCH_INTEGRATION_RULE`: after Rescue core is sufficiently frozen,
integrate compatible Full/plugin work in bounded batches instead of one plugin
per run. Each item still records ownership/origin, repository, exact SHA/version
or `UNKNOWN`, adaptation, dependencies, profile, static/build/device/function
results, issues, and update policy. Package presence is not function proof. A
failed item does not erase independently proved sibling passes, but a mandatory
failure blocks the required Full contract. Do not rebuild passing siblings
separately without cause or hard-code future batch membership here.

### Stalls, retries, and human assistance

`HUMAN_ASSIST_MINIMIZATION_RULE`: `CODEX_AUTONOMY_FIRST`,
`HUMAN_ASSIST_LAST_RESORT`, `EVIDENCE_QUALITY_UNCHANGED`, and
`SAFETY_GATES_UNCHANGED`. The owner is not a routine shell, Git, HTTP/API,
SSH, browser, log, comparison, hash, or evidence-collection operator. Before
requesting assistance, Codex must establish that the evidence is required,
reuse valid exact-run evidence, exhaust relevant safe read-only autonomous
paths, inspect available tools/plugins/connections and genuinely different
alternatives, identify the concrete capability boundary, and reduce the owner
action to the irreducible human or physical step. Convenience or a first
failure is not a valid reason for assistance.

For browser work, `BROWSER_AUTONOMY_PRECHECK=REQUIRED`. Record actual access to
Chrome/plugin connection, the in-app browser, automation, current and
authenticated sessions, DevTools, debugger/breakpoints, and paused local-scope
inspection. Classify the evidence level: (1) navigation/read, (2)
authenticated/API/network, (3) DOM/runtime-visible state, (4) DevTools/network
response, (5) debugger/breakpoint, or (6) paused closure/local scope. Codex
must autonomously complete every supported lower level and may delegate only
the necessary portion above the verified capability ceiling.

`NO_BLIND_RETRY_RULE`: for SSH, authentication, browser/UI, API, or other
interactive work, attempt the preferred path once and capture its boundary.
Retry once only for a plausible transient or meaningful correction. After two
materially equivalent no-progress failures, try at most one genuinely
different safe bounded path if one exists; syntax changes over the same broken
mechanism are not different. Then use `HUMAN_ASSIST_REQUIRED` when the owner can
reasonably close the evidence, otherwise `BLOCKED` with exact missing evidence.
Never credential-spray, guess endpoints, click/refresh without bounds, repeat
SSH blindly, or make speculative state changes.

`INTERACTIVE_STALL_CLASSIFICATION`: classify an interactive stall as one of:
`AUTH_FAILURE`, `SESSION_EXPIRED`,
`HOSTKEY_TRANSITION`, `NETWORK_UNREACHABLE`, `SERVICE_UNAVAILABLE`,
`UI_AUTOMATION_LIMIT`, `BROWSER_EVIDENCE_LIMIT`, `TOOL_CAPABILITY_LIMIT`,
`COMMAND_HANG`, `PERMISSION_DENIED`, `EXPECTED_HUMAN_GATE`, or
`UNKNOWN_INTERACTIVE_BLOCKER`. A tooling interaction failure is not product
defect evidence. Finite authentication, session reuse, secret safety, and
project-local/temporary host-key rules above remain authoritative; after all
authorized finite paths fail use `AUTH_BLOCKED`, or human assist when the owner
can resolve authentication without placing a secret in a durable record.

`NO_SILENT_SKIP_RULE`: every required gate ends explicitly as `PASS`, `FAIL`,
`BLOCKED`, `HUMAN_ASSIST_REQUIRED`, or `NOT_APPLICABLE`. A blocked/assisted gate
cannot be called passed or promoted, and its missing evidence must be named.
Independent work may continue; optional items may defer only under the durable
non-blocking rule. Never substitute inference for unavailable direct evidence.

`HUMAN_ASSIST_GATE`: use `HUMAN_ASSIST_REQUIRED` when a required result is
owner-obtainable, Codex
has reached an automation/tool/GUI/physical boundary, further equivalent retry
has low information value, and the request can be narrow and safe. Examples
include browser DevTools body export, owner-only Recovery WebUI RAM load, real
client testing, cable insertion, CAPTCHA/human-presence auth, owner-visible UI,
or a local export unavailable to current tooling. It cannot bypass authority,
request an unauthorized persistent/destructive action, replace normal source
analysis, follow one trivial recoverable failure, or outsource vague diagnosis.

Human-assist requests use this contract, preferably with concise Chinese owner
instructions:

```text
HUMAN_ASSIST_REQUIRED=YES
ASSIST_ID=
BLOCKED_GATE=
BLOCKER_CLASS=
AUTONOMOUS_WORK_COMPLETED=
AUTONOMOUS_METHODS_ATTEMPTED=
AVAILABLE_TOOL_CAPABILITIES_CHECKED=
WHY_CODEX_CANNOT_OBTAIN_THIS_EVIDENCE=
WHY_THIS_EVIDENCE_IS_REQUIRED=
WHY_EXISTING_EVIDENCE_IS_INSUFFICIENT=
WHY_HUMAN_ACTION_IS_UNAVOIDABLE=
MINIMUM_OWNER_ACTION=
EXPECTED_RETURN_EVIDENCE=
WHAT_OWNER_MUST_NOT_DO=
WHAT_CODEX_WILL_DO_AFTER_RETURN=
INDEPENDENT_WORK_CAN_CONTINUE=YES/NO
RESUME_CONDITION=
```

Browser assistance additionally records `BROWSER_CAPABILITY_CHECK`,
`CHROME_PLUGIN_AVAILABLE`, `CHROME_PLUGIN_CONNECTED`,
`IN_APP_BROWSER_AVAILABLE`, `BROWSER_AUTOMATION_AVAILABLE`,
`DEVTOOLS_ACCESS_AVAILABLE`, `DEBUGGER_ACCESS_AVAILABLE`,
`PAUSED_SCOPE_INSPECTION_AVAILABLE`, and `EXACT_BROWSER_CAPABILITY_LIMIT`.
These fields must name the observed boundary rather than merely saying that a
tool cannot complete the task.

Ask for the smallest action and exact return material, say what must not be
changed, require sanitization where needed, and interpret raw engineering
evidence rather than asking the owner to interpret it.

`HUMAN_ASSIST_RETURN_CONTRACT`: on return, reload context and Git state,
identify the `ASSIST_ID` and blocked gate, verify device/run/context, sanitize
durable evidence, and resume only that gate. Do not repeat accepted independent
work. Promote RCA/design/maturity only as directly supported and continue
automatically within the authorized scope. If incomplete, request only the
missing minimum. Human assistance is continuation, not a new investigation.

`DEPENDENCY_AWARE_CONTINUATION`: for every blocked item record
`DEPENDS_ON_BLOCKER=YES/NO`. If `NO`, continue independent authorized work while
preserving the blocker; if `YES`, stop only that branch. When every useful
remaining action depends on one blocker, persist the deterministic resume gate,
enter human assist or blocked state, and stop without low-value work.

### Temporary diagnostics and governance size

`TEMP_DIAGNOSTIC_LIFECYCLE`: one-off probes, raw captures, browser exports,
packet captures, secret-bearing helpers, and run-specific scratch stay local
and untracked, are deleted when their purpose ends, and are sanitized before
durable recording. Promote a repeatedly useful diagnostic deliberately into a
stable diagnostics/scripts location with purpose, safety, ownership, inputs,
outputs, no embedded unique/secret data, and validation. Never retain a
run-specific temporary file merely because it was useful once; preserve an
ambiguous tracked tool and mark `REVIEW_REQUIRED` rather than deleting it.

`GOVERNANCE_ANTI_BLOAT`: extend an existing rule when one clear clause suffices.
Permanent rules encode reusable decisions, not historical narratives. Use
`PROJECT_STATE.md` for current pointers, `CHANGELOG.md` for chronology, and
existing feature/package files for their owned evidence. Create a separate
design/evidence document only when technical complexity warrants it; do not
create a dedicated phase/document for every minor defect or plugin.
