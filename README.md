# H5000M Firmware

Source-locked firmware project for the Hiveton H5000M: MT7987A, about 1 GiB
RAM, about 8 GiB eMMC, two 2.5 GbE ports, MT7992 Wi-Fi and an RG520N-CN
modem (`2c7c:0801`). The software target is ImmortalWrt 25.12 with the
vendor Higo interface retained and LuCI available alongside it.

- Higo: `http://192.168.88.1/` (port 80)
- LuCI: `http://192.168.88.1:8080/`

## Design

ImmortalWrt 25.12 upstream -> H5000M hardware adaptation -> permanent Higo
compatibility -> LuCI coexistence -> RG520N-CN -> optional integrations ->
Rescue RAM validation -> Full -> manual stable promotion -> persistent/eMMC
only after recovery and rollback are proven.

This is the permanent project mainline; individual build or validation phases
must not replace or shorten it.

The locked ImmortalWrt source contains the board DTS, image definition, LED,
Ethernet and generated MAC handling. This repository owns the source locks,
profiles, Higo package and compatibility defaults. It never stores a complete
ImmortalWrt or U-Boot tree.

## Profiles

- `rescue`: initramfs recovery baseline with SSH, Higo, LuCI, LAN, dual-band
  Wi-Fi, IPv4/IPv6, USB serial, QMI/uqmi and the RG520/QModem foundation.
- `full`: rescue plus wrtbwmon, OpenAppFilter, fan control, DiskMan, KSMBD,
  UPnP, DDNS, Watchcat and ZeroTier.

The release flow is `candidate -> build -> RAM test -> manual promote -> stable`.
`versions/stable.json` currently describes historical validation only; no build
from this repository has been promoted.

The candidate has passed source reconstruction, config resolution, and one
Linux clean Rescue build. This is not evidence of byte-for-byte reproducibility,
which remains unverified.

## Build interface

```sh
./scripts/build.sh rescue candidate
./scripts/build.sh full candidate
```

BUILD-01 intentionally did not run these commands. Candidate ImmortalWrt,
standard feeds, QModem and `qmi_wwan_q` sources are locked. `prepare.sh`
refuses any lock with unknown Rescue feed or QModem commits.

The current safe development path is RAM initramfs. eMMC installation and
sysupgrade are not established as safe. Do not write eMMC, GPT or U-Boot based
on this project. Device-unique identifiers and credentials must never be added.
