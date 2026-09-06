# H5000M Project Charter

This is the highest-level persistent governance for the H5000M product. A
phase, defect, build, or session may advance one boundary but may not replace
this charter or make other product domains disappear.

## Product goal and permanent mainline

Maintain an evolvable ImmortalWrt 25.12 product for Hiveton H5000M:
ImmortalWrt 25.12 upstream -> H5000M hardware/vendor adaptation -> Higo + LuCI
+ RG520 `CORE_RESCUE` -> Rescue RAM closure -> Full Required capability
recovery -> Full Optional integrations -> Full RAM closure -> recovery/rollback
proof -> upstream/update/OTA lifecycle -> manual stable promotion ->
persistent/eMMC only after all required safety gates are proven and separately
authorized.

`CORE_RESCUE` is independent from Full Optional components. `FULL_REQUIRED`
capabilities are product capabilities that must be recovered, provenanced,
adapted, built, and function-tested rather than silently treated as optional
plugins. `FULL_OPTIONAL` remains permanently visible but does not block Rescue
unless a demonstrated dependency exists. Persistent/eMMC is prohibited in the
current phase.

Six permanent domains remain visible simultaneously:

- `PLATFORM_HARDWARE`: MT7987A board, boot, storage safety, Ethernet, LEDs,
  MT7992 Wi-Fi, calibration, thermal/fan and platform acceleration.
- `VENDOR_WIRELESS`: MT7992 driver, firmware, calibration and kernel
  compatibility.
- `RG520_MODEM`: RG520N-CN USB, QMI/QMAP, QModem, qmi_wwan_q, IPv4/IPv6 and
  reconnect/lifecycle behavior.
- `HIGO_PRODUCT`: Higo/LuCI coexistence, vendor API/UI and product functions.
- `FULL_CAPABILITIES`: wrtbwmon, OAF, fan, DiskMan/KSMBD, UPnP, DDNS, Watchcat,
  ZeroTier and later modular integrations.
- `LIFECYCLE`: source/provenance locks, build/ledger/artifacts, RAM validation,
  stable promotion, recovery/rollback, persistent deployment and updates.

## Blocker locality and priority

A blocker belongs to the smallest affected domain and gate. The newest issue
does not replace the roadmap. If it does not invalidate another domain, record
it and continue authorized work. Priority is `P0` safety/core connectivity,
`P1` required product/integration correctness, and `P2` optional or deferred
quality. Priority never weakens evidence or safety.

Use stop-loss engineering: confirm the first causal boundary, implement one
minimal repair, validate progressively, then observe the next causal boundary.
Do not endlessly iterate on nonblocking or evidence-starved hypotheses.

## Branch and evidence roles

- `rebuild-v1`: active product mainline and only current build source.
- `master`: legacy/historical evidence; do not merge unrelated legacy history
  into the product branch and do not use it as current build source.
- `work/`, `outputs/`, backups and extracted historical trees: research and
  reverse-engineering evidence, never implicit product source.

Classify legacy items as `MIGRATED`, `SUPERSEDED`, `REPLACED`, `PORTED`,
`DEFERRED`, `LOST`, `OBSOLETE`, or `UNKNOWN`. Historical operation is evidence
of capability, not proof the current product contains or runs it.

## Vendor and closed-source compatibility

Never transplant a Linux 6.6.94 kernel module into Linux 6.12. Identify the
capability first. Prefer maintained upstream/native, then maintained source with
exact provenance, and use a vendor shim only when necessary and auditable.
Kernel binaries, firmware blobs, EEPROM/calibration data and userspace contracts
are distinct assets. Validate function, not merely package/file presence.

## Rescue and Full policy

Historical Full is the capability baseline, not current maturity. It includes
Higo/LuCI, dual-band Wi-Fi, RG520 QMI/QMAP, IPv4/IPv6, wrtbwmon, OAF, fan PWM,
DiskMan, KSMBD, UPnP, DDNS, Watchcat and ZeroTier. Recover each via `RECOVER ->
PROVENANCE LOCK -> ADAPT -> BUILD -> RAM FUNCTION TEST`; retain `UNKNOWN` rather
than overstating evidence.

Maturity is `CONFIGURED`, `BUILT`, `INSTALLED`, `RUNNING`, `UI_OK`, and
`FUNCTION_TESTED`, scoped to an exact run. Rescue remains independent of
optional Full components.

## Validation and authorization

Validate the earliest affected boundary first and stop dependent downstream
checks when it fails. Only the owner authorizes formal builds, real-device/RAM
operations, and persistent/destructive actions. RAM initramfs validation and
power-cycle recovery precede persistent design. Stable promotion is manual.

