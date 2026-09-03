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
