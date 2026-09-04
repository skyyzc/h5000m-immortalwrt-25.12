# Higo feature matrix

Evidence: historical latest-full analysis plus the canonical frontend/API
payload. Status is conservative: package presence is not treated as proof that
an authenticated page operation works.

This file remains the Higo feature gap, evidence, and next-step matrix. Package
provenance belongs in `docs/PACKAGES.md`, exact locks in `versions/*.json`, and
build history or repairs in `CHANGELOG.md`.

| Feature | Vendor | Latest Full | Target | Backend | Preserved | Gap / reason | Next step |
|---|---|---|---|---|---|---|---|
| Home | yes | Run 20 authenticated dashboard mostly renders | rescue | Higo API | UI_OK / PARTIAL | device distribution, connected devices and application ranking lack useful data; latter integrations belong to Full | preserve evidence; Full integration test later |
| 5G status | yes | Run 20 network type and signal read successfully | rescue | QModem/Higo | FUNCTION_TESTED / PARTIAL | current configuration shows unrecognized 4G/5G profile; reconnect unproven | diagnose profile mapping after DEVICE-01 evidence review |
| APN | yes | fixed profile works | rescue | QModem/UCI | PARTIAL | editing not tested | form/API test |
| Signal | yes | data confirmed | rescue | QModem/Higo | PRESERVED | none known | regression test |
| SIM | yes | modem registered | rescue | QModem | PARTIAL | controls not tested | SIM UI test |
| SMS | yes | UNKNOWN | rescue | QModem | UNKNOWN | no direct evidence | functional test |
| AT | yes | Run 20 Higo `ATI` returned module identification | rescue | QModem | FUNCTION_TESTED | read-only query passed with no observed QMI/data interruption; mutating AT remains prohibited | retain safe-query evidence; reconnect/race test later |
| Lock band/network | yes | profile bands seeded | rescue | QModem | PARTIAL | mutation untested | controlled test |
| Wi-Fi | yes | Run 20: 2.4/5 GHz real clients passed association, DHCP, Higo and Internet | rescue | UCI/mac80211 | FUNCTION_TESTED | current Rescue defaults are open for isolated RAM validation | security design later; do not alter DEVICE-01 image |
| LAN | yes | 192.168.88.1 works | rescue | netifd | PRESERVED | none known | regression test |
| WAN | yes | eth1 no-link sample | rescue | netifd | UNKNOWN | no cable/link test | link test |
| DHCP | yes | clients observed | rescue | dnsmasq | PRESERVED | none known | regression test |
| IPv6 | yes | Run 20 device-side IPv6 works; LAN client gets RA/default route but external IPv6 times out | rescue | netifd/odhcpd | PARTIAL / CLIENT_FAIL | delegated client data path fails despite address/route; not DNS-only | preserve evidence; diagnose in DEVICE-01 repair scope |
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
| Logs | yes | frontend/API present | rescue | logread/Higo | PARTIAL | page untested | UI test |
| Tasks | yes | frontend/API present | rescue | Higo | UNKNOWN | no operation evidence | UI test |
| Terminal | yes | frontend/API present | rescue | Higo | UNKNOWN | security/function untested | isolated UI test |
| Notifications | yes | frontend/API present | rescue | Higo | UNKNOWN | no evidence | UI test |
| Firmware upgrade | yes | code present | deferred | sysupgrade | BLOCKED | eMMC safety unverified | do not use |
| Backup/Restore | yes | code present | deferred | sysupgrade/config | BLOCKED | persistent path unverified | design later |
| Watchcat | yes | process running | full | watchcat | PARTIAL | failure recovery untested | fault test later |
| ZeroTier | yes | installed, disabled | full | zerotier | PARTIAL | joining untested | controlled network test |