Roles:

- ChatGPT/Owner-review conversation: requirements, decisions and authorization.
- Codex: evidence-led analysis, minimal implementation, validation and durable
  synchronization within authorization.
- GitHub Actions: isolated formal build/artifact generation, not device proof.
- Owner: physical device/U-Boot actions and build/persistent gates.

## Efficient durable memory

Read in order: Charter -> `PROJECT_STATE.md` -> task matrices/evidence. Expand
history only when evidence is insufficient or contradictory. Do not perform
routine broad audits or turn micro fixes into broad docs. Governance is not a
product feature and must not change runtime behavior.

## Canonical truth hierarchy and anti-drift

Authority is layered:

- `LEVEL 0 — Exact evidence`: Git commit identity, build manifests, artifact
  hashes, formal run evidence, and real-device evidence.
- `LEVEL 1 — Product strategy/policy`: this Charter.
- `LEVEL 2 — Durable capability truth`: `docs/PRODUCT-MATRIX.md`,
  `docs/VENDOR-COMPATIBILITY-MATRIX.md`, `docs/HIGO-FEATURES.md`, and
  `docs/PACKAGES.md`.
- `LEVEL 3 — Current operational state`: `PROJECT_STATE.md`.
- `LEVEL 4 — Chronology/history`: run ledger, `CHANGELOG.md`, and historical
  reports.

Lower levels must not silently redefine higher-level policy or exact evidence.
A run failure may update current state and an affected capability, but may not
rewrite product goals, remove another domain, change legacy migration policy,
or weaken safety. Reference the canonical owner instead of maintaining a
second independent copy whenever possible.

Canonical ownership is:

- the Charter owns product goal, permanent domains, branch roles, engineering
  governance, and safety policy;
- `PRODUCT-MATRIX` owns cross-domain capability coverage and status;
- `VENDOR-COMPATIBILITY-MATRIX` owns vendor/legacy migration classification;
- `HIGO-FEATURES` owns detailed Higo maturity, gaps, and next steps;
- `PACKAGES` owns component version, source, provenance, and adaptation truth;
- `PROJECT_STATE` owns only current phase/run/gate, identities, and pointers;
- exact build/device evidence owns observed facts for that exact run; and
- CHANGELOG/run ledger owns chronology and must not become current policy.

For conflicts: exact direct evidence wins over summaries for observed facts;
the canonical owner wins within its subject; and higher-level policy wins over
lower-level narrative. If two canonical sources genuinely conflict, mark
`CANONICAL_CONFLICT` and stop actions that depend on the unresolved fact. Never
resolve a contradiction by deleting historical evidence.

The Charter changes only for a real change to product goal, permanent domain
model, branch/repository governance, safety model, or durable engineering
governance. A new defect, run failure, package upgrade, fixture/test change,
build result, or temporary blocker does not by itself justify a Charter edit.

Every maturity/status promotion cites new evidence. Never strengthen
`UNKNOWN`, `UNVERIFIED`, `PARTIAL`, `BLOCKED_BY_EVIDENCE`, or
`HISTORICALLY_RUNNING` merely to make documents agree. When new evidence
contradicts an earlier conclusion, preserve the earlier evidence and record the
new state and reason.

Permanent capabilities in `PRODUCT-MATRIX` do not disappear when deferred,
blocked, unverified, or outside a task. Deletion requires an explicit
Charter-level product-scope decision. This invariant includes platform
hardware; MT7992/vendor parity; firmware/EEPROM/calibration; WED/HNAT/offload;
RG520 lifecycle/reconnect; complete Higo scope; historical Full recovery;
recovery and rollback; upstream lifecycle; OTA; stable promotion; and
persistent/eMMC safety.

A local blocker may raise priority within its domain, but must not erase,
downgrade, or silently defer unrelated domains. Only a demonstrable dependency
of the current milestone may make it a global `P0`.

### Governance and firmware identity separation

`GOVERNANCE_HEAD` is the current `rebuild-v1` commit containing governance and
documentation state. `FIRMWARE_IMPLEMENTATION_BASELINE` is the exact commit
whose runtime implementation is being validated. They may differ.

For Run 23, `RUN23_FIRMWARE_IMPLEMENTATION_SHA` is
`32e385cbbdfeace84d7bb9032cad18c753debb21`. Documentation-only commits must not
replace that identity or imply new firmware maturity. A later
`PROJECT_BUILD_SHA` may differ only when its relationship to the implementation
baseline is explicit. When only governance/docs changed, record
`RUNTIME_DELTA_FROM_FIRMWARE_BASELINE=NONE`; never infer firmware maturity from
`GOVERNANCE_HEAD`.
