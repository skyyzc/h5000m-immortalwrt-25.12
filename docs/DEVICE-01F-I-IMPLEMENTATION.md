# DEVICE-01F-I Implementation Review

Date: 2026-09-05

Baseline: `rebuild-v1` at
`611be55e99ec8d77063494f408ec38c8177b32ae`.

## Decision

The implementation preconditions do not permit either proposed compatibility
repair to be implemented safely. No speculative firmware code was created and
Run 21 was not triggered. The approved CASE C applies: both repairs are
`BLOCKED`, and adding collectors that can already be executed manually over SSH
does not justify a full firmware build by itself.

## Notification implementation review

### Confirmed loader boundary

- The init script sets `HIGOROS_LUA_HANDLERS` to a directory.
- Binary inspection confirms the runtime loads `api.lua` from that handler
  location and requires a global `higoros_dispatch` returning one string.
- The Lua runtime includes `dofile`/`loadfile`. Structurally, the handler path
  could point at a PROJECT_LOCAL wrapper which loads the unchanged vendor
  dispatcher, captures it, installs a wrapper function and delegates every
  non-allowlisted request.
- The vendor binary already owns many native routes and event-inbox
  `/api/v1/notifications*` routes. The missing demonstrated contract is the
  separate settings API: GET/PATCH `/api/v1/system/notifications*`.

### Blocking condition

The exposed Lua/Go contract does not prove a safe UCI transaction primitive for
notification settings. Existing global adapter functions are route-specific
network/Wi-Fi functions. Presence of generic Lua `os`/file symbols does not
prove that spawning `uci`, shell escaping, locking and atomic commit are safe or
supported by this runtime. An in-memory table would violate the approved UCI
storage contract; direct shell execution would be an unproved monkey patch.

`NOTIFICATION_DELEGATION_PROOF=PASS` for request delegation and unchanged
vendor payload identity. `NOTIFICATION_IMPLEMENTATION=BLOCKED` on the storage
and transaction boundary. Before implementation, prove one of:

1. a typed, callable Go UCI adapter with atomic set/commit and error return; or
2. an independently reviewed PROJECT_LOCAL helper with a fixed JSON contract,
   no shell interpolation, locking, atomic UCI transaction, strict permissions
   and secret-free logs, callable without changing the vendor payload.

Only then implement the seven-event GET/PATCH contract and fixtures already
specified in `DEVICE-01F-REPAIR-DESIGN.md`.

## RG520 profile implementation review

### Corrected frontend contract

Static frontend inspection disproves the design-stage assumption that the
visible `未识别配置` label is selected by `profileName`, manufacturer or model.
The page builds five modes (`5g-priority`, `4g-priority`, `5g-only`, `4g-only`,
`3g-only`) and recognizes current configuration by either:

- exact equality of the API `mode` to one mode key; or
- equality between normalized API `selectedNetworks` and the mode's normalized
  network set.

The API also supplies `supportedNetworks`; strings are normalized only to the
allowlist `3G`, `4G`, `5G`. RG520 display identity and current network status are
separate from this configuration-card predicate.

This is an evidence correction:

- `OLD`: generic QModem profile name/schema was treated as the proved direct
  cause of the unrecognized label.
- `NEW`: the direct frontend boundary is the `/api/v1/cpe/network-mode`
  `mode`/`selectedNetworks` response. The upstream cause of its Run 20 value is
  `UNKNOWN`.
- `EVIDENCE`: canonical minified frontend logic and binary route strings.
- `IMPACT`: the proposed `profileName` normalizer cannot be implemented as the
  label fix. Run 20's proven dial path remains unchanged.

### Blocking condition

No sanitized Run 20 response fixture exists for GET
`/api/v1/cpe/network-mode`, and the closed Go backend's exact conversion from
QModem `get_network_prefer` state to `mode`, `selectedNetworks` and
`supportedNetworks` has not been proved. Guessing a UCI profile name, a mode key
or a selected-network array could change real network preference semantics.

`RG520_PROFILE_CONTRACT_PROOF=FAIL` for the previously proposed profile-name
contract. `RG520_PROFILE_IMPLEMENTATION=BLOCKED`. Required next evidence is one
sanitized, read-only Run 20/next-Rescue response for network mode, the matching
QModem controller response and selected non-sensitive UCI policy fields. A
fixture can then locate conversion vs frontend-schema failure without changing
bands, mode, AT ownership or the `2_1` dial section.

