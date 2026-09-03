# H5000M current project state

- **Project:** H5000M ImmortalWrt 25.12 with Higo compatibility
- **Device:** Hiveton H5000M / MediaTek MT7987A / Quectel RG520N-CN
- **Target OS:** ImmortalWrt 25.12
- **Current branch:** `master`
- **Current project commit:** `HEAD`; Phase 1 base `2898f03021187cddc9ed7ae4ccb2cffa255f6345`
- **ImmortalWrt branch/SHA:** project build branch `openwrt-25.12` / `cfd4f9545c7c893525b23ab3577252d5b9902399`
- **Kernel:** source line 6.12; last tested artifact Linux 6.12.103
- **Current rescue status:** `FUNCTION_TESTED` on Actions #10 RAM artifact; later unified-profile artifact status `UNKNOWN`
- **Current full status:** latest RAM artifact is `FUNCTION_TESTED` only for validated items below; exact Actions run/artifact `UNKNOWN`
- **QModem version/SHA:** 3.2.0-r1 / `c1db0fe2067955d6b9c6b43efff1b69259f4b096` (`CONFIGURED`; version also `RUNNING` on tested full RAM image)
- **OAF version/SHA:** 7.0.1-r1 / `UNKNOWN`; source follows upstream (`RUNNING`, blocking unverified)
- **wrtbwmon version/SHA:** 1.2.1-r3 / `UNKNOWN`; source follows upstream (`RUNNING`, Higo integration incomplete)
- **Current validated hardware:** MT7987A, about 988 MiB RAM, 7.28 GiB eMMC, eth0 LAN, eth1 WAN, MT7992 dual-band Wi-Fi, RG520N-CN USB `2c7c:0801` with QMAP `wwan0_1`, PWM fan
- **Current partially validated functions:** Higo `:80`, LuCI `:8080`, LAN/WAN, dual-band Wi-Fi, QModem first dial, IPv4/IPv6, fan PWM, OAF runtime, wrtbwmon data, KSMBD/DiskMan/UPnP/DDNS/Watchcat/ZeroTier presence
- **Current unverified functions:** long 5G reconnect, OAF blocking/Higo UI, Higo device-list conversion, external-disk operations, SMB, UPnP, DDNS, ZeroTier, fan RPM/high-load curve, backup/restore, persistent upgrade/rollback
- **Current known blockers:** Higo device API does not consume current wrtbwmon data; Higo expects older OAF controls; QModem scanner remains partially compatible; OAF/wrtbwmon and feeds are not fully pinned; persistent eMMC path is unvalidated
- **Reference evidence governance:** Phase 1.1A asset map + Phase 1.1B `PASS WITH CONDITIONS` access validation are codified in `REFERENCE_EVIDENCE.md`; `h5000m-project` remains the only daily Source Folder
- **Git worktree protection:** `immortalwrt-25.12` is the protected Git common-dir host for this worktree and must not be treated as a disposable upstream cache
- **Recovery readiness:** `NOT VERIFIED`; recovery evidence is incomplete, and p1-p4 backups do not establish `FULL RECOVERY READY`
- **Recovery evidence gaps:** complete vendor firmware, p5/rootfs image, raw overlay image, raw boot/dmesg/device-topology/modem/thermal records, complete block/GPT capture, device-origin calibration evidence, and full eMMC/GPT-sector backup remain `UNKNOWN` or `PARTIAL/UNKNOWN`
- **Phase 1:** `COMPLETE`
- **Phase 1.1:** `COMPLETE`
- **Current Task:** Phase 1.1D recovery readiness snapshot completed; Phase 1 / 1.1 governance baseline sealed
- **Next Engineering Phase:** Phase 2 - Reproducible Build Baseline; permitted to begin only by explicit request and not started by Phase 1.1D
- **Next Tasks:** P0 pin/reproduce inputs, P1 candidate-build-RAM-test promotion record, and P1 Higo device/OAF compatibility; hardware/persistent writes remain separately approved phases
- **Last Tested Artifact:** latest `full` initramfs RAM image; exact filename and Actions run `UNKNOWN`
- **Last Actions Run:** #16 / run identity `UNKNOWN`; former “building” text was stale and is not treated as success
- **Last Updated:** 2026-09-03

## Recovery Readiness Snapshot

- **RECOVERY READINESS:** `NOT VERIFIED`
- **PERSISTENT WRITE GATE:** `CLOSED`
- Existing recovery assets are evidence inputs, not proof of a complete or rehearsed recovery path.
- RAM initramfs development does not establish persistent-write readiness. Build success does not establish recovery readiness. RAM boot success does not establish safe sysupgrade.

### Confirmed recovery assets

**AVAILABLE + INTEGRITY VERIFIED**

- AM-019 p4 kernel partition backup, AM-020 running kernel config backup, AM-021 selected migration-material archive, AM-022 p1 U-Boot environment backup, AM-023 p2 factory snapshot, AM-024 p3 FIP backup, and AM-025 running FDT capture are original device evidence covered by AM-026 `SHA256SUMS`; Phase 1.1A recorded successful integrity verification.
- AM-026 is the preserved integrity anchor for the collected backup set.
- AM-027 original package inventory, AM-028 original board/release metadata, AM-029 original kernel command line, and AM-030 backup-collection warning log are preserved members of the verified backup set.

