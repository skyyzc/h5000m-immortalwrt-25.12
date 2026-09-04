# H5000M project rules

## Reload context first

At every new or resumed task, after context compaction, and after an interrupted
build, read `AGENTS.md`, `README.md`, `CHANGELOG.md`,
`docs/HIGO-FEATURES.md`, `docs/PACKAGES.md`, `versions/candidate.json` and
`versions/stable.json`. Then run `git status`, `git branch --show-current`,
`git log -5 --oneline` and `git remote -v`. Treat the repository as project
memory; never rely on chat history alone.

Read `docs/REFERENCE_EVIDENCE.md`, `docs/H5000M-ASSET-MAP-V1.md` and
`docs/H5000M-MIGRATION-BLUEPRINT.md` only when hardware, partitions, historical
behavior, Higo/RG520 origins, or migration provenance are relevant.

## Evidence and maturity

Use only `CONFIRMED`, `PARTIAL`, `INFERRED`, `UNVERIFIED`, and `UNKNOWN`.
`CONFIRMED` requires direct source, command, build, artifact, or device evidence;
never promote inference or unknown state without new direct evidence.

Keep maturity distinct: `CONFIGURED`, `BUILT`, `INSTALLED`, `RUNNING`, `UI_OK`,
`FUNCTION_TESTED`. A build does not prove device behavior, package presence does
not prove a running service, and a visible page does not prove functionality.

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

## Documentation and scope

Firmware-affecting changes update `CHANGELOG.md`; package/source/profile changes
also update `docs/PACKAGES.md`; Higo behavior or implementation changes update
`docs/HIGO-FEATURES.md`. Keep README architectural and durable.

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

Quota governance eliminates low-value waiting. It must never be used to skip
validation, log analysis, documentation, artifact verification, or necessary
evidence; weaken acceptance gates; guess a root cause; use an unverified
shortcut; or hide a failure.
