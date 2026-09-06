# Package baseline

Vendor capability migration and legacy/current compatibility are tracked in
`VENDOR-COMPATIBILITY-MATRIX.md`; this file remains authoritative for component
origin, exact provenance, adaptation, and validation state.

Versions below distinguish historical runtime evidence from Run 20's clean
Rescue build evidence. `UNKNOWN` means an exact version or upstream source
commit was not proven; a successful build does not prove device behavior.

## Provenance contract

Origin/Ownership uses only `IMMORTALWRT_CORE`, `IMMORTALWRT_FEED`,
`OPENWRT_FEED`, `THIRD_PARTY`, `VENDOR_HIGO`, or `PROJECT_LOCAL`. Every new or
updated package/integration record must preserve package/version,
repository/source, exact SHA or `UNKNOWN`, profile, purpose,
integration/patch state, build validation, device validation, known issue, and
update policy. Version changes require `OLD -> NEW`, reason, compatibility
impact, build result, and device result; a bare version-number edit is invalid.

Exact candidate/stable locks live in `versions/candidate.json` and
`versions/stable.json`. This inventory records provenance and adaptation state,
not Higo feature gaps or build chronology.

## RESCUE

| Package | Origin / Ownership | Version | Source / exact SHA | Profile / purpose | Integration / patch | Build validation | Device validation / known issue | Update policy |
|---|---|---|---|---|---|---|---|---|
| higoros | VENDOR_HIGO | 1.26.04.29.09-r1 | canonical local payload; vendor-source and PROJECT_LOCAL runtime hashes in candidate lock | rescue/full; vendor UI/API | PROJECT_LOCAL packaging, defaults, init, Higo:80/LuCI:8080 coexistence, and deterministic display-only CPE `4G+5G` runtime patch | Run 20 vendor payload PASS; Run 21 patch/fixture/hash/build and firmware-runtime inspection PASS | Run 20 dashboard/CPE, safe `ATI`, logs, runtime tasks and terminal PASS; DEVICE-01F-E2 proved frontend normalization gap; Run 21 patched runtime device validation UNVERIFIED; notifications fail `not found`; Full-only widgets lack data | Preserve canonical vendor hash; patch/hash changes require explicit compatibility, build and device evidence |
| luci | IMMORTALWRT_FEED | exact version UNKNOWN | luci `0b3572a17c1543257642716a4e1bdc9b0e74b8d4` | rescue/full; admin UI | PROJECT_LOCAL port-8080 coexistence configuration | Run 20 resolved selection and build PASS | Run 20 authenticated Overview, interfaces and logs UI PASS; Higo coexistence PASS | Feed-lock change only through candidate with build and device regression |
| qmodem | THIRD_PARTY | 3.2.0-r1 | FUjr/QModem `c1db0fe2067955d6b9c6b43efff1b69259f4b096` | rescue/full; RG520 management | PROJECT_LOCAL fixed profile and redial protection | Run 20 source/static/build gates PASS | Run 20 dial/data and safe `ATI` PASS through 15h57m; CPE profile unrecognized and neighbour data absent; reconnect UNVERIFIED | Exact SHA pin; require compatibility, build, dial and reconnect evidence |
| uqmi | IMMORTALWRT_CORE | exact version UNKNOWN | ImmortalWrt `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0` | rescue/full; QMI control | Profile selection; no project patch recorded | Run 20 resolved selection and build PASS | Run 20 device IPv4/IPv6 data PASS; LAN-client IPv6 forwarding/delegation FAIL | Follow candidate source lock; rebuild and device regression required |
| kmod-qmi_wwan_q | THIRD_PARTY | 1.5-r1 | FUjr/QModem `c1db0fe2067955d6b9c6b43efff1b69259f4b096` | rescue/full; RG520 QMAP data path | In-tree kernel build; RG520 `2c7c:0801`, QMAP and Linux 6.x compatibility | Run 20 source/static/build gates PASS | Run 20 RG520 enumeration, QMAP and device IPv4/IPv6 PASS through 15h57m; reconnect remains UNVERIFIED | Exact SHA pin; require kernel compatibility, build and device data-path evidence |
| tcpdump-mini / libpcap | IMMORTALWRT_CORE | 4.99.6-1 / 1.10.6-1 | ImmortalWrt `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`; tcpdump archive SHA256 `5839921a0f67d7d8fa3dacd9cd41e44c89ccb867e8a6db216d62628c7fd14b09`; libpcap archive SHA256 `872dd11337fe1ab02ad9d4fee047c9da244d695c6ddf34e2ebb733efd4ed8aa9` | rescue; bounded IPv6 packet attribution | Profile-only selection; manual tool, no init/hotplug/automatic collector | Run 21 resolved config, provenance, compile and firmware-package inspection PASS; no-autostart PASS | Device use UNVERIFIED; PCAP must remain temporary/local and sanitized conclusions only | Follow exact candidate ImmortalWrt lock; require bounded RAM evidence validation before use |
| h5000m IPv6 shared-prefix route reconciler | PROJECT_LOCAL | Run 24 jshn nounset compatibility repair 1 (Run 22 route design and Run 23 dispatch retained) | This repository at the exact Git commit containing this inventory row; Run 23 build input `4aa49855a3a6932a72abd36366ba2a8749f04470`; locked libubox `7dd127841e82eb1cfb61185da37dde7b9bd9ba6d` | rescue/full through existing `higoros`; correct confirmed RFC7278 same-prefix return-route collision | `USBv6` logical iface plus `wwan0_1` device-guard hook and `/usr/libexec` helper; nounset is suspended only across locked jshn API use while errexit remains enabled; owns only `br-lan` metric `1` protocol `242`; runtime-only lock/state; no upstream/network/firewall/modem patch | Run 23 build PASS but device helper initialization failed. Run 24 prebuild PASS: 16 route fixtures, hotplug matrix, real-shell locked-jshn failure reproduction/compatibility test, double apply, exact install, ownership/prohibited-mutation and Higo regression gates | Run 23 device/function FAIL with proven `set -u`/unset `JSON_PREFIX` jshn initialization exit; Run 24 device behavior remains UNVERIFIED | Preserve locked jshn; require separate build authorization and exact-run RAM regression, renewal/reconnect lifecycle, rollback and recovery evidence |

