# DEVICE-01F Rescue Compatibility Repair Design

Date: 2026-09-05

Design baseline: `rebuild-v1` at
`430c31086dcdd0864a67eae086487fd3e7c8b79c1b`.

## 1. Scope

This is a design and review record only. It covers four Run 20 Rescue gaps:

1. LAN-client external IPv6 (`P0`, root cause `UNKNOWN`).
2. Higo notification settings (`P1`, frontend/backend contract incomplete).
3. RG520N-CN current-profile recognition (`P1`, canonical schema mismatch).
4. Higo neighbour-cell information (`P1`, root cause `UNKNOWN`).

No firmware, profile, source lock, package, device or modem state is changed by
this phase. Full-only packages and features remain outside scope.

## 2. Accepted DEVICE-01 evidence

Run 20 Rescue remains `PASS_WITH_KNOWN_ISSUES`. Boot and embedded identity,
H5000M identity, LAN/DHCP/SSH, Higo/LuCI coexistence, independent 2.4/5 GHz
client traffic, RG520 USB, QMI/QMAP, device-side IPv4/IPv6, bounded stability,
RAM-only isolation and power-cycle recovery are accepted. The four gaps below
do not erase those results. `DEVICE_OK=YES` means the Rescue core contract
passed; it does not mean final feature completeness.

## 3. Four-gap status

| Gap | Current evidence | Root cause status | DEVICE-01F output |
|---|---|---|---|
| LAN-client IPv6 | RA address/default route PASS; numeric ICMP/HTTPS FAIL; device IPv6 PASS | `UNKNOWN` | bounded evidence plan only |
| Notification settings | UI renders; PATCH operation returns dispatcher `not found` | `CONFIRMED` contract gap | compatibility adapter design |
| CPE profile recognition | RG520/QMI/QMAP/data PASS; UI says unrecognized profile | `CONFIRMED` canonical schema gap; closed-binary predicate remains `UNKNOWN` | normalized profile contract |
| Neighbour cells | registration/data/serving status PASS; neighbour list empty | `UNKNOWN` | exclusive, read-only evidence plan only |

## 4. DEVICE-01F IPv6 evidence plan

All commands are `READ_ONLY`, require root on the temporary Rescue system, and
must be captured only during an explicitly authorized future RAM boot. They do
not authorize a configuration change. Public/global IPv6 addresses, delegated
prefixes, unique MACs and carrier identifiers must be replaced consistently by
tokens such as `<WAN_V6>`, `<PD_PREFIX>`, `<CLIENT_V6>` and `<MAC>` before any
repository record. Keep an untracked local raw capture only as long as needed
for analysis; never commit or upload it.

