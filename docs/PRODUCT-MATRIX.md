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
| PLATFORM_HARDWARE | Ethernet/LAN/DHCP | PASS | Run 21 exact-run function evidence |
| PLATFORM_HARDWARE | wired WAN validation | UNVERIFIED | no cable/link function test |
| PLATFORM_HARDWARE | LEDs/buttons | PARTIAL | basic indicators observed; complete LED semantics and buttons untested |
| PLATFORM_HARDWARE | storage/eMMC safety | PROHIBITED | recovery/rollback not proven |
| PLATFORM_HARDWARE | thermal/fan | HISTORICALLY_FUNCTION_TESTED | historical Full PWM; current 25.12 Full pending |
| PLATFORM_HARDWARE | hardware acceleration boundary | BLOCKED_BY_EVIDENCE | WED/HNAT provenance, configuration, safety and function not closed |
| VENDOR_WIRELESS | MT7992 2.4/5 GHz functional path | PASS | real clients passed association, DHCP, Higo and Internet |
| VENDOR_WIRELESS | current kernel/driver path | PARTIAL | maintained ImmortalWrt/Linux 6.12 path runs; advanced vendor parity unproven |
| VENDOR_WIRELESS | firmware blob compatibility/provenance | PARTIAL | functioning radios; exact blob mapping remains incomplete; see vendor matrix/PACKAGES |
| VENDOR_WIRELESS | EEPROM/calibration preservation/provenance | PARTIAL | functioning radios; complete provenance/factory-boundary audit remains |
| VENDOR_WIRELESS | regulatory/channel/bandwidth parity | UNVERIFIED | no complete current-versus-vendor parity validation |
| VENDOR_WIRELESS | WED | BLOCKED_BY_EVIDENCE | historical capability does not prove current path/function |
| VENDOR_WIRELESS | HNAT/flow offload | BLOCKED_BY_EVIDENCE | provenance and IPv6/QMAP interaction unproven |
| VENDOR_WIRELESS | stability/performance/vendor parity | UNVERIFIED | bounded functional clients do not establish performance or full parity |
| RG520_MODEM | USB enumeration | PASS | Run 21 exact-run evidence |
| RG520_MODEM | QModem/qmi_wwan_q | PASS | Run 21 function-tested |
| RG520_MODEM | QMI/QMAP data path | PASS | Run 21 function-tested |
| RG520_MODEM | first dial | PASS | current Rescue established working cellular data path |
| RG520_MODEM | device IPv4 | PASS | Run 21 device-side connectivity |
| RG520_MODEM | device IPv6 | PASS | Run 21 device-side connectivity |
| RG520_MODEM | LAN-client IPv6 forwarding | FAIL | Run 22 helper dispatch failed; Run 23 static repair only |
| RG520_MODEM | manual reconnect | UNVERIFIED | separately authorized state-changing validation required |
| RG520_MODEM | modem/service reconnect | UNVERIFIED | lifecycle recovery not function-tested |
| RG520_MODEM | USB reset/re-enumeration recovery | UNVERIFIED | state-changing recovery test not authorized/proven |
| RG520_MODEM | IPv4 recovery | UNVERIFIED | reconnect recovery not function-tested |
| RG520_MODEM | IPv6/prefix renewal recovery | UNVERIFIED | future exact-run lifecycle contract |
| RG520_MODEM | lifecycle/reconnect regression boundary | UNVERIFIED | Run 23 remains unbuilt and device-unverified |
| HIGO_PRODUCT | Higo/LuCI coexistence | PASS | Run 21; details in `HIGO-FEATURES.md` |
| HIGO_PRODUCT | core CPE status/network presentation | PASS | Run 21 `4G + 5G` live resolver/title function evidence |
| HIGO_PRODUCT | complete Rescue Higo scope | PARTIAL | `HIGO-FEATURES.md` exclusively owns detailed gaps and next steps |
| HIGO_PRODUCT | complete Full Higo integration scope | DEFERRED | recover Full dependencies/contracts; details remain in HIGO-FEATURES |
| FULL_CAPABILITIES | wrtbwmon collection | PARTIAL | exact current source and lifecycle adaptation ready for build; current build/device proof absent |
| FULL_CAPABILITIES | Higo Device List integration | PARTIAL | historical cache/client evidence incomplete; adapter closure unresolved |
| FULL_CAPABILITIES | Higo Traffic/ranking integration | PARTIAL | collector evidence does not prove current Higo rendering |
| FULL_CAPABILITIES | OAF/OpenAppFilter | PARTIAL | exact current source and Linux 6.12 source-build path configured; compile/RAM/block proof pending |
| FULL_CAPABILITIES | Higo OAF adapter/control contract | PARTIAL | typed legacy-to-current enable/reload shim implemented; full rule/schema/block contract still needs RAM evidence |
| FULL_CAPABILITIES | fancontrol | PARTIAL | PROJECT_LOCAL source/policy integrated; dynamic PWM historical; current build/RAM validation absent; RPM unsupported |
| FULL_CAPABILITIES | DiskMan | PARTIAL | historical inventory/UI evidence; current safe write function unverified |
| FULL_CAPABILITIES | KSMBD | HISTORICALLY_RUNNING | historical service/port; share read/write unverified |
| FULL_CAPABILITIES | UPnP | HISTORICALLY_RUNNING | historical install/disabled state; controlled mapping unverified |
| FULL_CAPABILITIES | DDNS | PARTIAL | historical config readable; update unverified |
| FULL_CAPABILITIES | Watchcat | HISTORICALLY_RUNNING | historical process; fault recovery unverified |
| FULL_CAPABILITIES | ZeroTier | HISTORICALLY_RUNNING | historical install/disabled state; joining unverified |
| LIFECYCLE | exact source/provenance locks | PASS | candidate Rescue locks and formal source gates through Run 22 |
| LIFECYCLE | formal build/artifact acceptance | PASS | Run 22 build and artifact acceptance; build-scoped only |
| LIFECYCLE | Rescue exact-run validation | PARTIAL | Run 21 PASS; Run 22 function FAIL; Run 23 unbuilt |
| LIFECYCLE | Full build/validation | DEFERRED | recover/provenance-lock Full Required before build/RAM closure |
| LIFECYCLE | recovery | PARTIAL | Run 22 power-cycle returned original system; broader recovery model unproven |
| LIFECYCLE | rollback | BLOCKED_BY_EVIDENCE | persistent rollback/failure recovery not designed or proven |
| LIFECYCLE | upstream tracking | DEFERRED | required durable lifecycle; automation not yet implemented |
| LIFECYCLE | update/OTA lifecycle | PROHIBITED | blocked by persistent safety and recovery/rollback prerequisites |
| LIFECYCLE | manual stable promotion | DEFERRED | requires accepted candidate build and exact-run validation |
| LIFECYCLE | persistent/eMMC deployment | PROHIBITED | all safety gates and separate owner authorization required |
