# DEVICE-01F-E Missing Evidence Acquisition

Date: 2026-09-05

## A. Session identity

- Phase / result: `DEVICE-01F-E` / `PARTIAL`
- Evidence baseline: `rebuild-v1` at
  `036d5a928a07b2d0611b936dbf3a7a63ff99494b`; local and
  `origin/rebuild-v1` matched and the tree was initially clean.
- The owner performed Recovery WebUI `Load initramfs`; Codex did not operate
  U-Boot.

## B. Run 20 identity

- Run ID / number / attempt: `33836565597` / `20` / `1`
- Profile / source: `rescue` / `candidate`
- Project / ImmortalWrt SHA:
  `698aecdc52218c3565239e97bfd224b6c4af8f02` /
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`
- Firmware: `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`
- SHA256: `af4f129d68cbb0b2e6d06ed2dbccd64e100bc7403cf69f62b95093d7e86af13e`
- Embedded `/etc/h5000m-build.json` matched these identities.

## C. Safety state

`/` was tmpfs; the original squashfs was mounted read-only. LAN/SSH, RG520 USB
`2c7c:0801`, `quectel-CM-M`, QMI and QMAP remained alive. No UCI, firewall,
route, sysctl, odhcpd, QModem, band, network-mode, service or persistent-storage
mutation occurred. No raw AT, tty writer, modem reset, firmware build or Run 21
was performed. Public IPv6, MAC and cellular identifiers are omitted.

## D. Network-mode fixture

Authenticated Higo selected `USB (RG520N-CN)`. Its network page reported
support for `3G / 4G / 5G`, displayed `未识别配置`, and simultaneously presented
`5G 优先` with `3G / 4G / 5G` as the pending/default selection. Save was not
used. Unauthenticated GET `/api/v1/cpe/network-mode` returned HTTP `401`, code
`4010`.

The secure browser boundary did not expose the authenticated raw body without
exporting its bearer credential. A bearer-in-process-arguments approach was
rejected; an interactive alternative was stopped before password input when
the image proved to lack `stty`. The authenticated HTTP status and raw schema
therefore remain `UNVERIFIED`, not inferred from UI text.

## E. QModem matching fixture

Formal read-only call:

`ubus call qmodem get_network_prefer {"config_section":"2_1"}`

Successful sanitized response:

```json
{"network_prefer":{"3G":"0","4G":"1","5G":"1"}}
```

UCI policy retained section `2_1`, metric `11`, network `wwan0` and manufacturer
`quectel`. No UCI field changed.

## F. CPE failing boundary

QModem state is `4G + 5G`, not the frontend's displayed `5G 优先` set of
`3G + 4G + 5G`. The frontend predicate still depends on exact `mode` or
normalized `selectedNetworks`, not `profileName`. The contradiction is real,
but the missing authenticated API body prevents choosing between closed-backend
conversion and API schema.

- `CPE_NETWORK_MODE_FIXTURE=PARTIAL`
- `CPE_FAILURE_BOUNDARY=BACKEND_CONVERSION_OR_API_SCHEMA` (`PARTIAL`)

## G. IPv6 evidence

- `USBv6` was up on `wwan0_1` with DHCPv6, a global address, default route and
  delegated `/64`; netifd assigned that `/64` to LAN.
- `br-lan` held delegated global and ULA assignments.
- `network.USBv6.extendprefix='1'`; `network.lan.ip6assign='60'`.
- odhcpd was an RA server; LAN DHCPv6 was disabled.
- IPv6 forwarding was enabled globally and on br-lan/wwan/QMAP; proxy-NDP was
  off. A delegated-source default route existed.
- fw4 contained LAN-to-WAN acceptance for `wwan0_1`. Cumulative fw4 and link
  counters advanced, but background traffic prevents flow attribution.
- `tcpdump`, `fuser` and `lsof` were absent; no capture or counter reset was
  fabricated.
- A real LAN client selected a global IPv6 source. Numeric ICMP sent four and
  received zero (`100%` loss). Numeric HTTPS to the same fixed endpoint used an
  explicit TLS Host/SNI mapping, timed out connecting and returned HTTP `000`.
  This excludes DNS-only and ICMP-only explanations.

## H. IPv6 hypothesis update

PD/extendprefix mismatch, missing source route, client source selection and an
obvious fw4 policy drop now have evidence against them (`LOW`). Upstream return
behavior remains `MEDIUM-LOW`; QMAP forwarded-path behavior remains `MEDIUM`.
Proxy-NDP and stale-lifetime hypotheses remain `LOW`. Without paired capture or
flow-attributed counters:

- `IPV6_ROOT_CAUSE=UNKNOWN`
- `IPV6_FAILURE_BOUNDARY=FORWARDED_PATH_OR_UPSTREAM_RETURN` (`PARTIAL`)

No NAT66, proxy-NDP, fw4, odhcpd, route, sysctl or QModem repair is justified.

## I. Neighbour Higo/API evidence

Unauthenticated GET `/api/v1/cpe/neighborcell` returned HTTP `401`, code `4010`.
The authenticated Higo page selected `USB (RG520N-CN)` and showed no usable
neighbour rows. The exact authenticated response body was not exported under
the credential-safety boundary. Bounded logs did not prove an invocation or
parser error.

## J. Neighbour QModem evidence

Formal read-only `get_neighborcell` for section `2_1` exited `0` and returned a
structured `neighborcell` object whose LTE and NR arrays were both empty. Lock
status was `unlock`; no boot-hook AT commands were configured. No setter ran.

- `NEIGHBOUR_FAILURE_BOUNDARY=QMODEM_CONTROLLER_EMPTY` (`CONFIRMED`)
- `NEIGHBOUR_ROOT_CAUSE=UNKNOWN`

Higo is not proved to discard non-empty rows. Raw evidence is needed to
distinguish modem/environment-empty from parser-empty.

## K. AT ownership

`quectel-CM-M`, `modem_scand`, QModem dial logic and `higorosd` were active.
No persistent tty owner was visible, but `fuser`/`lsof` were absent and no
dedicated AT arbitration lock was proved. An idle-looking tty is insufficient.
No tty was opened.

- `NEIGHBOUR_RAW_AT_REQUIRED=YES`
- `AT_RAW_QUERY_AUTHORIZED=NO`

A future single bounded QModem-owned `AT+QENG="neighbourcell"` fixture requires
separate owner authorization.

## L. Notification storage-boundary research

The unchanged vendor Lua dispatcher calls named typed Go adapters, but exposed
adapters are route-specific network/Wi-Fi functions. Targeted source, symbol
and installed-helper searches found no generic typed UCI transaction interface
callable by a PROJECT_LOCAL notification wrapper. Internal `uci command`
strings prove private implementation only. Image-time UCI defaults provide no
runtime typed input, locking, atomicity or error contract.

`NOTIFICATION_STORAGE_CONTRACT=UNKNOWN`. No `os.execute`, interpolated shell,
memory-only fake backend or vendor-payload modification is acceptable.

## M. Remaining UNKNOWN

- Authenticated network-mode JSON and closed-backend conversion.
- IPv6 br-lan/QMAP packet boundary and upstream return/NDP behavior.
- Raw neighbour response and modem-empty versus parser-empty.
- Safe typed/atomic notification UCI transaction interface.

## N. Closed repair contracts

- CPE: not closed; QModem input is confirmed, API output is partial.
- Notification: not closed; delegation is proved, storage remains unknown.
- IPv6: not closed; runtime topology and two-protocol client failure are
  confirmed, root cause is unknown.
- Neighbour: the first empty-data boundary is closed at QModem controller;
  modem/parser root cause is not closed.

## O. Recommended implementation scope

None. A future review may acquire authenticated network-mode JSON through an
approved non-exporting credential helper and separately authorize one
QModem-owned raw neighbour fixture. IPv6 needs bounded packet/flow evidence;
notification needs a reviewed typed/atomic helper contract.

## P. STOP decision

`DEVICE-01F-E=PARTIAL`. Material evidence was acquired, but no repair contract
is ready for DEVICE-01F-II. Return to `REVIEW_REQUIRED`; do not trigger Run 21,
start Full or modify persistent storage.
