# DEVICE-01G / Run 21 Repair Design

Date: 2026-09-05

## Scope and baseline

This design phase starts from `398f99d815635fa6466986474fa6acef966bb8cd`
on clean `rebuild-v1`, equal to `origin/rebuild-v1`. It uses accepted Run 21
(`33951063311`, number `21`, attempt `1`, Rescue/candidate), its device evidence,
and locked ImmortalWrt
`1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`. No device access, firmware,
source lock, package selection, build, Run 22, Full, or persistent operation is
authorized or performed here.

## CPE live-path analysis

The proved build-time chain is:

`QModem 0/1/1 -> authenticated API mode=auto + selectedNetworks=[4G,5G] ->
CPEManagement-CuEyMeyg.js -> st computed resolver -> Tt title -> current
configuration heading`.

Source inspection found one `未识别配置` title owner and one matching resolver
in the canonical CPE chunk. `Tt` supplies the visible title; `Jt` separately
formats the badge from `selectedNetworks`. This explains the Run 21 screenshot:
the badge can show `4G / 5G` while an unpatched resolver still yields the
unknown title. No second renderer or alternate CPE bundle was found.

The build-time patch replaces that resolver in exactly one named chunk. Run 21
manifest evidence records the patched asset hash
`f8eef73d3abe39a5170c3d84f952bbf5683690b6f240a23a9d58a783d2e33ad0` and the
patched frontend-tree hash
`e05e0e06fb137261df0d675384fbc9d06b477f5446cc81dfc0813ebf90d2ee7e`.
The entry bundle lazy-loads exactly `CPEManagement-CuEyMeyg.js`.

However, the patch changes the chunk contents without changing its
content-hashed filename or the entry bundle. A browser tab/module loaded from
Run 20, or an ordinary browser cache entry at that unchanged URL, can therefore
continue executing the canonical resolver across the firmware transition.
The frontend actively unregisters service workers and clears Cache Storage, so
a service-worker cache is not the supported explanation; normal HTTP/module
cache or an already evaluated module remains plausible.

Run 21 did not retain the browser's actual loaded resource hash. Therefore:

- `CPE_FAILURE_CONFIRMED=YES`
- `CPE_LIVE_PATH_CLOSED=NO`
- `CPE_RCA=UNKNOWN`
- leading hypothesis: `CACHE_OR_ASSET_SELECTION`
- rejected by current source evidence: `SECOND_RENDERER_EXISTS`

### Smallest missing evidence

On one separately authorized Run 21 RAM boot, use a fresh private browser
context with no existing H5000M tab. Capture the authenticated sanitized
network-mode response, the CPE chunk URL from the browser network/resource
view, and SHA256 of the bytes fetched from that exact URL. Compare it with the
Run 21 patched hash, then record the visible title. Repeat only once with a
hard reload if the first fetch is demonstrably cached. No configuration save,
firmware rebuild, modem operation, or persistent change is needed.

Interpretation is deterministic:

- fetched hash is canonical: close at cache/asset selection or wrong served
  tree, according to response/cache metadata;
- fetched hash is patched but title remains unknown: inspect the live API data
  shape and invoked resolver, then classify unused path or differing shape;
- fetched hash is patched and a fresh context shows `4G + 5G`: the Run 21 code
  repair works and the original failure is a stale browser module/cache.

Because that discriminator is missing, no CPE implementation is selected in
DEVICE-01G. A conditional follow-up may re-bundle so changed code receives a
new chunk filename and the entry manifest references it, but only after the
live resource evidence confirms cache/selection as the cause. The repair must
remain display-only, deterministic, separately hash the vendor source and
PROJECT_LOCAL runtime, preserve QModem semantics, and test API -> fetched
asset hash -> resolver -> visible title on RAM hardware.

## IPv6 confirmed root cause

Run 21 captured each controlled client echo request on `br-lan` and
`wwan0_1`, matching replies on `wwan0_1`, and no reply on `br-lan`. The same
dynamic `/64` was connected to both interfaces, and route lookup for the LAN
client selected `wwan0_1`. The locked `odhcp6c` script shows that
`extendprefix=1` implements RFC 7278 by turning a received `/64` address into a
delegated prefix when no real PD is supplied. The router-side cause remains
`CONFIRMED_SAME_PREFIX_RETURN_ROUTE_COLLISION`.

## IPv6 approach comparison

### Approach 1: obtain a non-colliding delegated prefix

Request a real prefix shorter than `/64` and let netifd allocate a child `/64`
to LAN. This is the cleanest conventional PD architecture and avoids overlap.
It naturally handles many clients and renewal. It is not selectable now: the
observed carrier supplied only the RFC 7278 `/64`, and no evidence proves it
will delegate `/56` or `/60`. Failure mode is loss of LAN IPv6 whenever the
carrier refuses the larger PD. Rollback is removal of the changed request.

