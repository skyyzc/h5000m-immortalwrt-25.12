# Higo feature matrix

The complete Original 24.10 -> Run 20 Rescue -> expected Full classification,
root-cause reports and priority backlog are in `DEVICE-01R-GAP-AUDIT.md`. This
file remains the authoritative concise Higo feature gap/next-step matrix.

The reviewed repair contracts for notification settings and canonical RG520
profile presentation, plus the evidence-first neighbour plan, are in
`DEVICE-01F-REPAIR-DESIGN.md`. They are design evidence only; no implementation
or Run 21 result is implied.

Evidence: historical latest-full analysis plus the canonical frontend/API
payload. Status is conservative: package presence is not treated as proof that
an authenticated page operation works.

This file remains the Higo feature gap, evidence, and next-step matrix. Package
provenance belongs in `docs/PACKAGES.md`, exact locks in `versions/*.json`, and
build history or repairs in `CHANGELOG.md`.

| Feature | Vendor | Latest Full | Target | Backend | Preserved | Gap / reason | Next step |
|---|---|---|---|---|---|---|---|
| Home | yes | Run 20 authenticated dashboard mostly renders | rescue | Higo API | UI_OK / PARTIAL | device distribution, connected devices and application ranking lack useful data; latter integrations belong to Full | preserve evidence; Full integration test later |
| 5G status | yes | Run 20 network type and signal read successfully | rescue | QModem/Higo | FUNCTION_TESTED / PARTIAL | DEVICE-01F-E confirms QModem `3G=0,4G=1,5G=1` while Higo shows an unrecognized current configuration and a 3G/4G/5G pending default; authenticated raw API JSON remains unavailable, so backend conversion vs API schema is not closed | acquire sanitized authenticated JSON through an approved credential-safe path; do not change mode |
| APN | yes | Run 20 network-settings page loads | rescue | QModem/UCI | UI_OK / PARTIAL | network-mode configuration label is unrecognized; this is not proved to depend on APN or `profileName`; editing not tested | preserve APN; capture network-mode fixture without mutation |
| Signal | yes | Run 20 live signal status reads normally | rescue | QModem/Higo | FUNCTION_TESTED | reconnect transition not observed | reconnect regression later |
| SIM | yes | Run 20 SIM-management page displays normally | rescue | QModem | UI_OK / PARTIAL | controls not tested | controlled function test later |
| SMS | yes | Run 20 SMS-management page displays normally | rescue | QModem | UI_OK / PARTIAL | send/delete not tested | controlled function test later |
| AT | yes | Run 20 Higo `ATI` returned module identification | rescue | QModem | FUNCTION_TESTED | read-only query passed with no observed QMI/data interruption; mutating AT remains prohibited | retain safe-query evidence; reconnect/race test later |
| Lock band/network | yes | Run 20 band-lock page displays normally | rescue | QModem | UI_OK / PARTIAL | mutation untested | controlled test later |
| Neighbour cells | yes | Run 20 continuously reports no neighbour information while registered | rescue | QModem/Higo | PARTIAL / FAIL | formal `get_neighborcell` succeeds but returns empty LTE/NR arrays; first proved boundary is `QMODEM_CONTROLLER_EMPTY`, while modem-empty vs parser-empty remains UNKNOWN | separate review for one bounded QModem-owned raw fixture; no AT authorization exists |
| CPE traffic management | yes | Run 20 page displays normally | rescue | QModem/Higo | UI_OK / PARTIAL | counters/limits not mutation-tested | controlled test later |
| Wi-Fi | yes | Run 20: 2.4/5 GHz real clients passed association, DHCP, Higo and Internet | rescue | UCI/mac80211 | FUNCTION_TESTED | current Rescue defaults are open for isolated RAM validation | security design later; do not alter DEVICE-01 image |
| LAN | yes | 192.168.88.1 works | rescue | netifd | PRESERVED | none known | regression test |
| WAN | yes | eth1 no-link sample | rescue | netifd | UNKNOWN | no cable/link test | link test |
| DHCP | yes | clients observed | rescue | dnsmasq | PRESERVED | none known | regression test |
| IPv6 | yes | Run 20 device-side IPv6 works; LAN client gets RA/default route but external IPv6 times out | rescue | netifd/odhcpd | PARTIAL / CLIENT_FAIL | DEVICE-01F-E confirms PD-to-LAN assignment, forwarding and fw4 path plus numeric ICMP loss and numeric HTTPS timeout; without packet-attributed evidence the boundary remains forwarded path or upstream return and root cause is UNKNOWN | obtain bounded packet/flow boundary evidence before repair design |
| Device list | yes | cache exists; clients not proven | full | Higo/wrtbwmon | PARTIAL | data contract unverified | authenticated UI test |
| Blacklist | yes | UNKNOWN | full | Higo/firewall | UNKNOWN | no operation evidence | functional test |
| Traffic | yes | wrtbwmon collects | full | wrtbwmon/Higo | PARTIAL | Higo rendering unproven | adapter/UI test |
| App filtering | yes | OAF services/data present | full | OpenAppFilter | PARTIAL | actual blocking untested | rule/block test |
| Firewall | yes | base firewall works | rescue | firewall4 | PARTIAL | Higo editing untested | API/UI test |
| DMZ | yes | UNKNOWN | full | firewall4 | UNKNOWN | no evidence | functional test |
| UPnP | yes | installed, disabled | full | miniupnpd | PARTIAL | mapping untested | controlled mapping test |
| DDNS | yes | config readable | full | ddns-scripts | PARTIAL | update untested | test account later |
| Fan | yes | dynamic PWM confirmed | full | fancontrol | PRESERVED | RPM sensor unavailable | clarify unsupported RPM |
| Disk | yes | inventory API works | full | DiskMan | PARTIAL | writes intentionally untested | external USB disk only |
| SMB | yes | service/port up | full | KSMBD | PARTIAL | no share/read-write test | external disk test |
| Logs | yes | Run 20 Higo log page reads normally | rescue | logread/Higo | FUNCTION_TESTED | clear operation intentionally untested | retain read-only evidence |
| Tasks | yes | Run 20 runtime task create/delete passed | rescue | Higo | FUNCTION_TESTED | tested only in initramfs; no residual task found | persistent behavior deferred |
| Terminal | yes | Run 20 Higo terminal returned `uptime` | rescue | Higo | FUNCTION_TESTED | only one safe read-only command tested | retain restricted-command evidence |
| Notifications | yes | Run 20 page displays, but every attempted operation returns `not found` | rescue | Higo | UI_OK / FUNCTION_FAIL | settings routes are missing; wrapper delegation is proved, but no safe atomic UCI primitive/helper contract is yet proved | implementation BLOCKED pending typed storage boundary |
| Firmware upgrade | yes | code present | deferred | sysupgrade | BLOCKED | eMMC safety unverified | do not use |
| Backup/Restore | yes | code present | deferred | sysupgrade/config | BLOCKED | persistent path unverified | design later |
| Watchcat | yes | process running | full | watchcat | PARTIAL | failure recovery untested | fault test later |
| ZeroTier | yes | installed, disabled | full | zerotier | PARTIAL | joining untested | controlled network test |