## Diagnostic-only items

`IPV6_ROOT_CAUSE=UNKNOWN` and `NEIGHBOUR_ROOT_CAUSE=UNKNOWN`. The approved
evidence plans require no image-resident daemon or boot hook. Their commands can
be issued manually and bounded over SSH in the next explicitly authorized RAM
session. Installing a duplicate collector would add attack/privacy surface,
could become stale, and would not itself cross either unknown evidence boundary.

Therefore:

- no NAT66, proxy-NDP, firewall, odhcpd, routing or QModem change exists;
- no AT command, tty access, polling, capture or service stop exists;
- no automatic or persistent diagnostic collection exists;
- packet capture and raw neighbour AT evidence remain separately gated for
  DEVICE-01G exactly as designed.

## Implementation review gate

| Gate | Result | Evidence |
|---|---|---|
| Source/branch cleanliness | PASS | baseline local/remote HEAD matched before work |
| Higo vendor binary/frontend/api modification | PASS | no payload file changed |
| Notification loader/delegation structure | PASS | environment-selected `api.lua`, global dispatcher, `dofile/loadfile` present |
| Notification safe storage contract | FAIL/BLOCKED | no proved typed/atomic UCI primitive |
| RG520 visible-label predicate | PASS | exact frontend mode/network-set predicate recovered |
| RG520 backend response contract | FAIL/BLOCKED | no Run 20 fixture or proved closed-backend conversion |
| IPv6 speculative fix absent | PASS | no firmware change |
| Neighbour speculative fix/AT absent | PASS | no firmware or device action |
| Rescue/full/source locks | PASS | unchanged |
| Run 21 value threshold | FAIL | diagnostics alone do not justify a full build |

Static adapter/fixture tests were not fabricated because no implementation
crossed its precondition. Existing build gates were not rerun; no firmware
input changed.

## Changed files and contract impact

- `docs/DEVICE-01F-I-IMPLEMENTATION.md`: records precondition evidence,
  blockers and the corrected profile contract.
- `docs/DEVICE-01-STATE.md`: records CASE C and Run 21 not triggered.
- `docs/HIGO-FEATURES.md`: corrects the current-profile gap boundary without
  changing historical observations.
- `CHANGELOG.md`: durable implementation-review record.

No package provenance changed, so `docs/PACKAGES.md` remains unchanged.

## Remaining UNKNOWN and next review action

- Safe typed/atomic UCI interface available to a PROJECT_LOCAL Higo wrapper.
- Sanitized network-mode API response and matching QModem controller state from
  the affected Rescue runtime.
- LAN-client IPv6 failing packet boundary.
- Neighbour-cell failing invocation/response/parser/schema boundary.

Recommended next action is owner review. If approved, the smallest evidence
session is a future Rescue RAM boot that first captures the network-mode fixture
and IPv6/neighbour API/controller evidence. It does not require a new firmware
build. A code task should start only after one implementation contract closes.

## Final status

DEVICE-01F-I: `BLOCKED`

NOTIFICATION_IMPLEMENTATION: `BLOCKED`

NOTIFICATION_DELEGATION_PROOF: `PASS`

RG520_PROFILE_IMPLEMENTATION: `BLOCKED`

RG520_PROFILE_CONTRACT_PROOF: `FAIL`

IPV6_IMPLEMENTATION: `DIAGNOSTIC_ONLY`

IPV6_ROOT_CAUSE: `UNKNOWN`

NEIGHBOUR_IMPLEMENTATION: `DIAGNOSTIC_ONLY`

NEIGHBOUR_ROOT_CAUSE: `UNKNOWN`

SOURCE_LOCK_CHANGED: `NO`

HIGO_CANONICAL_PAYLOAD_CHANGED: `NO`

FULL_STARTED: `NO`

DEVICE_MODIFIED: `NO`

PERSISTENT_STORAGE_MODIFIED: `NO`

RUN21_TRIGGERED: `NO`

Final state: `REVIEW_REQUIRED`.
