# Changelog

## GOVERNANCE-ANTI-DRIFT-01

- Added a canonical truth hierarchy, subject ownership, conflict handling,
  Charter mutation, evidence promotion, permanent capability coverage, and
  anti-single-blocker contract to prevent future documentation drift.
- Separated the current governance HEAD from Run 23's firmware implementation
  baseline `32e385cbbdfeace84d7bb9032cad18c753debb21`; this documentation-only
  change has no runtime delta and does not alter Run 23 maturity.
- No firmware, config, package selection, source lock, build, device, or
  persistent operation occurred.

## PROJECT-CONSOLIDATION-V2

- Added the project Charter plus product-domain and vendor-compatibility
  matrices so six permanent domains, legacy migration classes, branch roles,
  Full capability baseline, blocker locality, and RAM-first lifecycle remain
  visible independently of the newest defect.
- Consolidated `AGENTS.md` into reusable execution, evidence, provenance,
  secret, owner-gate, and safety rules, and reduced `PROJECT_STATE.md` to
  current Run 21/22/23 maturity and durable pointers. Historical run/failure
  records were not rewritten.
- Preserved exact pre-consolidation Run 23 firmware implementation baseline
  `32e385cbbdfeace84d7bb9032cad18c753debb21`. No firmware runtime, config,
  package selection, source lock, build, device, Full, or persistent change.
- Deferred machine-readable run-ledger and capability-manifest generation until
  after Run 23 because current build/report integration is a separate formal
  build-contract change.
- Future entries record meaningful firmware changes, formal builds and
  failures/repairs, device evidence, milestones, and releases; routine micro
  edits need not create broad chronological noise.

## IPV6-RUN23-DISPATCH-REPAIR-01

- Preserved Run 22's exact-run failure and repaired only its confirmed first
  causal dispatch boundary. Locked netifd sets `INTERFACE` to the logical
  interface, sets `DEVICE` only for `ifup`/`ifupdate`, and omits `DEVICE` for
  `ifdown`; Run 22 observed `USBv6` over `wwan0_1`.
- The H5000M-only hook now requires `USBv6` plus `wwan0_1` for up/prefix-update,
  and requires `USBv6` with absent `DEVICE` for down. The helper now selects
  the `USBv6` ubus logical interface while retaining `wwan0_1` only as the
  hook's underlying-device guard.
- Added a deterministic Run 22 hotplug contract matrix: three positive
  lifecycle cases, ten absent/wrong/unrelated fail-closed cases, and repeated
  one-event/one-dispatch coverage. All 16 existing route, ownership, cleanup,
  rollback and idempotence fixtures remain passing. Double apply, exact
  install hashes, executable Git modes, Higo runtime-patch check, prohibited-
  mutation review, secret scan and diff checks passed.
- No source/feed lock, package selection, profile, unrelated firmware, device,
  Run 23/build, Full or persistent change occurred. Static readiness does not
  prove runtime dispatch, route creation, lifecycle or client IPv6; those
  remain for a separately authorized exact-run RAM validation.

## RUN22 exact-run Rescue RAM validation

- The owner RAM-booted the exact accepted Run 22 image. Artifact identity,
  embedded Run/project/source/profile identity, initramfs/tmpfs operation and
  read-only original squashfs all passed.
- The IPv6 repair failed at its first runtime dispatch boundary. netifd raised
  logical interface `USBv6` on device `wwan0_1`, while the installed hotplug
  hook accepted only `INTERFACE=wwan0_1`; it exited without invoking the
  reconciler. No owned metric-1 protocol-242 LAN route, helper state or helper
  log appeared, and the conflicting cellular metric-256 route remained ahead
  of the LAN metric-1024 route.
- Stopped before reconnect/lifecycle or two-client testing. Bounded sanity
  retained Higo/LuCI, LAN, radios, RG520, QMI/QMAP and device-side IPv6, but
  does not satisfy the full Run 22 regression contract.
- After owner power-cycle, original ImmortalWrt 24.10 squashfs/F2FS overlay,
  Higo/LuCI, LAN, radios and RG520/QMI/QMAP returned and Run 22 identity was
  absent. `RUN22_RAM_BOOT_OK=PASS`, `RUN22_FUNCTION_TESTED=FAIL`, persistent
  storage modified `NO`. No repair, Run 23, Full or persistent action occurred.
  Detailed evidence: `docs/RUN22-EXACT-RUN-RAM-VALIDATION-REPORT.md`.

## RUN22-BUILD