**AVAILABLE / PARTIAL**

- p1-p4 partition snapshots cover only part of eMMC; p5/rootfs and GPT sectors are absent.
- AM-021 contains selected migration material, not a complete rootfs or raw overlay image.
- AM-023 is a confirmed all-zero snapshot, but separate device-origin calibration/EEPROM evidence is not established.
- AM-002 provides a pinned U-Boot source reference, but no raw console capture or verified end-to-end recovery procedure.
- Derived FIT/DTB reports and RAM-test analyses are available, but do not replace original raw evidence.

**MISSING / UNKNOWN**

- The evidence and capabilities listed as `UNKNOWN` or `PARTIAL/UNKNOWN` in the matrix below remain unavailable or incomplete. Their possible future acquisition is not counted as current availability.

### Recovery Gap Matrix

| Evidence / Capability | Current Status | Required Before | Blocking What | Acquisition Mode | Risk |
| --- | --- | --- | --- | --- | --- |
| Complete vendor firmware | `UNKNOWN` | Factory-image restoration claim | Verified full factory restore | Locate and authenticate vendor distribution without overwriting evidence | HIGH |
| p5/rootfs backup | `UNKNOWN` | Persistent-write/recovery planning | Byte-for-byte rootfs restoration | Future approved read-only device acquisition | CRITICAL |
| Raw overlay image | `UNKNOWN` | Exact runtime-overlay restoration | Byte-for-byte overlay recovery | Future approved read-only device acquisition | HIGH |
| GPT/block evidence | `PARTIAL/UNKNOWN` | DTS/partition/GPT/sysupgrade work | Confirmed partition mapping | Fresh read-only `lsblk`/`blkid`/`fdisk`/`sgdisk` evidence | CRITICAL |
| GPT primary/backup sector evidence | `UNKNOWN` | Any GPT modification or persistent flashing | GPT repair and rollback | Future approved sector reads with checksums | CRITICAL |
| Full eMMC image / verified minimum recovery set | `UNKNOWN` | Persistent flashing approval | Complete executable recovery plan | Approved imaging or independently verified minimum set | CRITICAL |
| U-Boot `printenv` | `UNKNOWN` | U-Boot/boot-chain modification | Confirmed boot variables and fallback | Future non-destructive console capture | CRITICAL |
| Raw boot console | `UNKNOWN` | Boot-chain/U-Boot/recovery work | Verified boot and failure-recovery sequence | Future non-destructive serial capture | CRITICAL |
| Raw dmesg | `UNKNOWN` | Deep kernel/device-path changes | Recheckable boot/runtime diagnostics | Future timestamped read-only capture | HIGH |
| USB topology / tty | `UNKNOWN` | Deep RG520N/QModem driver or port-layout work | Confirmed modem enumeration path | Future timestamped `lsusb`/topology/tty capture | HIGH |
| RG520N identity | `UNKNOWN` | Deep modem/recovery changes | Confirmed module/firmware identity | Future read-only modem identity capture | HIGH |
| QMI/MBIM/AT raw evidence | `UNKNOWN` | Deep dial/reconnect/recovery changes | Reproducible modem control baseline | Future timestamped raw command transcript | HIGH |
| Thermal/hwmon/fan evidence | `UNKNOWN` | Final fan/thermal tuning | Verified RPM and load curve | Future read-only telemetry capture | MEDIUM |
| Device-origin calibration/EEPROM evidence | `UNKNOWN` | Calibration/MAC or factory-partition decisions | Confirmed device-specific calibration recovery | Future read-only provenance validation | CRITICAL |
| DiskMan/KSMBD functional evidence | `UNKNOWN` | Final storage/SMB validation | End-to-end storage/share claim | Controlled test on expendable external storage | MEDIUM |
| Backup restore rehearsal | `UNKNOWN` | Declaring a usable recovery path | Demonstrated restore capability | Separately approved, documented rehearsal | CRITICAL |
| Persistent-write rollback procedure | `UNKNOWN` | Opening Persistent Write Gate | sysupgrade/flashing approval | Document, independently verify, and rehearse recovery/rollback | CRITICAL |

### Future Acquisition Gates

- **RG520N/QModem deep modification:** first acquire fresh modem identity, USB topology, tty, QMI/MBIM, and AT raw evidence.
- **Final fan/thermal tuning:** first acquire raw thermal, hwmon, fan PWM/RPM, and load telemetry.
- **Final DiskMan/KSMBD validation:** first record a non-destructive end-to-end test using expendable external storage.
- **DTS/partition/GPT/U-Boot/sysupgrade/persistent flashing/recovery:** first reacquire and verify block/GPT and partition mapping, p5/rootfs, boot console, U-Boot environment, and executable rollback/recovery evidence. Apply the `AGENTS.md` independent double-evidence rule; a single source cannot become `CONFIRMED`.
- Acquisition is deferred until its scoped task. Phase 1.1D does not require or authorize collecting all missing evidence now.

### Work permitted while gates remain closed

- Governance and reproducible-build work, GitHub Actions, rescue/full initramfs builds, and RAM boot testing.
- Higo compatibility, non-persistent QModem/RG520N development, OAF/wrtbwmon work, fan read-only/RAM validation, and non-destructive storage validation.
- Each task still requires its own evidence gate. None of these permissions opens the Persistent Write Gate.
