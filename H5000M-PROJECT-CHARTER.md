# H5000M Project Charter

This is the highest-level persistent governance for the H5000M product. A
phase, defect, build, or session may advance one boundary but may not replace
this charter or make other product domains disappear.

## Product goal and permanent mainline

Maintain an evolvable ImmortalWrt 25.12 product for Hiveton H5000M:
ImmortalWrt upstream -> H5000M hardware adaptation -> permanent Higo
compatibility -> LuCI coexistence -> RG520N-CN -> optional integrations ->
Rescue RAM validation -> Full -> manual stable promotion -> persistent/eMMC
only after recovery and rollback are proven.

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
