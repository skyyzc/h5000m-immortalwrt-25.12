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