| Evidence | Command or action | Root | Sensitive output / sanitization | Observation and hypothesis use |
|---|---|---:|---|---|
| Interface inventory | `ubus call network.interface dump` | yes | public IPv6, prefix, MAC: tokenize | protocol, device, prefix assignment and route ownership; H1/H2/H6/H8 |
| Cellular status | `ubus call network.interface.USB status` and `ubus call network.interface.USBv6 status`; if names differ, select them from the dump | yes | public addresses/prefixes: tokenize | DHCPv6-PD, `ipv6-prefix`, `ipv6-address`, route source/table and lifetime; H1/H2/H8 |
| Addresses | `ip -6 addr show` | yes | all global addresses: stable tokens | scope, tentative/deprecated state and preferred/valid lifetime; H7/H8 |
| Policy rules | `ip -6 rule show` | yes | tokenize prefixes | source-specific lookup rules and priorities; H2/H7 |
| All routes | `ip -6 route show table all` | yes | tokenize prefixes/gateways | LAN prefix, cellular default, unreachable guards and tables; H1/H2/H4/H6 |
| Kernel state | selected `sysctl net.ipv6.conf.all.forwarding`, `default.forwarding`, `br-lan.forwarding`, `wwan0.forwarding`, `wwan0_1.forwarding`, `all.proxy_ndp`, per-interface `accept_ra`, `accept_ra_defrtr`, `accept_ra_pinfo`, `disable_ipv6` | yes | none normally | forwarding, RA acceptance and proxy-NDP state; H3/H5 |
| fw4/nft | `nft -a list ruleset`, retain inet fw4 forward, LAN-to-WAN, established/related and ICMPv6 sections | yes | addresses/MACs/counters: tokenize | rule verdict/order/counters and ICMPv6 coverage; H3/H4 |
| odhcpd config | selected `uci -q show dhcp.lan` fields: `interface`, `ra`, `dhcpv6`, `ndp`, `ra_management`, `ra_default`, `ignore` | yes | none expected; redact unforeseen identifiers | advertised service mode and NDP behavior; H1/H5/H8 |
| netifd config | selected non-secret `network.lan`, cellular IPv6 and cellular IPv4 fields: proto/device/ifname/metric/defaultroute/reqaddress/reqprefix/extendprefix/ip6assign/ip6class | yes | prefix/address if present: tokenize | effective PD and interface chaining; H1/H2/H6/H8 |
| Runtime logs | bounded `logread` filter for `netifd`, `odhcp6c`, `odhcpd`, `fw4` covering the test window | yes | tokenize addresses/prefixes; omit unrelated logs | lease/prefix expiry, reload and route errors; H1/H3/H8 |
| Client selection | on client: route lookup for the numeric target and current source address; record only address state/scope and tokenized source | client admin only if required | client/global addresses: tokenize | whether the client selects the delegated global source; H7 |
| Counters | `ip -s link show dev br-lan`; `ip -s link show dev wwan0`; `ip -s link show dev wwan0_1`, before and after each test | yes | MAC: tokenize | determine whether traffic crosses LAN and QMAP sides; H3/H4/H6 |
| Numeric ICMP | one bounded client `ping -6` to a fixed numeric IPv6 test endpoint | no | tokenize endpoint/client address | confirms non-DNS ICMP result and drives counters/capture |
| Numeric HTTPS | one bounded client HTTPS request to a numeric IPv6 endpoint with explicit host/TLS handling | no | tokenize endpoint; do not log cookies/headers | confirms non-DNS TCP/TLS result and drives counters/capture |
| Packet trace | if `tcpdump` exists: bounded capture on `br-lan` and `wwan0_1`, IPv6 only, snaplen sufficient for headers, fixed packet/time limit | yes | packet headers contain addresses: keep raw untracked, publish only tokenized summary | locate request and reply boundary, NS/NA/ICMPv6 failure; H3-H7 |

The HTTPS endpoint must be chosen in advance and its certificate/Host behavior
documented so a TLS-name failure is not confused with routing. Absence of
`USB`/`USBv6` names is not failure by itself; actual runtime interface names
from ubus are authoritative.

### IPv6 hypothesis matrix

| Hypothesis | Evidence for | Evidence against | Required test | Confidence |
|---|---|---|---|---|
| H1 PD/`extendprefix` mismatch | client got an address, but no traffic; original uses `USBv6`, `reqprefix=auto`, `extendprefix=1` | Run 20 did advertise a global prefix | ubus prefix objects, netifd UCI and lifetimes | LOW |
| H2 source-specific routing missing/wrong | cellular IPv6 uses source-specific routes; client failure can occur after RA | device-side IPv6 works | rules plus all tables and route-get using `<CLIENT_V6>` | MEDIUM-LOW |
| H3 fw4 forward policy/drop | both ICMP and HTTPS fail while local RA works | Run 20 firewall baseline was active and LAN/WAN zones existed | nft handles/verdicts/counters during tests | MEDIUM-LOW |
| H4 upstream return path | outbound could leave without replies | no packet trace exists | paired bounded captures and route counters | LOW |
| H5 NDP/proxy-NDP requirement | same on-link `/64` designs can require NDP handling | proper delegated routing may require no proxy | NS/NA trace, prefix topology, proxy state | LOW |
| H6 QMAP IPv6 forwarding/policy | device-side path and forwarded path may differ | QMAP device IPv6 works | wwan/QMAP counters and paired captures | MEDIUM-LOW |
| H7 client source selection | multiple ULA/global sources were observed | client held a global address/default route | client route selection and source token | LOW |
| H8 stale prefix/lifetime state | mobile PD may change while old RA survives | only one bounded failure was observed | preferred/valid lifetimes plus netifd/odhcp logs | LOW |

