# DEVICE-01F-II Rescue Closure Implementation Review

Date: 2026-09-05

## Scope and decision

DEVICE-01F-II defines and implements the smallest justified Run 21 repository
delta without triggering a build. The delta is limited to a CPE presentation
compatibility patch and `tcpdump-mini` for a future bounded IPv6 packet trace.
Notification remains design-blocked and neighbour handling is unchanged.

## CPE confirmed root cause and repair boundary

DEVICE-01F-E2 proved this chain:

`QModem 3G=0/4G=1/5G=1 -> API selectedNetworks=[4G,5G] -> no frontend preset -> 未识别配置`.

The backend conversion and schema are correct. The repair is exclusively the
frontend current-profile resolver. It adds a display-only fallback for the
normalized key `4G|5G`, labelled `4G + 5G` in the existing concise profile
naming style. It does not add a selectable/savable modem preset and does not
change QModem, UCI, band, APN, PDP, QMAP, dial behavior, backend mode or
`selectedNetworks`.

## Deterministic patch and hash semantics

The canonical proprietary payload under `package/hiveton/higoros/files` stays
byte-identical to its vendor-source lock. `scripts/apply.sh` first copies that
canonical package into the locked ImmortalWrt worktree, then runs
`scripts/patch-higo-cpe-frontend.py` against exactly one known minified
predicate. The patch refuses zero, multiple or ambiguous matches and accepts an
already-patched target, making direct execution idempotent. The normal double
apply recopies the canonical input and deterministically produces the same
runtime tree.

Hash meaning is explicit:

- `payload_sha256.frontend_tree_sha256`: unchanged 60-file vendor source tree.
- `runtime_patch.sha256`: exact PROJECT_LOCAL patch implementation.
- `runtime_patch.patched_asset_sha256`: expected transformed CPE asset.
- `runtime_patch.patched_frontend_tree_sha256`: expected 60-file runtime tree.

The Higo gate requires only the named CPE asset to differ between source and
runtime and verifies every hash. The manifest/report distinguish vendor-source
hashes from PROJECT_LOCAL runtime-patch hashes; patched bytes are never claimed
to be byte-identical vendor bytes.

## CPE fixture matrix

The checked-in seven-case fixture preserves existing labels:

- `[3G,4G,5G] -> 5G 优先`
- `[3G,4G] -> 4G 优先`
- `[4G,5G] -> 4G + 5G`
- `[5G] -> 仅 5G`
- `[4G] -> 仅 4G`
- `[3G] -> 仅 3G`
- unknown `[3G,5G] -> 未识别配置`

`tests/test-higo-cpe-normalization.py` also applies the exact transformation
twice and proves stable bytes and a single patched predicate.

## Notification architecture comparison

Option A is a small native helper linked to libuci. It offers the smallest
direct transaction implementation and can validate a narrow JSON input before
locking and committing, but the current Higo Lua dispatcher has no proved safe
process-spawn or FFI boundary to call it. Adding one risks a new custom IPC
mechanism and unclear ownership.

Option B is a narrow PROJECT_LOCAL ubus service exposing only notification
settings. It follows OpenWrt service conventions, centralizes allowlisting,
locking, transaction/commit and error handling, and is easier to unit-test and
extend safely. However, the current Higo Lua runtime exposes only named Go
adapter globals and no callable ubus client. The Higo-to-service invocation
boundary therefore remains unproved.

Neither option is closed end to end. A future design must define a fixed schema
of `eventType` plus three booleans, reject unknown keys/types/events, serialize
updates under one service-owned lock, stage all UCI changes before one explicit
commit, abort without commit on error, return typed error codes, run with
root-owned non-writable program/config files, and log no payload secrets. No
general-purpose UCI interface is allowed.

- `NOTIFICATION_STORAGE_CONTRACT=UNKNOWN`
- `NOTIFICATION_RUN21_CHANGE=NO`

## IPv6 diagnostic tool decision

