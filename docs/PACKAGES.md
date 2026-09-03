# Package baseline

Versions below are historical latest-full evidence, not versions verified by a
new rebuild. `UNKNOWN` means an exact upstream source commit was not proven.

## RESCUE

| Display | Package | Historical version | Target | Source / SHA | Profile | Purpose | Validation |
|---|---|---:|---|---|---|---|---|
| HigoROS | higoros | 1.26.04.29.09-r1 | same baseline | local canonical payload / hashes in source lock | rescue/full | Vendor UI and API | CONFIRMED historical |
| LuCI | luci | 26.236.50544~cb5d434 | version UNKNOWN until build metadata | `luci` feed `0b3572a17c1543257642716a4e1bdc9b0e74b8d4` | rescue/full | Admin UI on 8080 | CONFIRMED source lock; version pending build |
| QModem | qmodem | 3.2.0-r1 | 3.2.0-r1 | FUjr/QModem `c1db0fe2067955d6b9c6b43efff1b69259f4b096` | rescue/full | RG520 management | CONFIRMED source; historical first dial |
| QMI userspace | uqmi | UNKNOWN | version UNKNOWN until build metadata | ImmortalWrt core tree `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0` | rescue/full | QMI control | CONFIRMED source lock; historical function |
| Quectel QMI | kmod-qmi_wwan_q | 1.5-r1 | 1.5-r1 | FUjr/QModem `c1db0fe2067955d6b9c6b43efff1b69259f4b096` | rescue/full | RG520 `2c7c:0801` QMAP data path, built for locked kernel | CONFIRMED source; runtime historical |

## FULL

| Display | Package | Historical version | Target | Source / SHA | Profile | Purpose | Validation |
|---|---|---:|---|---|---|---|---|
| Traffic monitor | wrtbwmon | 1.2.1-r3 | baseline | source SHA UNKNOWN | full | Per-client traffic | PARTIAL historical |
| OpenAppFilter | appfilter/kmod-oaf/luci-app-oaf | 7.0.1-r1 | baseline | source SHA UNKNOWN | full | Application filtering | PARTIAL historical |
| Fan control | fancontrol | 2.0-r1 | baseline | source SHA UNKNOWN | full | PWM thermal policy | CONFIRMED historical |
| Disk management | luci-app-diskman | 0.2.13-r1 | baseline | source SHA UNKNOWN | full | External disk UI | PARTIAL historical |
| SMB | ksmbd-server/luci-app-ksmbd | 3.5.6-r1 | baseline | source SHA UNKNOWN | full | File sharing | PARTIAL historical |
| UPnP | miniupnpd/luci-app-upnp | 2.3.9-r1 | baseline | source SHA UNKNOWN | full | Port mapping | UNKNOWN functional |
| DDNS | ddns-scripts/luci-app-ddns | 2.8.3-r5 | baseline | source SHA UNKNOWN | full | Dynamic DNS | UNKNOWN functional |
| Watchcat | watchcat/luci-app-watchcat | 1-r25 | baseline | source SHA UNKNOWN | full | Connectivity recovery | PARTIAL historical |
| ZeroTier | zerotier/luci-app-zerotier | 1.16.0-r2 | baseline | source SHA UNKNOWN | full | Overlay network | UNKNOWN functional |