## FULL

DEVICE-01R confirms that every Full row below still requires an exact source
resolution before a formal Full build. `UNKNOWN` is retained rather than
inventing a SHA. Package installation alone will not close the Higo adapter
gaps documented in `DEVICE-01R-GAP-AUDIT.md`.

| Package | Origin / Ownership | Historical version | Source / exact SHA | Profile / purpose | Integration / patch | Build validation | Device validation / known issue | Update policy |
|---|---|---|---|---|---|---|---|---|
| wrtbwmon / luci-app-wrtbwmon | THIRD_PARTY | 1.2.1-r3 / 2.0.13 | `brvphoenix/wrtbwmon@f82f9b393842d2113c3253a4902af50bfc757e1a`; `brvphoenix/luci-app-wrtbwmon@f1b59b2309a0bc45511a1e7432c6c72f080a47d7` | full; per-client traffic | Exact-source checkout; PROJECT_LOCAL deterministic lifecycle transform limits restarts to `lan` and resumes a stopped loop before procd termination | Full build pending; source/config/preflight ready | Historical collection works; Higo Device List/traffic schema remains BLOCKED_BY_EVIDENCE | Update exact candidate locks only; require Full build, single-instance and authenticated Higo chain validation |
| appfilter/kmod-oaf/luci-app-oaf | THIRD_PARTY | 7.0.1-r1 / current source head | `destan19/OpenAppFilter@b88fcb082597486a816187ec1e02812082161d5e` | full; application filtering | Linux 6.12 source build only; PROJECT_LOCAL typed legacy `appfilter` UCI/reload compatibility package; no legacy `.ko` | Full build/kernel API compatibility pending | Historical daemon/database PARTIAL; actual rule blocking UNVERIFIED | Exact SHA; require compile, RAM daemon/database, Higo schema and controlled block proof |
| fancontrol | PROJECT_LOCAL | 2.0-r2 | Full Candidate source `e726c7088121b85005e48dca9644a98f2a09ac6e` | full; PWM thermal policy | Conservative procd service with validated UCI temperature/PWM curve; no fabricated RPM | Source/static integration PASS; Full build pending | Historical PWM CONFIRMED; current package and thermal telemetry UNVERIFIED; RPM unsupported | Project review plus build and real thermal/PWM validation required |
| h5000m-full-compat | PROJECT_LOCAL | 1-r1 | Full Candidate source `e726c7088121b85005e48dca9644a98f2a09ac6e` | full; Higo/OAF compatibility | Installs bounded legacy appfilter contract and typed current `fwx` enable mapping; no fake result API | Source/static integration PASS; Full build pending | Current Higo OAF mutation/block behavior UNVERIFIED | Preserve exact UCI mapping; require authenticated API and controlled blocking proof |
| luci-app-diskman | IMMORTALWRT_FEED | 0.2.13-r1 | luci `0b3572a17c1543257642716a4e1bdc9b0e74b8d4` | full; external-disk UI | Full profile selects explicit USB/block/filesystem dependencies; internal storage writes remain prohibited | Full build pending | Historical inventory PARTIAL; writes not tested | Feed-lock changes require build; functional tests only on expendable external USB media |
| ksmbd-server/luci-app-ksmbd | IMMORTALWRT_FEED | 3.5.6-r1 / feed LuCI | packages `06325d98456698cd450980625faeed292426c8c0`; luci `0b3572a17c1543257642716a4e1bdc9b0e74b8d4` | full; SMB | Current feed source and kernel package selected | Full build pending | Historical service/port PARTIAL; share read/write UNVERIFIED | Build then external-media-only read/write validation |
| miniupnpd/luci-app-upnp | IMMORTALWRT_FEED | 2.3.9-r1 / feed LuCI | packages `06325d98456698cd450980625faeed292426c8c0`; luci `0b3572a17c1543257642716a4e1bdc9b0e74b8d4` | full; UPnP | nftables variant selected; locked safe default disabled and secure mode retained | Full build pending | Mapping UNVERIFIED | Preserve disabled default; controlled mapping test after RAM authorization |
| ddns-scripts/luci-app-ddns | IMMORTALWRT_FEED | 2.8.3-r5 / feed LuCI | packages `06325d98456698cd450980625faeed292426c8c0`; luci `0b3572a17c1543257642716a4e1bdc9b0e74b8d4` | full; DDNS | Current feed service/provider data and Higo network adapter route selected | Full build pending | Provider update UNVERIFIED | Controlled test account only after build/RAM authorization |
| watchcat/luci-app-watchcat | IMMORTALWRT_FEED | 1-r25 / feed LuCI | packages `06325d98456698cd450980625faeed292426c8c0`; luci `0b3572a17c1543257642716a4e1bdc9b0e74b8d4` | full; connectivity recovery | Deterministic Full transform removes the feed's implicit public-host reboot action; user policy required | Full build pending | Fault recovery UNVERIFIED | No automatic action by default; later bounded fault validation |
| zerotier/luci-app-zerotier | IMMORTALWRT_FEED | 1.16.0-r2 / feed LuCI | packages `06325d98456698cd450980625faeed292426c8c0`; luci `0b3572a17c1543257642716a4e1bdc9b0e74b8d4` | full optional; overlay network | Current source selected; disabled network/default-route/DNS defaults preserved | Full build pending | Joining UNVERIFIED | Preserve disabled default; controlled network test later |