Existing BusyBox `ip`, nft/fw4 counters and interface totals cannot attribute a
single client flow at ingress, QMAP egress and return boundaries without
counter resets or policy mutations. `tcpdump-mini` is the smallest existing
locked-tree packet capture package and depends only on `libpcap`. It is selected
for Rescue but is not started by init, hotplug or any boot path.

Locked provenance: ImmortalWrt core commit
`1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`, package `tcpdump` version
`4.99.6-1`, upstream `tcpdump.org`, upstream source archive SHA256
`5839921a0f67d7d8fa3dacd9cd41e44c89ccb867e8a6db216d62628c7fd14b09`;
dependency `libpcap 1.10.6-1` has upstream archive SHA256
`872dd11337fe1ab02ad9d4fee047c9da244d695c6ddf34e2ebb733efd4ed8aa9`.

## Future IPv6 evidence contract

On a future reviewed Run 21 RAM session, use one controlled numeric IPv6
target and short, concurrent captures on `br-lan` and `wwan0_1`. Collect one
bounded ICMP sample and, only if needed, one bounded TCP/HTTPS sample. Correlate
client packet ingress, fw4 acceptance, QMAP transmit, upstream return and LAN
delivery by protocol/address/port/time tuple. Do not reset counters or change
firewall, routes, sysctls, odhcpd or QModem. PCAP stays temporary/local; only a
sanitized conclusion may enter Git.

No IPv6 repair is proposed. `IPV6_ROOT_CAUSE=UNKNOWN`.

## Neighbour no-change decision

The accepted raw sample contained echo plus `OK` and no `+QENG` data row.
QModem and Higo correctly exposed empty arrays for that sample. Run 21 must not
modify the parser, API or RG520 AT path.

`NEIGHBOUR_RUN21_CHANGE=NONE`.

## Exact proposed Run 21 delta

1. Apply the deterministic display-only Higo `4G|5G` normalization patch.
2. Include `tcpdump-mini` in Rescue for manually invoked, bounded IPv6 evidence.
3. Extend Higo validation and build traceability for distinct canonical and
   patched runtime hashes.
4. Add static CPE regression fixtures and the resolved-config tcpdump gate.
5. Make no notification, neighbour, Full-only or modem configuration change.

## Run 21 regression/build gates

- Exact source/feed and H5000M gates remain mandatory.
- Apply twice; the runtime asset and tree hashes must be identical each time.
- Seven CPE fixtures pass, including all old presets and unknown fallback.
- Canonical vendor hashes remain unchanged; only the named runtime asset differs.
- QModem source/config/default files and RG520 gates remain unchanged and pass.
- Rescue resolves `CONFIG_PACKAGE_tcpdump-mini=y`; the binary is present but no
  init/hotplug/cron/default starts it.
- Higo/LuCI, Wi-Fi, LAN/DHCP, QMI/QMAP, IPv4 and device-side IPv6 requirements
  remain selected; later RAM validation must preserve Run 20 behavior.
- Normal compile, exact H5000M initramfs, embedded identity, manifest, report,
  resolved config, SHA256SUMS and artifact upload gates remain mandatory.
- Secret and raw-identity scans remain mandatory.

## Provenance impact and risk

`docs/PACKAGES.md` gains the exact `tcpdump-mini` record and separates Higo
vendor source from PROJECT_LOCAL runtime adaptation. Candidate Higo lock
metadata gains deterministic runtime hashes; ImmortalWrt, feeds, QModem and
driver commits are unchanged.

Risks are bounded to a brittle minified-asset anchor and added image size. The
exact-match refusal prevents silently patching an unknown vendor asset; Run 21
must measure the resulting image and rerun all static/build gates. Packet
capture capability exposes local traffic to root, so it remains manual,
bounded, RAM-session-only evidence with no automatic collection or committed
PCAP.

## Remaining unknown and stop

Notification device storage and LAN-client IPv6 root cause remain `UNKNOWN`.
Non-empty RG520 neighbour parser behavior remains unverified. This changeset is
`READY` for owner review and a separately authorized Run 21, which has not been
triggered. Return to `REVIEW_REQUIRED` and stop.