- Triggered exactly one authorized `rescue` / `candidate` build from accepted
  `rebuild-v1` project SHA
  `ca75cc3d6a9b7ce1907656d585fa1c5b283c030b`. Workflow `Build H5000M
  firmware`, Run ID `33987589482`, Run Number `22`, Attempt `1` completed
  `SUCCESS` in `2h28m02s` against locked ImmortalWrt
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`.
- Exact source/feed preparation, double apply, IPv6 fixtures/static/install,
  defconfig/resolved config, H5000M, Higo, RG520/QModem/qmi_wwan_q,
  diagnostics, compile, manifest/report/checksum generation, and artifact
  upload gates passed. The only GitHub annotation was the deferred Node.js 20
  Actions warning; it was not a build failure.
- Accepted artifact `h5000m-rescue-ca75cc3d-1d34e7b8-run22-attempt1`, ID
  `9977722506`, downloaded archive size `20042327` bytes and GitHub/archive
  digest `sha256:c29736f4f0f7d8ff5fdb9a0555a44a81e68ffa97bf2274ea34026fbc238c4d69`.
  Firmware `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`
  is `19975104` bytes with SHA256
  `bacb594c5fcbfe37e562efc8bef584a635848bc6b7e27bc87f0f8a3e85bb7d4a`.
- `SHA256SUMS` verified the firmware, manifest, report and resolved config.
  Manifest/report/feed/profile/run/project/source identities agree. Embedded
  `/etc/h5000m-build.json` agrees with Run 22, Rescue, project and ImmortalWrt
  identities. The initramfs contains exact approved executable bytes for the
  IPv6 helper (SHA256
  `bbcb9fdc43c402e1d98e0eb12e1bf019f7d993c811fd4e1593f94249fda9cdcd`)
  and hotplug hook (SHA256
  `a786c8c45bffa0cd09863faa0b195156bd3f850e8557e62200ddd8eac3ea7a97`).
- Run 21 and Run 22 requested/resolved configs are identical; source locks and
  package selections did not change. Cross-build byte comparison also changed
  generated APK signing metadata and one same-size rebuilt binary, so
  byte-for-byte reproducibility remains `UNVERIFIED`; this is not evidence of
  an unrelated source/feature delta. The existing empty optional
  `kernel.version` manifest field remains explicitly `UNKNOWN`; FIT identifies
  Linux `6.12.103` and all required build identities remain intact.
- `RUN22_BUILD_OK=YES` and `RUN22_ARTIFACT_ACCEPTANCE=PASS` are build-scoped.
  RAM boot, device and function maturity remain `UNVERIFIED`. No Run 23,
  device/persistent action, Full, source-lock/package-selection/profile change,
  Notification/neighbour repair, or stable promotion occurred.

## IPV6-RUN22-IMPLEMENTATION-01

- Implemented the approved IPv6-only PROJECT_LOCAL shared-prefix route
  reconciler and locked netifd iface hotplug entry. It accepts exactly one
  canonical global-unicast shared RFC7278 `/64`, owns only the `br-lan` metric
  `1` protocol `242` route, uses atomic runtime-only lock/state, reconciles
  renewal/reconnect/teardown, preserves foreign routes, and fails closed on
  malformed/ambiguous state, ownership conflicts, command failures, or target
  numeric-protocol parser rejection.
- Added 16 deterministic fixtures covering valid, absent, malformed, multiple,
  non-shared, ULA/link-local, repeat/idempotence, replacement, teardown, stale
  recovery, foreign preservation, command/verification failure, and ownership
  mismatch paths. Added exact-file, executable-mode, shell syntax, BusyBox
  numeric route-protocol, install, lifecycle, ownership, and prohibited-
  mutation gates to the existing build preparation flow.
- Registered the helper as PROJECT_LOCAL provenance and retained the approved
  Run 22 exact-run RAM acceptance contract. No source lock, package/profile
  selection, unrelated firmware feature, device, persistent storage, build,
  Run 22, Full, CPE, Notification, or neighbour change occurred.

## GOVERNANCE-02

### IPV6-RUN22-PREIMPLEMENTATION-REVIEW

- Reconfirmed Run 21's packet/route RCA as
  `CONFIRMED_SAME_PREFIX_RETURN_ROUTE_COLLISION` and retained the selected
  native `DYNAMIC_PREFERRED_LAN_SHARED_PREFIX_ROUTE` design.
- Closed the implementation contract around the locked netifd `iface` events:
  `ifup`, prefix-marked `ifupdate`, and `ifdown`; specified exact route
  ownership, metric preference, serialized reconciliation, atomic runtime
  state, renewal/reconnect replacement, stale/duplicate prevention, rollback,
  fail-closed behavior, and foreign-route preservation.
- Defined the IPv6-only minimal delta and exact Run 22 build/RAM/function/
  lifecycle/regression/recovery contract. `IPV6_IMPLEMENTATION_UNBLOCKED=YES`
  and `RUN22_CHANGESET_READY=YES`; `BUILD_WORTH_TRIGGERING=NO` until an
  authorized implementation exists and passes static gates. No implementation,
  firmware/config/package/source-lock, device, build/Run 22, Full, or
  persistent change occurred.

### HUMAN_ASSIST_MINIMIZATION

- Made autonomy-first execution permanent: human assistance is allowed only
  for required evidence after safe autonomous investigation, capability and
  alternative-path checks, and reduction to the irreducible owner action.
  Added mandatory browser capability/level prechecks and an evidence-specific
  expanded assist contract without weakening evidence, authentication,
  physical, RAM-first, persistent, or destructive-operation gates.
- Reassessed the Run 21 CPE chain from API wrapper through the sole `F` state,
  candidate resolver, and rendered title. No static second instance, hidden
  normalization, watcher/effect mutation, or alternate title source was found;
  the visible badge/title contradiction remains runtime evidence, not a proven
  cause.
- Paused and replaced the former nine-step owner flow. Current tools can cover
  ordinary browser automation but expose no connected Chrome session,
  DevTools debugger, breakpoint, or paused local scope, so only that final
  paused-scope capture remains human-assisted. No firmware/device/build/Run 22,
  Full, package/config/source-lock, or persistent change occurred.

### CPE-RUN21-LIVE-STATE-01

- Accepted the reduced paused-scope evidence. Run 21 supplied `mode=auto`,
  selected `[4G,5G]`, normalized key `4G|5G`, no direct preset match, and the
  patched resolver returned the synthetic `4G + 5G` entry.
- At a post-computed render boundary, `st` and `Tt` resolved `4G + 5G`, `Jt`
  resolved `4G / 5G`, and the resumed real Higo UI visibly displayed
  `4G + 5G`. Intermediate undefined values captured while the computed getters
  were paused/running are debugger re-entry artifacts, not product outputs.
- Closed `RUN21_CPE_FUNCTION_TESTED=YES` and the Run 21 validation contract.
  Retained the earlier unknown-title observation as a non-reproduced partial
  timing/state discrepancy; no unsupported exact RCA is claimed. No repair,
  firmware, build/Run 22, Full, device-setting, or persistent change occurred.

- Added `PROJECT_STATE.md` as a compact current-state index, explicitly
  separating Run 20's function-tested Rescue baseline from Run 21's accepted
  but device-unverified firmware generation.
- Replaced the mandatory full-history startup reload with three layers:
  `AGENTS.md` + `PROJECT_STATE.md` + current task always, task-scoped evidence
  as needed, and historical evidence only for conflict, regression, root cause,
  provenance, recovery or comparison. CHANGELOG writing remains mandatory;
  full CHANGELOG reading does not.
- Made run-scoped maturity, the lightweight Current Task contract, controlled
  upstream lifecycle, the persistent-safety-blocked online-update target, and
  modular independently provenanced plugin architecture permanent rules.
  Context reduction is retrieval-only and does not weaken engineering,
  evidence, provenance, security, build, device or owner-authorization gates.

## Rebuild V1 / DEVICE-01

### CPE-RUN21-LIVE-BODY-01

- Accepted human-assisted Chrome Incognito / DevTools Network evidence for the
  exact Run 21 CPE chunk request. Its response excerpt contains the Run 21
  patched `4G|5G -> 4G + 5G` resolver exactly once and no canonical fallback
  resolver, independently matching the repository patch anchor.
- Promoted `CPE_LOADED_CHUNK_IDENTITY=RUN21_PATCHED` and rejected the stale
  canonical browser-cache hypothesis. The supplied file is a curated excerpt,
  not the complete byte-identical 85584-byte response, so
  `CPE_LOADED_CHUNK_HASH=UNKNOWN` remains rather than hashing the excerpt as if
  it were the loaded chunk.
- The patched resolver still accompanied the visible `未识别配置` title.
  `CPE_RCA=UNKNOWN` and `CPE_REPAIR_UNBLOCKED=NO`; the next evidence gate is
  live Vue state/resolver input-output proof. No firmware, device, build,
  Run 22, Full, source/package/config/lock, workflow, or persistent change was
  made.

### ENGINEERING-EFFICIENCY-01

- Added permanent evidence-preserving execution classes, readiness-based build
  batching, build-worthiness fields, durable non-blocking deferral, and
  independently matured plugin batches. Efficiency may remove duplicate work
  but cannot weaken issue closure, direct evidence, exact-run validation,
  provenance, authorization, modem ownership, rollback, security, or
  candidate/stable gates.
- Added bounded no-progress retry handling, explicit interactive-stall classes,
  no-silent-skip outcomes, a fixed minimal human-assist request/return contract,
  and dependency-aware continuation. Human assistance cannot bypass an owner
  gate and resumes only the blocked branch.
- Prepared (but did not execute) `CPE-RUN21-LIVE-BODY-01` for a browser
  response-body/HAR or equivalent debugger proof. CPE RCA remains `UNKNOWN` and
  unready; the confirmed IPv6 design remains ready, so the combined Run 22
  changeset is not ready and no build was triggered.
- Classified `tmp/run21_cpe_probe.sh` as untracked, run-specific local scratch
  with no Git history: `UNTRACKED_NO_ACTION`. Added temporary-diagnostic and
  governance anti-bloat rules. No firmware, device, source/package/config/lock,
  workflow, Full, build, Run 22, or persistent-storage change occurred.

### CPE-EVIDENCE-01

- Rebooted the already accepted Run 21 Rescue in RAM through the owner-only
  gate and captured an authenticated HTTP 200 network-mode fixture. It remains
  `mode=auto`, selected `4G + 5G`, supported `3G/4G/5G`, matching QModem
  `3G=0,4G=1,5G=1`; no modem or network setting changed.
- A new isolated Higo browser tab requested
  `/assets/CPEManagement-CuEyMeyg.js` and still displayed `未识别配置`. The
  device served the Run 21 patched bytes at that URL (85584 bytes, SHA256
  `f8eef73d3abe39a5170c3d84f952bbf5683690b6f240a23a9d58a783d2e33ad0`),
  not the canonical vendor bytes. Response metadata had a fixed epoch
  `Last-Modified` and no observed explicit cache-control validator policy.
- The browser inventory exposed the request URL but not the already evaluated
  response body/hash. Therefore the evidence rejects a wrong server asset but
  cannot yet choose between cached canonical bytes and patched-code runtime
  data shape. `CPE_RCA=UNKNOWN`, `CPE_REPAIR_UNBLOCKED=NO`; no firmware,
  package/config/source lock, Run 22, Full, device state, or persistent storage
  changed. Details are in `docs/CPE-EVIDENCE-01.md`.

### DEVICE-01G Run 21 repair design and AUTH-FRICTION-02

- Traced the CPE source path from the authenticated API through the sole
  CPE chunk resolver to the visible current-configuration title. The title and
  `4G / 5G` badge are separate computed paths; no second renderer was found.
- Confirmed the Run 21 patch changed the CPE chunk bytes but retained the same
  content-hashed filename and unchanged lazy-load reference. Stale normal
  browser cache or an already evaluated Run 20 module is the leading cause,
  but the Run 21 browser-loaded bytes were not captured. CPE RCA therefore
  remains `UNKNOWN`, with an exact fresh-context URL/hash/API evidence gate;
  no speculative CPE repair or Run 22 delta was approved.
- Preserved the confirmed IPv6 same-prefix return-route collision and compared
  three native approaches. Selected a future dynamic, uniquely owned,
  lower-metric LAN route for the current RFC 7278 shared `/64`, maintained on
  DHCPv6/netifd lease events. NAT66 and proxy-NDP remain unnecessary because
  Run 21 proved that matching client replies already arrive over QMAP.
- Added permanent issue-closure lifecycle, vendor UI live-path proof, and
  two-client-OS network validation rules. Added finite H5000M-only default
  credential candidates, explicit authentication levels, safe session reuse,
  and temporary/project-local host-key handling without weakening global SSH
  verification or persistent/state-changing operation gates.
- Created `docs/DEVICE-01G-RUN21-REPAIR-DESIGN.md`. This phase changed only
  governance/design evidence; no firmware, source/config/package/version lock,
  device state, build, Run 22, Full, or persistent storage changed.

### Run 21 Rescue RAM validation

- The owner manually loaded the accepted Run 21 initramfs through U-Boot
  Recovery WebUI. Runtime identity matched Run ID `33951063311`, Run number
  `21`, project `ab4d2cbaa8e1b9fa8742ae397b15399f535a50d1`, ImmortalWrt
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`, and profile `rescue`.
- RAM/persistent-safety gates passed: `/` was tmpfs, the original squashfs was
  mounted read-only, and no persistent overlay or persistent operation was
  used. LAN, DHCP, SSH, authenticated Higo and LuCI, both real-client Wi-Fi
  bands, RG520 USB, `qmi_wwan_q`, QModem/QMI/QMAP, and device-side IPv4/IPv6
  passed bounded regression.
