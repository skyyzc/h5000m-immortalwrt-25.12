# H5000M migration blueprint

This is the durable in-repository summary; the historical detailed blueprint is
`$WORKSPACE_ROOT/H5000M-MIGRATION-BLUEPRINT.md` and remains read-only evidence;
`WORKSPACE_ROOT` is the parent workspace, not this repository.

## Architecture

Locked official ImmortalWrt 25.12 source provides the native H5000M hardware
port. This project applies the canonical Higo package and device defaults, then
selects either Rescue or Full configuration. It does not vendor a full upstream
tree or a prebuilt kernel module.

## Rescue invariants

Rescue retains H5000M target/initramfs, SSH, Higo :80, LuCI :8080, LAN,
firewall, IPv4/IPv6, dual-band Wi-Fi, USB serial/cdc-wdm, uqmi,
`qmi_wwan_q`, QModem and the fixed RG520N-CN profile. QModem source and the
Quectel driver are built from the exact candidate commit.

## Evidence boundary

Historical RAM success guides compatibility but does not prove a new build.
Build success reaches `BUILT` only. BOOT, RUNNING, UI_OK and FUNCTION_TESTED
require later device evidence. Persistent installation remains unsafe until an
explicitly authorized task establishes it.