`IPV6_ROOT_CAUSE` remains `UNKNOWN`. No NAT66, proxy-NDP, firewall, odhcpd,
QModem or policy-routing patch is proposed for Run 21.

## 5. Higo notification compatibility design

### Confirmed frontend contract

The frontend base URL is `/api/v1`. Two separate notification concepts exist:

| Purpose | Method and route | Request | Expected response |
|---|---|---|---|
| Settings list | `GET /api/v1/system/notifications` | none | envelope with `data` as an array of settings |
| Update one setting | `PATCH /api/v1/system/notifications/{eventType}` | `{enabled:boolean, webEnabled:boolean, emailEnabled:boolean}` | success envelope containing normalized updated setting |
| Event inbox list | `GET /api/v1/notifications` | optional pagination/filter query | `{list,total,unreadCount}` directly or in envelope |
| Mark event read | `PATCH /api/v1/notifications/{id}/read` | none | success |
| Mark all read | `PATCH /api/v1/notifications/read-all` | none | success |
| Delete event | `DELETE /api/v1/notifications/{id}` | none | success |
| Clear read events | `DELETE /api/v1/notifications/clear-read` | none | success |
| Create internal event | `POST /api/v1/notifications` | `{id?,title,content,type,isRead?,createdAt?,metadata?}` | created event |

The demonstrated DEVICE-01 failure concerns notification **settings**. Its
event types are `config-saved`, `firmware-update`, `login-failed`,
`device-online`, `device-offline`, `traffic-threshold` and `system-error`.
Current frontend update code sends exactly the three booleans above. The
hash-pinned Lua dispatcher contains no `system/notifications` handlers and its
fallback response is HTTP 404/code 1404/message `not found`.

### PROJECT_LOCAL adapter

- Preserve the hash-pinned vendor `api.lua` and frontend byte-for-byte. Package
  a PROJECT_LOCAL composite dispatcher at the runtime entry point: it handles
  only allowlisted compatibility routes, then delegates every other request to
  an unmodified vendor dispatcher/module stored and hash-verified separately.
  If the current Go/Lua loader cannot support that delegation boundary, the
  implementation is blocked for review rather than patching the canonical
  payload or adding a second competing port-80 service.
- Store only the seven allowlisted event sections and three boolean values in
  a dedicated UCI package such as `higoros_notifications`. Unknown event types,
  unknown keys and non-booleans return HTTP 400 with a stable project-local
  validation code. Missing configuration returns safe defaults, not 404.
- Default: web notifications enabled only where the existing product contract
  confirms it; email delivery defaults disabled. Because no authoritative
  original defaults were proved, the proposed implementation must first lock
  an explicit conservative default fixture during code review.
- GET always returns all seven settings in deterministic order. PATCH updates
  one allowlisted event atomically and returns the normalized object. Backend
  write/commit failures return HTTP 500 and never report success.
- Rescue RAM behavior: UCI writes affect tmpfs only. A power cycle restores the
  original system. Future persistent behavior requires a separate policy and
  migration review; this design grants none.
- This adapter configures notification policy only. Actual email transport,
  recipient/account management and event-inbox persistence are separate and
  remain `UNVERIFIED`; the adapter must not claim delivery success.
- Never ship recipient addresses, SMTP credentials, passwords or tokens in
  defaults, Git, images, manifests, logs or API error details. Secret-bearing
  transport configuration must use a later local/persistent secret mechanism.
- Static tests: route/method matrix, seven-event allowlist, boolean validation,
  unknown-key rejection, deterministic defaults, atomic UCI failure and
  redaction tests. RAM tests: initial GET, one reversible toggle, GET-after-
  PATCH, invalid event/key, Higo UI refresh, and power-cycle non-persistence.

