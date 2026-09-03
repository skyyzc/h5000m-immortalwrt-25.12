# Higo feature matrix

Evidence: historical latest-full analysis plus the canonical frontend/API
payload. Status is conservative: package presence is not treated as proof that
an authenticated page operation works.

| Feature | Vendor | Latest Full | Target | Backend | Preserved | Gap / reason | Next step |
|---|---|---|---|---|---|---|---|
| Home | yes | status data present | rescue | Higo API | PRESERVED | authenticated UI not retested | RAM UI test |
| 5G status | yes | registration/signal/CA data | rescue | QModem/Higo | PRESERVED | reconnect unproven | reconnect test |
| APN | yes | fixed profile works | rescue | QModem/UCI | PARTIAL | editing not tested | form/API test |
| Signal | yes | data confirmed | rescue | QModem/Higo | PRESERVED | none known | regression test |
| SIM | yes | modem registered | rescue | QModem | PARTIAL | controls not tested | SIM UI test |
| SMS | yes | UNKNOWN | rescue | QModem | UNKNOWN | no direct evidence | functional test |
| AT | yes | ttyUSB3 confirmed | rescue | QModem | PARTIAL | UI execution untested | safe AT test |
| Lock band/network | yes | profile bands seeded | rescue | QModem | PARTIAL | mutation untested | controlled test |
| Wi-Fi | yes | 2.4/5 GHz up | rescue | UCI/mac80211 | PRESERVED | historical open encryption | secured config test |
| LAN | yes | 192.168.88.1 works | rescue | netifd | PRESERVED | none known | regression test |
| WAN | yes | eth1 no-link sample | rescue | netifd | UNKNOWN | no cable/link test | link test |
| DHCP | yes | clients observed | rescue | dnsmasq | PRESERVED | none known | regression test |
| IPv6 | yes | QMI /64 and LAN PD | rescue | netifd/odhcpd | PRESERVED | prefix-change untested | long-run test |
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
