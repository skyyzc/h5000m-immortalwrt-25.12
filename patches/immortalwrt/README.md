# ImmortalWrt patches

The candidate source lock already contains the H5000M DTS, image definition,
LED defaults, `eth0`/`eth1` mapping, generated Ethernet/Wi-Fi MAC handling and
platform recognition. `scripts/apply.sh` verifies these required elements and
fails if the locked source loses them.

There are no project patches in BUILD-01. Adding a duplicate patch would fail
against the locked source and would not be reproducible.
