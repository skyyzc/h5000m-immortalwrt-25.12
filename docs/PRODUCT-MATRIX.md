# H5000M Product Matrix

All permanent domains remain visible. Allowed states are `PASS`, `PARTIAL`,
`FAIL`, `BLOCKED_BY_EVIDENCE`, `DEFERRED`, `UNVERIFIED`, `PROHIBITED`,
`HISTORICALLY_RUNNING`, and `HISTORICALLY_FUNCTION_TESTED`.

Permanent capabilities remain listed even when deferred, blocked, unverified,
or outside the current task. Removal requires an explicit Charter-level
product-scope decision.

| Domain | Capability | Status | Evidence / next boundary |
|---|---|---|---|
| PLATFORM_HARDWARE | H5000M MT7987A boot/board | PASS | Run 21 last function-tested Rescue; Run 22 RAM boot passed |
| PLATFORM_HARDWARE | Ethernet/LAN/DHCP | PASS | Run 21; wired WAN cable test UNVERIFIED |
| PLATFORM_HARDWARE | LEDs | PARTIAL | basic indicators observed; complete semantics untested |
| PLATFORM_HARDWARE | storage/eMMC safety | PROHIBITED | recovery/rollback not proven |
| PLATFORM_HARDWARE | thermal/fan | HISTORICALLY_FUNCTION_TESTED | historical Full PWM; current 25.12 Full pending |
| VENDOR_WIRELESS | MT7992 2.4/5 GHz AP/client | PASS | real clients passed association, DHCP, Higo and Internet |
| VENDOR_WIRELESS | firmware/calibration provenance | PARTIAL | see vendor matrix |
| VENDOR_WIRELESS | WED/HNAT/offload | BLOCKED_BY_EVIDENCE | current path/function unproven |
| RG520_MODEM | USB/QModem/qmi_wwan_q/QMI/QMAP | PASS | Run 21 function-tested |
| RG520_MODEM | device IPv4/IPv6 | PASS | Run 21 device-side connectivity |
| RG520_MODEM | LAN-client IPv6 forwarding | FAIL | Run 22 helper dispatch failed; Run 23 static repair only |
| RG520_MODEM | reconnect/prefix renewal | UNVERIFIED | future exact-run contract |
| HIGO_PRODUCT | Higo/LuCI coexistence | PASS | Run 21; details in `HIGO-FEATURES.md` |
| HIGO_PRODUCT | CPE `4G + 5G` title | PASS | Run 21 live function evidence |
| HIGO_PRODUCT | complete Higo feature set | PARTIAL | `HIGO-FEATURES.md` owns gaps/next steps |
| FULL_CAPABILITIES | wrtbwmon/OAF/fan/storage/services | HISTORICALLY_RUNNING | current provenance/build/function incomplete |
| FULL_CAPABILITIES | UPnP/DDNS/Watchcat/ZeroTier | HISTORICALLY_RUNNING | current Full tests UNVERIFIED |
| LIFECYCLE | source reconstruction/config resolution | PASS | formal candidate gates through Run 22 |
| LIFECYCLE | single clean Rescue build | PASS | Run 22 build/artifact acceptance |
| LIFECYCLE | byte-for-byte reproducibility | UNVERIFIED | clean builds do not establish byte identity |
| LIFECYCLE | Rescue exact-run validation | PARTIAL | Run 21 PASS; Run 22 function FAIL; Run 23 unbuilt |
| LIFECYCLE | current Full build | DEFERRED | recover/provenance-lock capabilities first |
| LIFECYCLE | stable/update/persistent deploy | PROHIBITED | manual gates plus recovery/rollback prerequisites |