- The mandatory CPE repair function test failed. QModem remained
  `3G=0,4G=1,5G=1`, and the UI exposed a `4G / 5G` badge, but the live current
  configuration title still displayed `未识别配置`. This is retained as a
  Run 21 repair failure; no modem/network setting was changed.
- Bounded concurrent ICMPv6 captures localized the client failure. Requests
  appeared on `br-lan` and `wwan0_1`; matching replies arrived on `wwan0_1`
  but never returned through `br-lan`. The same delegated `/64` was installed
  on LAN and cellular, and read-only route lookup selected `wwan0_1` for the
  LAN-client destination. Root cause is therefore confirmed as a local
  same-prefix return-route collision; no IPv6 repair was attempted.
- The client IPv6 ICMP and numeric-target HTTPS tests failed, while client IPv4
  and device-side IPv4/IPv6 remained working. Raw PCAP and unique addresses
  were kept temporary, sanitized from durable evidence, and deleted.
- Final RAM-session logs showed no panic, oops, core crash, modem reset, or new
  critical storage failure. After the owner performed a normal physical power
  cycle, original ImmortalWrt 24.10 squashfs/overlay, Higo/LuCI, LAN, radios,
  RG520/QMI/QMAP, and device-side IPv4/IPv6 returned; Run 21 identity was
  absent. No eMMC, GPT, U-Boot, BL2, factory, or firmware state was modified.
