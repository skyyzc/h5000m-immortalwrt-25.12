# Package baseline

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
| higoros | VENDOR_HIGO | 1.26.04.29.09-r1 | canonical local payload; hashes in candidate lock | rescue/full; vendor UI/API | PROJECT_LOCAL packaging, defaults, init and Higo:80/LuCI:8080 coexistence | Run 20 PASS; payload and installed-tree hashes PASS | Historical runtime only; current authenticated UI UNVERIFIED | Hash-pin; manual candidate change with compatibility/build/device evidence |
| luci | IMMORTALWRT_FEED | exact version UNKNOWN | luci `0b3572a17c1543257642716a4e1bdc9b0e74b8d4` | rescue/full; admin UI | PROJECT_LOCAL port-8080 coexistence configuration | Run 20 resolved selection and build PASS | Run 20 authenticated Overview, interfaces and logs UI PASS; Higo coexistence PASS | Feed-lock change only through candidate with build and device regression |
| qmodem | THIRD_PARTY | 3.2.0-r1 | FUjr/QModem `c1db0fe2067955d6b9c6b43efff1b69259f4b096` | rescue/full; RG520 management | PROJECT_LOCAL fixed profile and redial protection | Run 20 source/static/build gates PASS | Historical first dial; reconnect UNVERIFIED | Exact SHA pin; require compatibility, build, dial and reconnect evidence |
| uqmi | IMMORTALWRT_CORE | exact version UNKNOWN | ImmortalWrt `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0` | rescue/full; QMI control | Profile selection; no project patch recorded | Run 20 resolved selection and build PASS | Run 20 device IPv4/IPv6 data PASS; LAN-client IPv6 forwarding/delegation FAIL | Follow candidate source lock; rebuild and device regression required |
| kmod-qmi_wwan_q | THIRD_PARTY | 1.5-r1 | FUjr/QModem `c1db0fe2067955d6b9c6b43efff1b69259f4b096` | rescue/full; RG520 QMAP data path | In-tree kernel build; RG520 `2c7c:0801`, QMAP and Linux 6.x compatibility | Run 20 source/static/build gates PASS | Historical first dial; reconnect/QMAP longevity UNVERIFIED | Exact SHA pin; require kernel compatibility, build and device data-path evidence |

## FULL

| Package | Origin / Ownership | Historical version | Source / exact SHA | Profile / purpose | Integration / patch | Build validation | Device validation / known issue | Update policy |
|---|---|---|---|---|---|---|---|---|
| wrtbwmon | IMMORTALWRT_FEED | 1.2.1-r3 | UNKNOWN | full; per-client traffic | Historical Higo integration; current adapter contract UNKNOWN | Current Full build UNVERIFIED | Historical collection PARTIAL; Higo rendering UNVERIFIED | Lock exact source before Full; require build and UI/data validation |
| appfilter/kmod-oaf/luci-app-oaf | THIRD_PARTY | 7.0.1-r1 | UNKNOWN | full; application filtering | Historical integration only; exact patch state UNKNOWN | Current Full build UNVERIFIED | Historical services/data PARTIAL; blocking UNVERIFIED | Lock source before Full; require kernel/build/rule-block evidence |
| fancontrol | PROJECT_LOCAL | 2.0-r1 | UNKNOWN | full; PWM thermal policy | Historical local policy; exact current patch UNKNOWN | Current Full build UNVERIFIED | Historical PWM CONFIRMED; RPM unavailable | Recover provenance before Full; preserve thermal behavior and retest |
| luci-app-diskman | THIRD_PARTY | 0.2.13-r1 | UNKNOWN | full; external-disk UI | Historical integration; persistent-write paths intentionally blocked | Current Full build UNVERIFIED | Inventory PARTIAL; writes not tested | Lock source; test external media only after safety review |
| ksmbd-server/luci-app-ksmbd | IMMORTALWRT_FEED | 3.5.6-r1 | UNKNOWN | full; SMB | Historical integration; exact patch state UNKNOWN | Current Full build UNVERIFIED | Service/port PARTIAL; share read/write UNVERIFIED | Lock feed/source; build then external-media function test |
| miniupnpd/luci-app-upnp | IMMORTALWRT_FEED | 2.3.9-r1 | UNKNOWN | full; UPnP | Historical configuration, disabled by default | Current Full build UNVERIFIED | Mapping UNVERIFIED | Lock feed/source; preserve safe default and controlled mapping test |
| ddns-scripts/luci-app-ddns | IMMORTALWRT_FEED | 2.8.3-r5 | UNKNOWN | full; DDNS | Historical configuration only | Current Full build UNVERIFIED | Update UNVERIFIED | Lock feed/source; controlled test account after build |
| watchcat/luci-app-watchcat | IMMORTALWRT_FEED | 1-r25 | UNKNOWN | full; connectivity recovery | Historical configuration | Current Full build UNVERIFIED | Process historical; fault recovery UNVERIFIED | Lock feed/source; build and later fault-injection validation |
| zerotier/luci-app-zerotier | IMMORTALWRT_FEED | 1.16.0-r2 | UNKNOWN | full; overlay network | Historical install, disabled by default | Current Full build UNVERIFIED | Joining UNVERIFIED | Lock feed/source; preserve disabled default and controlled network test |
