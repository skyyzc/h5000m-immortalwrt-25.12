# Run 22 exact-run Rescue RAM validation report

## Identity and scope

- Workflow Run ID / number / attempt: `33987589482` / `22` / `1`.
- Build-input project SHA:
  `ca75cc3d6a9b7ce1907656d585fa1c5b283c030b`.
- ImmortalWrt SHA:
  `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`.
- Profile / source: `rescue` / `candidate`.
- Firmware:
  `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`,
  `19975104` bytes, SHA256
  `bacb594c5fcbfe37e562efc8bef584a635848bc6b7e27bc87f0f8a3e85bb7d4a`.
- The owner loaded this exact image with Recovery WebUI `Load initramfs`.
  No persistent deployment or firmware write was authorized or performed.

## Boot and safety evidence

The runtime reported Hiveton H5000M, ImmortalWrt 25.12-SNAPSHOT, Linux
6.12.103, `rootfs_type=initramfs`, and `/` on `tmpfs`. Embedded
`/etc/h5000m-build.json` matched Run 22, project SHA, ImmortalWrt SHA and
`rescue`. The original eMMC squashfs was mounted read-only. The expected
executable helper and hook were present with their accepted artifact hashes.

## First causal failure

The approved IPv6 route reconciler did not run. Direct runtime evidence was:

- netifd brought logical interface `USBv6` up on device `wwan0_1`;
- `/etc/hotplug.d/iface/95-h5000m-ipv6-shared-prefix` requires
  `INTERFACE=wwan0_1` before dispatching the helper;
- netifd hotplug `INTERFACE` therefore did not satisfy the filter;
- no helper runtime state or helper-tagged log was created;
- the shared global `/64` retained the ordinary `wwan0_1` metric `256` route
  and `br-lan` metric `1024` route; the required owned `br-lan` metric `1`,
  protocol `242` route was absent.

`FIRST_CAUSAL_ERROR=HOTPLUG_LOGICAL_INTERFACE_FILTER_MISMATCH`. This is an
exact runtime dispatch boundary, not an IPv6 carrier, RA, QMAP or client
result. Device-side IPv6 remained reachable, but that does not validate LAN
client forwarding. No reconnect, ifdown, prefix-renewal or two-client testing
was performed after the critical implementation gate failed, avoiding a
polluted lifecycle result.

## Bounded regression and recovery

Before stopping, Higo and LuCI returned HTTP 200; LAN, both AP interfaces,
RG520N-CN USB enumeration, `qmi_wwan_q`, QModem/QMI/QMAP and device-side IPv6
were present. These observations are bounded sanity evidence, not completion
of the required Run 22 regression contract.

After the owner performed a normal physical power cycle, the original
ImmortalWrt 24.10-SNAPSHOT / Linux 6.6.94 returned with
`rootfs_type=squashfs`, read-only `/rom`, the original F2FS overlay, and no
Run 22 build identity. Higo and LuCI returned HTTP 200; LAN, both radios,
RG520N-CN, `wwan0`/`wwan0_1`, QModem/QMI/QMAP and `qmi_wwan_q` were restored.
No evidence indicates eMMC, GPT, U-Boot, BL2, factory or persistent firmware
modification.

## Acceptance result

RUN22_EXACT_ARTIFACT_MATCH: `PASS`

RUN22_RAM_BOOT_OK: `PASS`
RUN22_RUNTIME_IDENTITY_MATCH: `PASS`
RUN22_DEVICE_OK: `FAIL`

RUN22_IPV4_OK: `UNVERIFIED`

RUN22_IPV6_WAN_OK: `PASS`
RUN22_IPV6_PREFIX_OK: `PASS`
RUN22_IPV6_LAN_OK: `UNVERIFIED`
RUN22_DUAL_CLIENT_IPV6_OK: `UNVERIFIED`

RUN22_WWAN01_BRLAN_RETURN_PATH_OK: `UNVERIFIED`
RUN22_ROUTE_OWNERSHIP_OK: `FAIL`
RUN22_PREFIX_LIFECYCLE_OK: `UNVERIFIED`
RUN22_STALE_CLEANUP_OK: `UNVERIFIED`
RUN22_FOREIGN_ROUTE_PRESERVATION_OK: `UNVERIFIED`
RUN22_MODEM_RECONNECT_OK: `UNVERIFIED`
RUN22_IPV6_RECOVERY_AFTER_RECONNECT_OK: `UNVERIFIED`

RUN22_HIGO_REGRESSION_OK: `UNVERIFIED`
RUN22_MODEM_REGRESSION_OK: `UNVERIFIED`
RUN22_NETWORK_REGRESSION_OK: `UNVERIFIED`
RUN22_CORE_RESCUE_REGRESSION_OK: `FAIL`

RUN22_PERSISTENT_RECOVERY_OK: `PASS`
PERSISTENT_STORAGE_MODIFIED: `NO`

RUN22_FUNCTION_TESTED: `FAIL`

No firmware/source/config/package change, Run 23, Full work, stable promotion,
or persistent operation occurred. Any repair requires a new Owner-reviewed
implementation phase. `NEXT_GATE=OWNER_REVIEW_OF_RUN22_FAILURE_REPORT`.