`NOTIFICATION_REPAIR_DESIGN=READY`. Only the settings GET/PATCH adapter is a
closed Run 21 patch, conditional on a static loader/delegation proof that keeps
the canonical payload intact. Event inbox endpoints remain a separately gated
contract unless current UI testing proves them required for this repair.

## 6. RG520N-CN canonical profile design

### Single normalized identity

One project-local adapter must normalize hardware detection, the existing
QModem UCI section and runtime status into one object consumed by both QModem
integration and Higo. It must not create a second independent modem identity.

| Field | Canonical value/source | Authority and behavior |
|---|---|---|
| `manufacturer` | `quectel` | static profile, verified against USB device |
| `model` | `RG520N-CN` | runtime identification when safely available; otherwise static profile |
| `profile_name` | stable project identifier `quectel-rg520n-cn` | static; Higo-facing key, distinct from display text |
| `platform` | `qualcomm` | static profile |
| `network_type` | `3G/4G/5G` capability plus separate runtime mode | capability static; current mode/status runtime only |
| USB identity | VID/PID `2c7c:0801` | hardware detection; mismatch is an error, never silently normalized |
| USB path | discovered matching sysfs path | hardware detection; current `2-1` is a board default, not universal truth |
| AT port | detected/validated candidate, board default `/dev/ttyUSB3` | runtime detection plus static fallback; access through ownership model |
| QMI control | discovered `/dev/cdc-wdm*`, expected `/dev/cdc-wdm0` | runtime hardware detection |
| QMAP data | discovered `wwan0_1`, parent `wwan0` | runtime status; existing proven dial path remains authoritative |
| bands capability | existing WCDMA/LTE/NSA/SA allowlists | static board/modem profile; current/locked bands are runtime and must not be inferred |
| PDP | existing `ipv4v6` preference | UCI policy; do not confuse with current bearer result |
| section identity | current `qmodem.2_1` retained during migration | existing proven dialer key; no rename in the first compatibility patch |
| firmware/IMEI/ICCID/SIM/operator | `UNKNOWN` unless runtime requests it | never persist or expose unique/sensitive fields in evidence |

Proposed normalized Higo response includes `section`, `profileName`,
`manufacturer`, `model`, `platform`, `capabilities.networkTypes`,
`runtime.networkType`, `ports.qmi`, `interfaces.parent/data`, and explicit
`source`/`confidence` metadata. Sensitive identity fields are excluded. Missing
runtime data is `null`/`UNKNOWN`, never fabricated.

Migration is additive: keep `qmodem.2_1`, its QMAP dial parameters, metric,
PDP policy and redial protection unchanged; derive normalized fields from it
and hardware status. Only after API fixtures prove Higo recognition may the
profile identifier be added. Existing user-edited sections remain untouched.
No band, network mode, AT port, modem reset or dialing change belongs in the
profile display patch.

Regression gates: USB `2c7c:0801`; tty/WDM enumeration; QModem startup without
duplicate scan ownership; `/dev/cdc-wdm0`; `qmi_wwan_q`; `wwan0/wwan0_1`;
QMI/QMAP counters; IPv4; device IPv6; Higo profile display; existing CPE status,
signal/SIM/SMS/AT UI; bounded reconnect. The last reconnect gate can be
completed only in RAM validation, not at build time.

`RG520_PROFILE_REPAIR_DESIGN=READY` for an additive normalizer/fixture patch.
The closed Higo binary's exact recognition predicate must be proved by static
fixture tests before implementation is considered closed.

## 7. DEVICE-01F neighbour-cell evidence plan

No AT command is authorized by this design phase. A future explicitly approved
RAM test follows this order and stops as soon as the failing boundary is known:

1. Capture authenticated Higo `GET /api/v1/cpe/neighborcell` request/response
   metadata with modem section selection. `READ_ONLY`; root not required;
   redact cell IDs, frequencies, PCI, carrier and location-derived values.
2. Invoke the existing QModem `get_neighborcell` API through its supported ubus
   or controller interface and capture sanitized JSON plus exit status.
   `READ_ONLY`; root required. Do not call `set_neighborcell`.