- Run 21 RAM boot, identity, persistent safety, core device regression, and
  power-cycle recovery pass. `RUN21_FUNCTION_TESTED=NO` because the defined
  validation contract included the mandatory CPE repair gate, which failed.
  Notification and neighbour received no Run 21 change. No Run 22 or Full
  build was started.

### BUILD-03 / Run 21 dispatched

- Owner-approved Rescue/candidate build dispatched as GitHub Actions Run 21
  (`33951063311`), attempt 1, from `rebuild-v1` project commit
  `ab4d2cbaa8e1b9fa8742ae397b15399f535a50d1` with locked ImmortalWrt
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`.
- Pre-build gates passed for the seven-case CPE fixture, strict patch-anchor
  rejection and idempotence, canonical/vendor and PROJECT_LOCAL runtime hashes,
  single intended runtime-asset delta, unchanged QModem inputs,
  `tcpdump-mini` selection/provenance/no-autostart, and tracked-secret scan.
- Initial workflow evidence confirms the correct branch and project SHA, with
  checkout complete and dependency installation running normally. At dispatch,
  result and artifact identity were `UNKNOWN`; no device, Full, RAM-boot or
  persistent operation was authorized or performed.
- Run 21 completed `SUCCESS` in 2h38m08s. The accepted GitHub artifact is
  `h5000m-rescue-ab4d2cba-1d34e7b8-run21-attempt1` (artifact ID
  `9967061702`, archive size 20037155 bytes, GitHub digest
  `sha256:23f3c17efec1633621b30f4fdc002db2f5565931bc2dbfe2b56256afb3a26b82`).
- Artifact acceptance passed for manifest, report, requested/resolved config,
  SHA256SUMS and embedded build identity. The resulting H5000M Rescue initramfs
  is 19970460 bytes with SHA256
  `17d771fc5a1f469c0a56e5c92e8877bc0f8b700321de8860254304503b78d960`.
- Firmware inspection confirmed the separately traced PROJECT_LOCAL CPE runtime
  tree, preserved canonical vendor-source hashes, seven-case fixture gate,
  `tcpdump-mini 4.99.6-r1` with `libpcap1 1.10.6-r1`, and no tcpdump autostart.
  QModem, neighbour and Notification behavior were unchanged. Run 21 remains
  untested on hardware. The Node.js 20 deprecation notice is deferred CI
  maintenance and did not affect build or artifact success.

### DEVICE-01F-II implementation review

- Prepared the minimal Run 21 Rescue delta without triggering a build: a
  deterministic display-only Higo `4G + 5G` normalization patch plus
  `tcpdump-mini` for future bounded IPv6 packet attribution.
- Preserved the canonical vendor frontend and added distinct PROJECT_LOCAL
  patch, transformed-asset and patched-runtime-tree hashes. Extended Higo
  validation and build manifest/report semantics so patched runtime bytes are
  never described as byte-identical vendor payload.
- Added seven CPE fixtures preserving every existing profile label, recognizing
  `4G + 5G`, retaining the unknown fallback, and proving patch idempotence.
- Compared native-helper and narrow-ubus notification architectures; neither
  has a proved Higo invocation boundary, so Notification remains out of Run 21.
  IPv6 remains root-cause `UNKNOWN`, neighbour receives no firmware change,
  and no device, Full, persistent-storage or workflow action occurred.

### DEVICE-01F-E2 evidence closure

- Captured an authenticated Run 20 CPE network-mode fixture and correlated it
  with QModem in the same window. The backend/API correctly represented
  `4G + 5G`; the Higo frontend lacks a matching preset, confirming the failure
  boundary at frontend normalization.
- Proved the existing QModem AT ownership path and executed exactly one bounded
  read-only neighbour query. The modem returned `OK` without a neighbour data
  row; Higo and QModem consistently returned empty LTE/NR arrays. QMI/QMAP
  session continuity passed after the query.
- Kept notification storage `UNKNOWN` because no callable end-to-end
  typed/atomic UCI transaction boundary exists. Kept IPv6 root cause `UNKNOWN`
  and recorded the need for packet-attributed evidence. No firmware, source
  lock, Run 21, Full build or persistent state was changed.

### Project authorization policy

- Made H5000M authentication, read-only evidence acquisition and local raw
  analysis default-authorized while retaining sanitized durable records.
  Credentials may be used through normal protected local mechanisms without
  repeated approval, but remain prohibited from Git, documentation, firmware,
  CI, artifacts and public/shared logs.
- Classified bounded query-only AT commands by semantics rather than the
  presence of `=`. They are allowed only through a proved existing ownership
  path with before/after data-path checks; competing direct tty access remains
  prohibited. Persistent, destructive and state-changing operations retain
  their explicit owner gates.
- `AUTH_POLICY_UPDATED = YES`. This governance change does not modify firmware,
  configuration, packages, profiles or source locks.

### DEVICE-01F-E Missing Evidence Acquisition

- Completed a read-only Run 20 Rescue RAM evidence session without firmware,
  source-lock, persistent-device or build changes. Identity, tmpfs/read-only
  storage, LAN/SSH and RG520/QMI/QMAP sanity gates passed.
- Captured QModem network preference (`3G=0`, `4G=1`, `5G=1`) and the Higo
  current/pending presentation contradiction. The credential-safe boundary did
  not expose authenticated raw API JSON, so no profile/mode fix is inferred.
- Confirmed DHCPv6 delegation to LAN, forwarding and fw4/QMAP paths while a
  real client failed numeric IPv6 ICMP and numeric IPv6 HTTPS. Root cause stays
  `UNKNOWN` without packet-attributed evidence.
- Confirmed successful structured QModem neighbour output with empty LTE/NR
  arrays, closing the first empty boundary at `QMODEM_CONTROLLER_EMPTY` but not
  modem-versus-parser root cause. No raw AT command was issued.
- Found no callable typed/atomic UCI transaction contract for a PROJECT_LOCAL
  notification adapter. DEVICE-01F-II remains blocked and Run 21 was not
  triggered.

### DEVICE-01F-I Implementation Review

- Applied the approved CASE C rather than manufacturing a Run 21 changeset.
  Both compatibility implementations are blocked on missing proof; no firmware,
  profile, package or source-lock input changed and Run 21 was not triggered.
- Confirmed the Higo loader can select a PROJECT_LOCAL `api.lua` wrapper and
  delegate to an unchanged vendor dispatcher, but found no proved safe typed/
  atomic UCI transaction boundary for notification settings. An in-memory or
  shell-based speculative implementation was rejected.
- Corrected the CPE current-configuration contract from the earlier inferred
  `profileName` model to the frontend's proved `/cpe/network-mode` `mode` or
  normalized `selectedNetworks` match. The actual failing Run 20 response and
  closed-backend conversion remain `UNKNOWN`, so no profile/mode UCI change was
  made and the proven QMI/QMAP path remains untouched.
- Retained IPv6 and neighbour work as manual, bounded diagnostic plans. Image-
  resident collectors alone do not justify a complete build and would not
  resolve either unknown root cause.

### DEVICE-01F Repair Design

- Added a review-only Rescue compatibility repair design covering exactly the
  four DEVICE-01 gaps: LAN-client IPv6, Higo notification settings, RG520
  canonical profile recognition and neighbour-cell reporting.
- Defined a bounded, sanitized IPv6 evidence plan and hypothesis matrix. The
  IPv6 root cause remains `UNKNOWN`; no NAT66, proxy-NDP, fw4, odhcpd, QModem
  or policy-routing change is proposed without runtime boundary evidence.
- Defined a project-local Higo notification settings adapter contract and an
  additive RG520N-CN normalized profile contract that preserves the proven
  QMI/QMAP dial path. Defined exclusive AT/QMI ownership and a read-only,
  evidence-first neighbour-cell plan; its root cause remains `UNKNOWN`.
- Defined the proposed Run 21 changeset, build gates and RAM retest plan without
  implementing code, changing source/profile/package locks, triggering Run 21,
  starting Full or modifying the device.

### DEVICE-01R Analysis

- Added a durable Original 24.10 -> Run 20 Rescue -> expected Full feature-gap
  audit with an explicit Rescue/Full contract, per-feature frontend/backend,
  ownership, provenance, validation, dependency and priority classification.
- Preserved all accepted Rescue core evidence while clarifying that
  `DEVICE_OK=YES` and `FUNCTION_TESTED=YES` do not mean final feature
  completeness. `RESCUE_CORE_VALIDATED=YES`, `FINAL_FEATURE_COMPLETE=NO`, and
  `FULL_INTEGRATION_COMPLETE=NO` are now explicit.
- Traced the Higo notification failure to frontend routes without matching
  handlers in the current hash-pinned Lua dispatcher, and the CPE profile label
  to the generic project-seeded RG520N-CN profile lacking a canonical shared
  Higo/QModem mapping. LAN-client IPv6 and neighbour cells remain accurately
  `ROOT_CAUSE=UNKNOWN` with narrowed boundaries and explicit evidence plans.
- Confirmed read-only on the restored original system that the original Full
  package set includes wrtbwmon, OAF, fancontrol, DiskMan, KSMBD, UPnP, DDNS,
  Watchcat and ZeroTier foundations. Presence was not promoted to function
  evidence, and unknown source SHAs remain unknown.
- No firmware/config/source lock was changed; no Run 21, Full build, device
  write or mutating AT command was performed.

### DEVICE-01B Validation

- Completed the mandatory power-cycle recovery test. The device returned to the
  original ImmortalWrt `24.10-SNAPSHOT` / Linux `6.6.94` system with its
  squashfs/F2FS storage layout, five-partition eMMC layout, Higo, LuCI, SSH,
  both radios and RG520/QMI data path intact. The original 2.4/5 GHz channels
  are 6/44, and the Run 20 embedded build-identity file is absent as expected.
  No persistent eMMC, GPT, U-Boot, BL2, factory or modem change was found.
- DEVICE-01 RAM validation is recorded as `PASS_WITH_KNOWN_ISSUES` with
  `RAM_BOOT_OK=YES`, `DEVICE_OK=YES`, and power-cycle recovery passed. It remains
  `REVIEW_REQUIRED` because LAN-client IPv6, Higo notification operations, CPE
  profile recognition and neighbour-cell reporting have explicit unresolved
  results; no repair or new build is implied by this evidence update.
- Run 20 Rescue passed independent real-client tests on both 2.4 GHz and 5 GHz:
  association, DHCP lease, Higo access through Wi-Fi, and Internet traffic all
  succeeded on each band. Both Wi-Fi gates are `FUNCTION_TESTED`; unrelated
  device gates retain their independently observed status.
- Authenticated Higo login, dashboard, system status and 5G/signal reads passed.
  Device/connection/application widgets lacked useful data, and the CPE current
  configuration reported an unrecognized 4G/5G profile; these remain explicit
  feature/integration gaps rather than being hidden by the working data path.
- Authenticated LuCI Overview, network-interface and system-log reads passed;
  Higo and LuCI were usable concurrently on their required ports.
- Higo CPE connection status displayed correctly. SMS, SIM, band-lock and
  traffic-management pages reached `UI_OK` for read-only display; their
  mutating operations remain untested. The neighbour-cell page repeatedly
  reported no neighbour data despite registration, and the existing
  unrecognized-current-profile gap remained visible.
- Higo logs and the safe terminal `uptime` command passed. A runtime scheduled
  task was created successfully and then deleted; no residual task state was
  found and the original partition remained read-only. The notifications page
  rendered, but every attempted operation failed with a `not found` system
  configuration error, establishing a backend integration gap.
- The same Run 20 initramfs remained stable for about 15h57m with its embedded
  identity unchanged, persistent root still tmpfs, original squashfs still
  read-only, core services/interfaces running, and RG520/QMAP Internet intact.
  The bounded review found no panic, oops, service crash, modem reset or QMI
  failure.
- Run 20 device-side cellular IPv6 passed, but a real LAN client with RA-derived
  IPv6 addresses and a live default route could not reach an external numeric
  IPv6 endpoint by ICMP or HTTPS. The LAN-client IPv6 data path is a recorded
  `FAIL`, distinct from the working device-side path and not attributed only to
  DNS or ICMP filtering.
- The user unintentionally performed one 5 GHz channel write and one AT command.
  Read-only follow-up found the channel at 44, the initramfs root in tmpfs, the
  original partition read-only, and Wi-Fi/RG520/data paths healthy. The channel
  write is runtime-only for this boot. The command was identified as read-only
  `ATI`; it returned module identification without changing modem configuration
  or interrupting the observed QMI/QMAP data path.
- Added project-scoped credential authorization to `AGENTS.md`. Explicitly
  provided or securely configured local H5000M credentials may be reused for
  ordinary project authentication without repeated authorization, while
  plaintext storage/logging/transmission remains prohibited and all persistent
  or destructive device-operation gates remain unchanged.

### Pre-RAM-Boot Readiness

- Corrected the readiness model for the device's confirmed
  `Yuzhii0718/bl-mt798x-dhcpd` Recovery WebUI path. `Load initramfs`, rather
  than manual TFTP/load-address/`bootm`/`booti`, is the selected temporary RAM
  boot mechanism; manual RAM address and boot-command fields remain in the
  ledger as `NOT_REQUIRED_FOR_WEBUI_PATH` for auditability.
- Recorded the permanent current constraint `NO_TTL = YES` and
  `NO_SERIAL_CONSOLE = YES`; absence of TTL is not a device failure.
- Reconfirmed the exact Run 20 image size and SHA256 locally. The user-confirmed
  Recovery WebUI and its visible `Load initramfs` function agree with upstream
  documentation for booting OpenWrt/ImmortalWrt initramfs images.
- Separated `Load initramfs` from prohibited persistent WebUI functions,
  including firmware, U-Boot, BL2 and Factory updates, Flash Editor,
  Environment Manager and UBI management.
- DEVICE-01A is ready for the mandatory user-operated RAM boot. Codex has not
  entered U-Boot, uploaded or started an image, rebooted the device, or modified
  persistent storage. Power-cycle recovery is design-confirmed and remains to
  be function-tested at the end of DEVICE-01B.

## Rebuild V1 / BUILD-02

### Project Memory

- Added durable repository rules in `AGENTS.md`.
- Added the H5000M firmware engineer SOP Skill.
- Added concise reference evidence, asset, and migration maps.

### Source

- Starting project commit: `de73dcd2090a2d28c593f77a3f2882029d086d47`.
- Candidate source locks are unchanged from BUILD-01.5.

### Added

- Exact resolved-config, Higo payload/install-tree, native board and image gates.
- Per-build firmware identity, manifest, build report and SHA256SUMS generation.
- Run-specific GitHub Actions artifact identity and retained build log.
- A deterministic 60-file frontend tree digest beside the preserved canonical
  historical frontend payload digest.
- Codex Resource / Quota Governance: healthy long-running external builds enter
  `WAITING_EXTERNAL`, repeated polling is prohibited, context is preserved
  before waiting, resume requires Context Reload, and quota optimization cannot
  weaken validation or evidence requirements. This is project governance, not
  a firmware functional change.
- Added the Formal Build Ledger Rule for durable `SUCCESS`, `FAILURE`, and
  `CANCELLED` build records without deleting earlier failed-run evidence.
- Added the Package / Integration Provenance Rule, including Origin/Ownership
  categories and mandatory adaptation, validation, issue, and update history.
- Clarified the non-overlapping responsibilities of `CHANGELOG.md`,
  `docs/PACKAGES.md`, `docs/HIGO-FEATURES.md`, and the candidate/stable locks,
  and preserved the permanent upstream-to-safe-persistent project mainline.

### Fixed

- ERROR: Run 19 (ID `33828304097`, attempt 1, project
  `8bb925f39f27b547fd0b5d065fd5cd9ec20552b8`, Rescue/candidate, FAILURE after
  about 1h52m) completed `make world` through `checksum`, then the project
  artifact gate reported no H5000M initramfs image. ROOT CAUSE: artifact
  collection and manifest generation assumed an `.itb` suffix, while the
  locked H5000M image definition inherits the generic
  `-initramfs-kernel.bin` suffix. DOWNSTREAM ERROR: BUILD-MANIFEST,
  BUILD-REPORT, SHA256SUMS and success upload were not produced. WARNINGS: the
  Node.js 20 Actions deprecation and unselected package dependency warnings are
  deferred and were not causal. REPAIR: select and hash the exact H5000M
  `initramfs-kernel.bin` output without changing source locks, configuration,
  packages, or acceptance gates. REPAIR COMMIT: `78f622f`. Next Run: Run 20,
  ID `33836565597`, attempt 1, project `698aecdc52218c3565239e97bfd224b6c4af8f02`,
  Rescue/candidate.
- ERROR: Run 18 passed every source/config/H5000M/Higo/RG520 gate, then failed
  before download at unsupported make target `kernelversion`. ROOT CAUSE: this
  ImmortalWrt tree exposes evaluated variables through the generic `val.%`
  target. CHANGED FILES: `scripts/build.sh`, `scripts/generate-manifest.sh`.
  BEFORE: `make kernelversion`; AFTER: `make val.LINUX_VERSION`. IMPACT: build
  identity only; no firmware selection or source/package behavior change.
  EVIDENCE: Run 18 diagnostics and locked `include/toplevel.mk`.
- ERROR: Run 17 failed the resolved-config gate before compile because
  `CONFIG_PACKAGE_mt7992-23-firmware` resolved to not selected. ROOT CAUSE: the
  requested symbol omitted the kernel-package `kmod-` prefix; the native device
  definition and mt76 Makefile use `kmod-mt7992-23-firmware`. CHANGED FILES:
  `configs/rescue.config`, `scripts/validate-config.sh`. BEFORE: invalid symbol.
  AFTER: exact package symbol. IMPACT: restores the mandatory MT7992 firmware
  gate; no source lock, Higo, RG520 or network behavior change. EVIDENCE: Actions
  Run 17 first causal error and locked source Makefiles.
- ERROR: workflow dispatch returned HTTP 404 before creating a run. ROOT CAUSE:
  BUILD-02 used a workflow filename not registered on the default branch.
  CHANGED FILE: `.github/workflows/build-h5000m-private.yml`. FIX: place the
  branch workflow at the already registered path and hard-code the authorized
  candidate source while retaining the accepted Rescue profile input. IMPACT:
  CI dispatch only; no source lock, Higo, RG520, network or Wi-Fi change.
- Feed preparation now indexes exact locked commits and verifies every feed HEAD
  before package installation; the previous branch-index/late-checkout sequence
  could leave stale indexes even when final Git HEADs appeared locked.
- Rescue explicitly requests uhttpd, dnsmasq, USB3 and the MT7996 driver so
  `defconfig` cannot silently rely on target defaults for mandatory gates.

### Changed

- Repository state, not chat history, is now the authoritative project memory.
- Parallel compile now retries once with `-j1 V=s` to preserve the real root
  cause, without ignoring failure or reducing the Rescue target.
- Failed runs upload available requested/resolved configs and logs under a
  diagnostics-only artifact name; they cannot be confused with firmware.

### Build

- Run 17 (`33827585087`): FAILURE at resolved config; corrected the MT7992
  firmware symbol.
- Run 18 (`33827939372`): FAILURE after gates; corrected kernel identity target
  invocation.
- Run 19 (`33828304097`): FAILURE after successful compile; corrected the
  H5000M initramfs artifact suffix selector.
- Run 20 (`33836565597`), attempt 1: SUCCESS on project
  `698aecdc52218c3565239e97bfd224b6c4af8f02`, branch `rebuild-v1`, profile
  `rescue`, source `candidate`, locked ImmortalWrt
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`.
- Run 20 passed exact source/feed preparation, double apply/idempotence,
  defconfig, resolved config, H5000M, Higo, RG520/QModem, compile, artifact
  generation and upload.

