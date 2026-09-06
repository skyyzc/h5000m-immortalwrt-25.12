# Codex task logs

## Purpose

Task logs are short, structured, sanitized execution summaries for significant
Codex engineering tasks. They support GitHub-based Owner/ChatGPT review without
requiring the original conversation.

They are not full Codex or shell transcripts, raw GitHub Actions/device logs,
canonical project state, or replacements for CHANGELOG, the formal run ledger,
or exact build/device evidence. Canonical ownership remains defined by the
project Charter; task logs only describe one task's execution.

Create a task log when work includes source/runtime changes, nontrivial RCA,
build trigger or failure analysis, formal artifact acceptance, real-device/RAM
validation, Full integration, vendor compatibility work, or significant
automation/tooling. A trivial typo or docs-only edit needs no standalone log
unless governance or traceability is itself the task.

## Format and safety

Use `TEMPLATE.md` or `scripts/record-task-log.sh`. Keep fields concise and use
`NONE` or `UNKNOWN` rather than omitting a required field. Names follow
`YYYY-MM-DD-TASK_ID.md`; existing logs are immutable unless overwrite is
explicitly requested.

Never include passwords, tokens, cookies, private keys, API secrets, IMEI,
ICCID, IMSI, SIM/phone identifiers, unique device serials or MAC addresses,
carrier credentials, real Wi-Fi passwords, raw secret-bearing commands, or raw
session material. Do not commit complete transcripts, build output, Actions
logs, PCAPs, or raw modem/device logs. Reference formal evidence or retain only
a minimal sanitized excerpt.
