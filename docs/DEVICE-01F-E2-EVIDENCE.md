# DEVICE-01F-E2 Evidence Closure

Date: 2026-09-05

## 1. Session identity

- Phase / result: `DEVICE-01F-E2` / `COMPLETE`.
- Evidence baseline: `rebuild-v1` at
  `e7409da1b660af0e8737f90bd709578f9611d3f0`; local and
  `origin/rebuild-v1` matched and the tracked tree was clean.
- Run ID / number / attempt: `33836565597` / `20` / `1`.
- Profile / source: `rescue` / `candidate`.
- Project / ImmortalWrt SHA:
  `698aecdc52218c3565239e97bfd224b6c4af8f02` /
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`.

## 2. Active authorization policy

`NEW_AUTH_POLICY_ACTIVE=YES`. Project-scoped authentication, read-only
evidence and local raw analysis were used under the policy committed as
`e7409da1b660af0e8737f90bd709578f9611d3f0`. No credential, session token or
raw unique identifier is retained here.

## 3. Runtime safety state

Embedded `/etc/h5000m-build.json` identified Run 20, rescue and the expected
project/ImmortalWrt SHAs. `/` was tmpfs. Original `/dev/mmcblk0p5` remained a
read-only squashfs mount. Higo, QModem, the dial worker and `quectel-CM-M` were
active. No UCI, radio, modem, service, route, firewall, firmware or persistent
storage setting was changed.

## 4. Authenticated CPE network-mode fixture

Authenticated `GET /api/v1/cpe/network-mode` returned HTTP `200` with the
following sanitized effective schema:

```json
{
  "code": 0,
  "message": "ok",
  "data": {
    "mode": "auto",
    "currentMode": "4G, 5G",
    "supportedNetworks": ["3G", "4G", "5G"],
    "selectedNetworks": ["4G", "5G"]
  }
}
```

Transport metadata unrelated to the predicate was omitted. No save or mode
mutation was performed.

## 5. QModem matching fixture

In the same acquisition window, formal read-only
`qmodem.get_network_prefer` for section `2_1` returned:

```json
{"network_prefer":{"3G":"0","4G":"1","5G":"1"}}
```

The QModem state and Higo API `selectedNetworks` therefore agree exactly.

## 6. CPE end-to-end contract and failure boundary

The closed path is:

`QModem 0/1/1 -> backend [4G,5G] -> HTTP 200 schema -> frontend preset match`.

The frontend first looks for a preset whose value exactly equals `mode`.
`auto` is not one of its preset values. It then compares normalized selected
networks against these fixed sets: `3G|4G|5G`, `3G|4G`, `5G`, `4G`, or `3G`.
`4G|5G` matches none, so the computed current title is `未识别配置`. The backend
conversion and API schema faithfully represent QModem state.

- `CPE_FAILURE_BOUNDARY=FRONTEND_NORMALIZATION` (`CONFIRMED`)
- `CPE_CONTRACT_CLOSED=YES`

This is evidence only. It does not select a repair policy for the legitimate
`4G + 5G` combination.

## 7. Neighbour ownership gate

The proved existing path is:

`qmodem ubus send_at -> modem_ctrl.sh -> at() -> tom_modem -> configured AT port`.

The same QModem implementation uses its Quectel
`cmd_qeng_neighbourcell()` helper and parser for `get_neighborcell`. The
configured port was resolved by QModem; no direct tty reader/writer, competing
serial process, service stop or retry loop was used. The ownership gate passed.

## 8. Raw neighbour evidence and parser comparison

Exactly one bounded query-only `AT+QENG="neighbourcell"` was issued through
the proved QModem path. Its sanitized raw result contained only command echo
and terminal `OK`; it contained no `+QENG` data row. The authenticated Higo
endpoint returned HTTP `200` and the same structured `neighborcell` object as
QModem, with empty LTE and NR arrays.

Therefore the parser had no neighbour row to discard in this sample:

- `NEIGHBOUR_RAW_RESULT=MODEM_RAW_EMPTY` (`CONFIRMED`)
- `NEIGHBOUR_ROOT_CAUSE=MODEM_RAW_EMPTY_AT_SAMPLE`
- `NEIGHBOUR_FAILURE_BOUNDARY=MODEM_OR_RADIO_ENVIRONMENT`
- `NEIGHBOUR_CONTRACT_CLOSED=YES` for the observed empty-result chain.

This does not prove that all RG520 firmware/network conditions always return
empty data, nor does it validate parser handling of a future non-empty fixture.

## 9. QMI/QMAP post-query regression

Before and after the query, `network.interface.USB` remained up on `wwan0_1`
with the same lease and default route; the QMAP link remained `UP,LOWER_UP`,
and both the dial worker and `quectel-CM-M` retained their process identities.
The bounded IPv4 ICMP sample received no reply both before and after, so it is
not positive Internet evidence, but there was no query-correlated regression.
The already accepted Run 20 IPv4 functional evidence is not replaced.

`QMI_QMAP_AFTER_AT=PASS` for session continuity.

## 10. Notification storage contract research

The installed Higo Lua dispatcher can call only named Go globals and has no
notification routes. Its Lua module directory exposes no native UCI/ubus module
to that dispatcher. Targeted repository and runtime searches found no existing
PROJECT_LOCAL typed transaction helper. Frontend local-storage caching is a
browser-only fallback and is not an atomic device configuration contract.

A future helper can be designed around libuci or a dedicated ubus service, but
the callable Higo-to-helper boundary and runtime ownership are not yet proved.
Consequently typed input, allowlisting, locking, atomic commit and explicit
error semantics are not closed end to end.

`NOTIFICATION_STORAGE_CONTRACT=UNKNOWN`.

## 11. IPv6 packet-evidence requirement

No low-value IPv6 retest was performed. Existing evidence still proves PD,
LAN assignment, forwarding, source routing and fw4 policy, while real-client
numeric ICMP and HTTPS fail. The missing discriminator is a bounded,
flow-attributed observation across `br-lan`, fw4 and `wwan0_1`/QMAP, including
return traffic. Future review may add a minimal packet-capture capability to a
Rescue image; this session installed nothing and changed no networking state.

- `IPV6_ROOT_CAUSE=UNKNOWN`
- `IPV6_FAILURE_BOUNDARY=FORWARDED_PATH_OR_UPSTREAM_RETURN`
- `IPV6_PACKET_EVIDENCE_REQUIRED=YES`

## 12. Remaining unknowns and closed contracts

- CPE: contract closed; implementation policy for the valid `4G + 5G` profile
  needs review.
- Neighbour: the observed empty path is closed at modem raw output; behavior
  with a non-empty RG520 QENG fixture remains unverified.
- Notification: device-side typed/atomic storage contract remains unknown.
- IPv6: root cause remains unknown pending packet-attributed evidence.

## 13. Recommended implementation scope

`READY_FOR_DEVICE-01F-II=PARTIAL`. Review may now design the minimal CPE
frontend normalization change. Do not implement a neighbour parser change from
this empty sample. Notification and IPv6 remain blocked on their stated
evidence boundaries.

## 14. STOP decision

Return to `REVIEW_REQUIRED`. No firmware change, source-lock change, Run 21,
Full build or persistent-storage operation was performed.