### Artifacts

- `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`
  (`19778796` bytes), SHA256
  `af4f129d68cbb0b2e6d06ed2dbccd64e100bc7403cf69f62b95093d7e86af13e`.
- `BUILD-MANIFEST.json`, `BUILD-REPORT.md`, `resolved.config`, and
  `SHA256SUMS` were present and all recorded hashes verified locally.
- The FIT ramdisk contains `/etc/h5000m-build.json`; its Run ID/number,
  project SHA, ImmortalWrt SHA and Rescue profile match Run 20 and the manifest.

### Validation

- SOURCE_LOCKED: CONFIRMED
- CONFIG_RESOLVED: CONFIRMED
- BUILD_OK: CONFIRMED (single Linux clean Rescue/candidate build)
- RAM_BOOT_OK: UNVERIFIED
- DEVICE_OK: UNVERIFIED
- FUNCTION_TESTED: UNVERIFIED

### Reproducibility

- Source reconstruction: CONFIRMED.
- Configuration resolution: CONFIRMED.
- Single Linux clean Rescue/candidate build: CONFIRMED.
- Byte-for-byte reproducibility: UNVERIFIED; Run 20 is one clean build and no
  second-build binary comparison was performed.

### Known Issues

- The optional kernel-version identity field is empty and explicitly listed as
  UNKNOWN in Run 20's manifest/report. Exact project/source revision, target,
  profile and Run identity are present and consistent; this does not weaken the
  BUILD-02 acceptance gates.
