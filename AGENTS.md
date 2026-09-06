# H5000M project rules

`H5000M-PROJECT-CHARTER.md` is the highest-level durable policy. This file
contains operational rules, not run history.

## Opening workflow

At every new, resumed, compacted, or interrupted task:

1. Read `H5000M-PROJECT-CHARTER.md`, `PROJECT_STATE.md`, and the current task.
2. Inspect working-tree status, branch, local HEAD, tracked remote SHA, and a
   short log.
3. Read only task matrices and evidence named by the state/task. Higo work uses
   `docs/HIGO-FEATURES.md`; component work uses `docs/PACKAGES.md`.
4. Expand into historical reports, full CHANGELOG, old trees, or extracted
   evidence only when current evidence is insufficient or contradictory, or
   the task explicitly requests an audit.

Do not perform routine full-repository or full-history audits. Micro fixes do
not require broad documentation churn. Governance records reusable policy;
`PROJECT_STATE.md` records current pointers; `CHANGELOG.md` records chronology.

## Evidence and maturity

Use `CONFIRMED`, `PARTIAL`, `INFERRED`, `UNVERIFIED`, or `UNKNOWN`. Direct
source, command, build, artifact, or exact-run device evidence is required for
`CONFIRMED`. Preserve conflicting earlier evidence and record the new proof.

Keep maturity separate: `CONFIGURED`, `BUILT`, `INSTALLED`, `RUNNING`, `UI_OK`,
and `FUNCTION_TESTED`. Package presence is not service operation; a build is
not device proof; a visible UI is not function proof. Namespace results by
exact run and never inherit runtime maturity from an older image.

Issue closure follows `DISCOVERED -> EVIDENCE_COLLECTED ->
ROOT_CAUSE_CONFIRMED -> REPAIR_DESIGNED -> IMPLEMENTED -> BUILT ->
DEVICE_TESTED -> FUNCTION_TESTED -> CLOSED`. Diagnose the first causal boundary,
make one minimal repair, and validate progressively from the earliest affected
boundary. Stop downstream validation on failure. Record nonblocking gaps and
continue authorized work; do not iterate indefinitely without new evidence.

For vendor UI repair, prove API -> loaded asset -> runtime resolver/renderer ->
visible field where possible. Final network-stack validation uses two client OS
families where practical.

## Scope and owner gates

Work only within the explicit task. Stop before source-lock or architecture
changes, removal of a core function, broad refactors, unrelated package/profile
changes, or actions outside the authorized phase.

Separate owner gates are required for a formal firmware build, real-device or
RAM-boot validation, and persistent/destructive/connectivity-changing actions.
The owner operates Recovery/U-Boot UI. Authentication and read-only inspection
do not imply authority to mutate.

Never autonomously write eMMC, GPT, partitions, Factory, U-Boot or BL2; run
sysupgrade/format; change persistent configuration; reset/unbind the modem; or
perform band, cell, APN, SIM, network-mode, or write-AT changes. RAM-first
validation and verified power-cycle recovery precede persistent design.

Stable promotion is manual. Full, persistent deployment, and online update are
separate gates; online update is `BLOCKED_BY_PERSISTENT_SAFETY` until storage,
backup, recovery, rollback, sysupgrade compatibility and integrity are proven.

## Source, provenance, and build records

`versions/candidate.json` and `versions/stable.json` own exact locks. Formal
builds require exact project/source/feed/profile/run identities; never use
`latest` as identity or reduce Rescue gates to obtain a pass.

Every formal GitHub firmware build, including `SUCCESS`, `FAILURE`, and
`CANCELLED`, leaves a durable ledger record containing Phase, Run ID, number,
attempt, profile, source, project SHA, ImmortalWrt SHA, result, critical gates,
artifact/diagnostics, failure root cause and repair commit where applicable,
and firmware SHA256 on success. Later success never erases failure.

Every core, feed, third-party, vendor, and project-local component remains in
`docs/PACKAGES.md` with ownership, version, source/SHA or `UNKNOWN`, profile,
purpose, adaptation, build/device validation, issue, and update policy. Version
changes record `OLD -> NEW`, reason, compatibility impact, build result and
device result. Follow `docs/VENDOR-COMPATIBILITY-MATRIX.md`; never reuse an old
kernel `.ko` across incompatible kernels merely because it existed historically.

Firmware changes update `CHANGELOG.md`; package/source/profile changes also
update `docs/PACKAGES.md`; Higo behavior changes update
`docs/HIGO-FEATURES.md`. Do not create overlapping records.

## Secrets, credentials, and local evidence

`PROJECT_SCOPED_CREDENTIAL_USE = AUTHORIZED` only for H5000M project targets.
Reuse explicitly supplied or securely stored credentials for SSH, Higo, LuCI,
APIs and validation without repeated authorization. Prefer a project SSH key or
OS credential store. Keep secrets out of arguments, process lists, history,
stdout/stderr and logs.

Never place or push passwords, tokens, private keys, cookies, IMEI/ICCID/IMSI,
SIM/phone identifiers, unique MAC/serial values, carrier accounts, real Wi-Fi
passwords, or askpass contents in Git, docs, firmware, manifests, Actions, or
artifacts. Proprietary Higo payload is allowed and is not itself a blocker.

Read-only device evidence and local raw analysis are authorized in scope.
Sanitize device-unique/public identifiers before durable records. Use temporary
project `known_hosts` for known original/Rescue transitions; never weaken
global checking or edit the user's global file.

Finite H5000M credential probing is allowed: authenticated session/key, then
the known project account with empty password, then the owner-provided project
default or secure store. Stop after those candidates; never brute-force or use
credentials elsewhere.

Bounded read-only AT queries are allowed only through a proved
owner/arbitration path, once or a finite count, with data-path sanity
before/after. Never create a competing raw tty writer because a port looks idle.

## Builds, external waits, and efficiency

GitHub Actions `SUCCESS` is not `BUILD_OK`. Accept firmware, manifest, report,
resolved config, checksums, embedded identity, source/feed/profile identity and
artifacts before promoting build maturity.

Use `ACTIVE_ENGINEERING`, `EXTERNAL_RUNNING`, `WAITING_EXTERNAL`, and
`REVIEW_REQUIRED`. For a healthy long task with no actionable work, persist
phase, branch/SHA, workflow/run/attempt, profile/source, last gate, wait reason
and next action, then stop polling. No continuous watch, periodic polling,
heartbeat, or elapsed-time narration. Resume only on owner request, reported
change, or authorized event; reload context and query once.

Efficiency may remove duplicate reads, retries, builds and owner actions; it
must not weaken evidence, provenance, validation, artifact acceptance,
authorization, recovery or safety. Run static/fixture gates before requesting a
build. Batch only independently ready changes with causal isolation. Do not
blindly retry; after one corrected retry and one genuinely different safe path,
record the exact blocker.

Human assistance is last resort. Exhaust safe autonomous paths, identify the
tool/physical boundary, and request only the irreducible step with exact return
evidence and prohibitions. On return, reload context and resume only that gate.

Temporary probes, PCAPs, browser exports, secret-bearing helpers and scratch
files stay local/untracked and are removed after use; only sanitized conclusions
become durable.

## Stop conditions

Stop and record `BLOCKER`, `MISSING_EVIDENCE`, `NEXT_ACTION`, and the resume gate
when the next step crosses an owner gate, required evidence/provenance is
missing, a design contradiction appears, or repair would broaden scope. Never
hide failure, downgrade the design, use `|| true`, or infer success.