3. Correlate bounded QModem/Higo logs to prove whether the controller executed
   the query and parser. `READ_ONLY`; root required; redact modem/cell identity.
4. Inspect AT-port owners (`fuser`/`lsof`/process metadata) and the QModem lock
   mechanism. `READ_ONLY`; root required. If exclusive ownership cannot be
   proved without stopping or reconfiguring a service, STOP and request a
   separate controlled-test gate.
5. Only under that future gate, use QModem's existing read path to issue one
   bounded `AT+QENG="neighbourcell"`; never open a competing direct serial
   session. Capture the raw response locally, sanitize it, and turn it into a
   parser fixture. No band lock, network-mode change, modem reset or retry loop.
6. Compare raw response -> QModem JSON -> Higo API -> frontend schema. Classify:
   no Higo invocation; no AT execution; modem empty; NSA/SA parser mismatch;
   JSON contract mismatch; ownership race; or genuine environment absence.

Expected evidence: request method/route/selected section, controller action and
exit status, bounded timestamps, raw-response shape, parser result and Higo
payload shape. Never preserve real cell identifiers in Git.

`NEIGHBOUR_ROOT_CAUSE=UNKNOWN`. No neighbour parser patch enters Run 21 unless
fixture evidence first proves a parser or schema defect.

## 8. AT/QMI ownership safety model

- `quectel-CM-M` owns QMI control during dialing. QModem/Higo modem operations
  must use the existing controller/serialization mechanism, not independent
  writers to `/dev/cdc-wdm0` or ttyUSB nodes.
- A read-only AT query is safe only when one bounded owner has acquired the
  project's proven lock/arbitration path. Merely observing an unused tty at one
  instant is insufficient.
- No direct shell redirection to ttyUSB, background polling, repeated AT loop,
  band/cell lock, network-mode change, reset, USB unbind or service stop is part
  of DEVICE-01F or the proposed Run 21 changeset.
- Loss of QMI/QMAP traffic, unexpected owner, missing lock or ambiguous port
  terminates the evidence test without retrying.

## 9. Repair dependency graph

```text
Notification source contract (CONFIRMED)
  -> settings adapter + fixtures
  -> Run 21 build gates

RG520 fixed UCI + hardware evidence (CONFIRMED)
  -> canonical normalizer + fixtures
  -> profile-display gate
  -> Run 21 build gates
  -> RAM dial/data/reconnect regression

IPv6 root cause (UNKNOWN)
  -> diagnostic collector only
  -> Run 21 RAM evidence
  -> later evidence-based repair

Neighbour root cause (UNKNOWN)
  -> safe API/log collector only
  -> Run 21 RAM evidence
  -> controlled AT gate if still required
  -> later evidence-based parser/schema repair
```

Notification and profile adapters can be reviewed independently. The profile
adapter must precede neighbour schema conclusions because both consume modem
identity/section selection. IPv6 is independent and must not be bundled with
either compatibility patch.

## 10. Proposed Run 21 changeset

`RUN21_CHANGESET_PROPOSED`:

- Project-local notification settings GET/PATCH composite adapter, vendor
  dispatcher delegation/identity proof, conservative defaults fixture,
  validation and redaction tests.
- Additive RG520 canonical normalizer and Higo-facing fixture, provided static
  closed-binary/API contract proof succeeds without changing the dial section.
- One read-only diagnostic script that collects the listed IPv6 and neighbour
  API/log evidence into a local sanitized report. Packet capture and AT query
  remain operator-gated optional steps, not automatic build/runtime actions.
- Documentation and traceability updates for the two compatibility patches.

Explicit exclusions: speculative IPv6/neighbour fixes; Full packages; source,
feed, QModem or payload upgrades; frontend hiding; unrelated cleanup; and any
persistent-install support.

## 11. Run 21 acceptance gates

In addition to every unchanged BUILD-02 gate:

1. Canonical Higo payload hashes remain unchanged. Vendor dispatcher delegation
   and identity tests prove that only separately packaged project-local adapter
   files own the added routes; no frontend asset deletion/change is allowed.
2. Notification route/method/schema, allowlist, defaults, invalid-input,
   atomic-failure and secret-redaction tests pass.
3. RG520 normalized fixture maps `2c7c:0801` and the retained `2_1` section to
   one identity; mismatch and unknown fields fail safely.
4. No delta to QModem dial parameters, qmi_wwan_q, network interfaces, bands,
   source locks or Rescue package selections unless separately reviewed.
5. Diagnostic collection is read-only, bounded, absent from boot hot paths,
   does not contain raw sensitive identifiers and fails without masking errors.
6. Exact project/Run/source/profile identity, manifest, report, resolved config,
   firmware SHA256 and artifact upload pass as before.

Build success reaches `BUILT`, not device acceptance.

## 12. Run 21 RAM validation plan

1. Repeat identity, RAM-only mounts, LAN/DHCP/SSH, dual UI and service gates.
2. Verify notification GET defaults; perform one reversible settings PATCH and
   read-back; verify invalid event rejection and no secret logging.
3. Verify RG520 enumeration, QModem single selected section, QMI/QMAP, IPv4 and
   device IPv6 before judging profile display; confirm Higo shows RG520N-CN as
   a recognized 3G/4G/5G-capable profile.
4. Run the IPv6 evidence plan with one real LAN client. Do not patch during the
   test; decide root cause only from captured boundary evidence.
5. Run neighbour API/controller/log steps. Use the controlled AT step only with
   a separate explicit gate and proven exclusive ownership.
6. Perform a bounded reconnect regression only after baseline traffic passes.
7. Repeat stability, original-partition read-only and normal power-cycle
   recovery. A settings write must disappear with the initramfs boot.

## 13. Regression risks

- Notification UCI persistence semantics could be mistaken for delivery
  capability or expose transport secrets.
- A profile rename could break the proven `2_1` dial path, scanner selection,
  Higo section selection or redial protection.
- Diagnostic output can leak public addresses, cell/location data or unique
  device identity unless tokenization is enforced before artifact creation.
- Direct AT access can race with QModem; IPv6 speculation can break working
  device-side IPv6 or weaken fw4. Both are prohibited.

## 14. Deferred Full items

wrtbwmon, device list/ranking/blacklist, OpenAppFilter, URL/IP filtering,
network topology, fancontrol, DiskMan, KSMBD, UPnP, DDNS, Watchcat and ZeroTier
remain deferred to `FULL-01 SOURCE CLOSURE`. Their unresolved exact source SHAs
remain `UNKNOWN`. DEVICE-01F does not change package provenance knowledge.

## 15. UNKNOWN ledger

- Exact LAN-client IPv6 failure mechanism and failing packet boundary.
- Whether current mobile service supplies stable delegated-prefix semantics
  across reconnect and prefix renewal.
- Authoritative original notification defaults, delivery backend and event
  inbox persistence contract.
- Closed Higo binary's exact canonical-profile recognition predicate.
- Exact neighbour raw response in the tested NSA/SA environment and whether
  the failure is invocation, modem-empty, parser, JSON schema or environment.
- Proven AT-port lock implementation for a controlled raw query.
- QModem reconnect behavior after the proposed additive normalizer.

## 16. STOP / review decision

DEVICE-01F_DESIGN: `COMPLETE`

IPV6_ROOT_CAUSE: `UNKNOWN`

NOTIFICATION_REPAIR_DESIGN: `READY`

RG520_PROFILE_REPAIR_DESIGN: `READY`

NEIGHBOUR_ROOT_CAUSE: `UNKNOWN`

RUN21_CHANGESET_DESIGN: `READY`

RUN21_TRIGGERED: `NO`

FULL_STARTED: `NO`

SOURCE_LOCK_CHANGED: `NO`

DEVICE_MODIFIED: `NO`

PERSISTENT_STORAGE_MODIFIED: `NO`

Final state: `REVIEW_REQUIRED`. Stop before implementation or build.