- Runtime Higo, RG520/QMAP, Wi-Fi, IPv6 and device behavior remain untested by
  this build and belong to DEVICE-01.

### Deferred

- All device, RAM boot, persistent installation, Full-profile, and upstream
  update work remains outside BUILD-02.

## Rebuild V1 / BUILD-01.5

### Source Locked

- Locked QModem 3.2.0-r1 to FUjr/QModem commit `c1db0fe2067955d6b9c6b43efff1b69259f4b096`.
- Locked `qmi_wwan_q` 1.5-r1 to the same source commit, which contains RG520
  `2c7c:0801`, QMAP and Linux 6.x compatibility code.

### Static Validated

- Fresh ImmortalWrt, four standard feeds and QModem checkouts matched every
  candidate SHA.
- `prepare.sh` fetch-only mode completed without historical workspace input.
- `apply.sh` passed all five H5000M baseline checks, installed Higo, and
  detected an identical second application.
- Rescue selections and package definitions were statically closed. GNU Make
  and a Linux build environment are unavailable on this host, so
  `make defconfig` remains explicitly blocked rather than reported as passed.

### Push Authorized

- The project owner explicitly authorized storing and pushing the proprietary
  Higo runtime payload; device-unique data and credentials remain forbidden.

### Remaining Unknown

- OpenAppFilter and wrtbwmon exact source commits remain outside Rescue closure.
- The post-`defconfig` resolved configuration remains unverified until run in a
  Linux build environment.

## Rebuild V1 / BUILD-01

### Added

- Independent `h5000m-firmware` Git project, source locks, profiles, scripts and
  GitHub Actions workflow skeleton.

### Migrated

- H5000M Rescue baseline through the locked native board port.
- Hash-matched Higo package, RG520 fixed profile, QMAP redial protection,
  network/Wi-Fi defaults and Higo/LuCI dual-entry configuration.

### Changed

- Long-lived workflow logic is separated into `scripts`, `patches`, `package`
  and `files` rather than embedded in workflow YAML.

### Deferred

- Actual build and RAM hardware validation.
- Exact feed, QModem, qmi_wwan_q and optional package source locks.
- QModem long-term reconnect/scanner cleanup, device list/wrtbwmon and
  OpenAppFilter integration, DiskMan/KSMBD and other Full validation.
- eMMC/sysupgrade safety.

### Known Issues

- Historical latest-full proved RG520 first dial, not reconnect reliability.
- Historical Wi-Fi defaults are intentionally open for isolated RAM testing.
- The historical GPT warning remains out of scope; no disk write is permitted.
