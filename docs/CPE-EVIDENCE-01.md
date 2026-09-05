# CPE-EVIDENCE-01

Date: 2026-09-06

## Session and safety

- Evidence firmware: accepted Run 21 Rescue, Run ID `33951063311`, number
  `21`, attempt `1`, profile `rescue`, source `candidate`.
- Build-input project / ImmortalWrt SHA:
  `ab4d2cbaa8e1b9fa8742ae397b15399f535a50d1` /
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`.
- Runtime identity matched Hiveton H5000M and `rootfs_type=initramfs`; `/` was
  tmpfs and the original eMMC squashfs remained mounted read-only.
- The session used only authenticated reads and temporary local inspection.
  No network/modem/configuration/firmware or persistent-storage state changed.

## Authenticated API fixture

Authenticated `GET /api/v1/cpe/network-mode` returned HTTP `200` with this
sanitized effective payload:

```json
{
  "mode": "auto",
  "currentMode": "4G, 5G",
  "selectedNetworks": ["4G", "5G"],
  "supportedNetworks": ["3G", "4G", "5G"]
}
```

The same acquisition window returned QModem network preference
`3G=0,4G=1,5G=1`. Backend and QModem semantics are therefore unchanged from
the closed Run 20 fixture.

## Live browser resource evidence

- A newly created isolated in-app browser tab logged in to the Run 21 Higo
  instance and opened `/cpe`.
- The browser resource inventory observed the CPE module request at
  `http://192.168.88.1/assets/CPEManagement-CuEyMeyg.js`.
- The device served that URL as HTTP `200`, `Content-Length: 85584`,
  `Content-Type: text/javascript; charset=utf-8`, with a fixed
  `Last-Modified: Thu, 01 Jan 1970 00:00:02 GMT`. It supplied no observable
  `Cache-Control`, `ETag`, `Age`, or `Expires` header.
- A no-store server fetch of those bytes produced SHA256
  `f8eef73d3abe39a5170c3d84f952bbf5683690b6f240a23a9d58a783d2e33ad0`.
  This equals the Run 21 patched chunk hash and differs from the canonical
  vendor chunk SHA256
  `25ee8623734da8e8cb369ff9cd4e5eb415106f431d522c0ddc6ce9d5d19289e8`.
- The browser evidence interface exposed the requested resource URL but did
  not expose the response body or a body hash for the already evaluated
  module. Consequently the hash above proves the bytes currently served at
  that URL, not the exact bytes selected earlier from the browser's HTTP
  cache/module loader.

## Visible result and decision

The fresh tab still rendered the current-configuration title
`未识别配置`, with the separate `4G / 5G` badge and the `5G 优先` card selected.
No save/apply operation was invoked.

This evidence rejects an incorrect server/runtime-image asset as the cause:
Run 21 contains and currently serves the intended patched bytes. It does not
yet distinguish these two remaining boundaries:

1. the browser selected older canonical bytes from cache for the unchanged
   content-hashed URL; or
2. the browser evaluated the patched resolver but the live runtime data shape
   reaching that resolver differs from the captured API fixture.

Because the exact browser-loaded response bytes were not exportable, neither
branch is proven. `CPE_RCA=UNKNOWN` and `CPE_REPAIR_UNBLOCKED=NO`; the remaining
evidence is an actual browser response-body capture/hash for the observed
request (or equivalent debugger proof of the evaluated resolver and its live
input). No speculative repair is authorized by this record.

## Status

- `CPE_LIVE_RESOURCE_CAPTURED=PARTIAL`
- `CPE_LOADED_CHUNK_URL=http://192.168.88.1/assets/CPEManagement-CuEyMeyg.js`
- `CPE_LOADED_CHUNK_HASH=UNKNOWN`
- `CPE_SERVED_CHUNK_HASH=f8eef73d3abe39a5170c3d84f952bbf5683690b6f240a23a9d58a783d2e33ad0`
- `CPE_LOADED_CHUNK_IDENTITY=UNKNOWN`
- `CPE_SERVED_CHUNK_IDENTITY=RUN21_PATCHED`
- `CPE_API_CAPTURED=YES`
- `CPE_VISIBLE_TITLE=未识别配置`
- `CPE_RCA=UNKNOWN`
- `CPE_REPAIR_UNBLOCKED=NO`
- `MISSING_EVIDENCE=BROWSER_RESPONSE_BODY_HASH_OR_EQUIVALENT_EVALUATED_CODE_PROOF`
- `DEVICE_MODIFIED=NO`
- `PERSISTENT_STORAGE_MODIFIED=NO`