### Approach 2: dynamic preferred LAN route for the shared `/64` (selected)

Keep the carrier-provided RFC 7278 prefix and QMAP data path. A narrow
PROJECT_LOCAL DHCPv6/netifd hotplug helper reads the current delegated-prefix
object and maintains one explicit route for that exact `/64` via `br-lan` with
a metric preferred over the automatic `wwan0_1` connected route. Local-table
routes retain delivery to the router's own cellular addresses; the link-local
cellular gateway and default route remain unchanged. Lease update/rebind
atomically replaces the old route, and teardown removes only a route carrying
the helper's exact protocol/metric identity.

This directly corrects the proved return lookup, is dynamic-prefix safe,
supports multiple LAN clients without per-client state, and does not require
NAT66 or proxy-NDP. The captured return packets prove that the cellular/QMAP
side already receives traffic for LAN-client addresses, so additional NDP
proxying is not justified.

### Approach 3: make the cellular global address off-link or `/128`

Suppress the cellular `/64` connected route by changing how the DHCPv6 address
is installed, while retaining a link-local next hop and LAN `/64` route. This
can correct lookup but changes generic protocol/address semantics, risks
carrier reachability and source-rule behavior, and likely requires a broader
`odhcp6c` or netifd patch. It is less maintainable and harder to roll back than
the explicit dynamic route, so it is not selected.

## Selected IPv6 design contract

- `IPV6_SELECTED_DESIGN`: dynamic preferred LAN route for the current RFC 7278
  shared `/64`.
- `IPV6_DESIGN_REASON`: changes the exact failed return lookup while preserving
  the working carrier/QMAP receive path, device IPv6, and dynamic lease.
- `IPV6_FILES_COMPONENTS_AFFECTED`: one PROJECT_LOCAL IPv6 hotplug/helper plus
  package install/validation wiring; no upstream source or lock change.
- `IPV6_RUNTIME_BEFORE`: equal `/64` routes exist on cellular and LAN; lower
  cellular metric wins client return lookup.
- `IPV6_RUNTIME_AFTER`: the current delegated `/64` has a lower-metric explicit
  route to `br-lan`; cellular local addresses and default via link-local remain
  intact.
- `IPV6_FAILURE_MODES`: missing/malformed prefix object, stale route after
  renewal, helper race during reconnect, route ownership collision, loss of
  default/device IPv6, or a carrier that changes RFC 7278 behavior. Fail closed:
  do not install a route unless exactly one current shared `/64` is proved.
- `IPV6_ROLLBACK`: remove the uniquely owned explicit route and helper; normal
  netifd/odhcp6c state returns without touching modem or persistent storage.
- `IPV6_NATIVE_ROUTED_DESIGN=YES`
- `IPV6_NAT66_REQUIRED=NO`
- `IPV6_PROXY_NDP_REQUIRED=NO`

## IPv6 build and RAM gates

Static/build gates must prove shell syntax, exact-prefix validation, one-route
ownership, idempotent add/update/delete, no hard-coded public prefix/address,
no NAT66/proxy-NDP/firewall/QModem mutation, reconnect teardown, package and
resolved-config presence, and all existing Rescue/build/artifact gates.

RAM validation must prove: Run identity and tmpfs safety; device IPv4/IPv6;
prefix acquisition; one preferred LAN shared-prefix route; route-get for two
LAN clients selects `br-lan`; concurrent capture shows request LAN -> QMAP and
reply QMAP -> LAN; numeric ICMPv6 and HTTPS succeed; prefix renew and modem
reconnect replace stale route state; reboot starts clean; Higo/LuCI and all
Run 21 core regressions pass. Final client validation uses macOS and one of
Android or Windows. Power-cycle recovery to the original system remains
mandatory.

## Proposed Run 22 boundary

Run 22 remains Rescue/candidate and is not triggered. IPv6 is repair-designed,
but CPE is not live-path closed, so a combined Run 22 changeset is not yet
approved or fully designed. If the CPE evidence closes, the only mandatory
candidates are the proved CPE live-render repair and the IPv6 dynamic-route
helper. Notification, neighbour, Full packages, upgrades, refactors, and
persistent deployment remain excluded.

## Stop decision

- `BLOCKER`: CPE browser-loaded asset/runtime identity was not captured.
- `MISSING_EVIDENCE`: fresh-context loaded CPE URL, bytes/hash, cache metadata,
  sanitized API response, and visible title from one Run 21 session.
- `NEXT_ACTION`: separately authorize that read-only Run 21 evidence session.
- `REPAIR_CONTINUATION_GATE`: confirm API -> served/loaded asset -> resolver ->
  visible title, then select the CPE repair and complete Run 22 design review.

Current implementation remains unauthorized. No confirmed IPv6 diagnosis
should be repeated absent contradictory evidence.
