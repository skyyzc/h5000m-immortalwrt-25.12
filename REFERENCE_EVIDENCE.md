# H5000M Reference Evidence Governance

This file records where reference/evidence assets are, where they came from, and when they may be read. It does not replace `README.md`, `PROJECT_STATE.md`, `CHANGELOG.md`, or the Phase 1.1A asset map.

## Status vocabulary

- **Classification:** `ACTIVE`, `EVIDENCE`, `RECOVERY`, `DERIVED`, `UPSTREAM`, or `LEGACY/TEMP`. Secondary roles are shown after `/`.
- **Evidence Level:** `ORIGINAL` means captured from the device/vendor source; `DERIVED` means transformed or reported from another source; `REFERENCE` is useful context but not original evidence; `GOVERNANCE` controls the project rather than proving device behavior.
- **Validation Status:** `CONFIRMED`, `INFERRED`, or `UNKNOWN`, exactly preserving Phase 1.1A conclusions. These are asset/provenance statuses, not functional validation levels.
- **Reproducibility:** `IRREPLACEABLE`, `REGENERATABLE`, `REDOWNLOADABLE`, or `UNKNOWN`. A qualified value retains the stated condition.

## Default access policy

- **ACTIVE:** read `AGENTS.md` and `PROJECT_STATE.md` first, then only Current Task files.
- **EVIDENCE:** read by exact path only when the Current Task concerns the evidenced function.
- **DERIVED:** use only as an analysis aid. Do not substitute it for available original evidence without justification.
- **RECOVERY:** read only for approved recovery, persistent-write, partition, or boot-chain work; read the integrity manifest before trusting backup files.
- **UPSTREAM:** read only for scoped build, source, kernel, plugin, or U-Boot work.
- **LEGACY/TEMP:** no routine access. Preserve unresolved-provenance items; cleanup requires explicit approval.
- Do not recursively scan large EVIDENCE, RECOVERY, DERIVED, or UPSTREAM trees by default. “Not read by default” does not mean “may not be used.”

## Asset register

| Asset ID | Name | Exact Path | Classification | Evidence Level | Provenance | Reproducibility | Required For | Default Access Policy | Protection Level | Validation Status | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AM-001 | Canonical H5000M project | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-project` | ACTIVE/GOVERNANCE | GOVERNANCE | GitHub `skyyzc/h5000m-immortalwrt-25.12`; `master` clean at Phase 1.1A inspection | REDOWNLOADABLE except unpushed work | All active development | Governance entry points, then task files | PROTECTED | CONFIRMED | Canonical daily Source Folder |
| AM-002 | U-Boot upstream/reference | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\bl-mt798x-dhcpd` | UPSTREAM/RECOVERY | REFERENCE | `Yuzhii0718/bl-mt798x-dhcpd` at `384fdd8a743506a9c3ea73289d419f9d6519d61f` | REDOWNLOADABLE | U-Boot/RAM boot/recovery | On demand only | PROTECTED | CONFIRMED | Large tree; isolated from routine context |
| AM-003 | ImmortalWrt local reference tree and Git common-dir host | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\immortalwrt-25.12` | UPSTREAM/LEGACY | REFERENCE | ImmortalWrt origin; Phase 1.1A HEAD `1d34e7b88708d4eeb3feabe0b2b6f835a909c9c0`; hosts the shared Git repository/worktree metadata for AM-001 | Base REDOWNLOADABLE; dirty additions UNKNOWN | Upstream comparison and AM-001 Git worktree integrity | On demand only | GIT COMMON-DIR HOST; PROTECTED | CONFIRMED | Dirty/untracked content exists; never treat as disposable cache |
| AM-004 | Original migration-material extraction | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-materials` | EVIDENCE/DERIVED | DERIVED | Extracted from AM-021; archive listing and three representative hashes checked | REGENERATABLE from AM-021 | Higo/vendor/plugin/config comparison | Narrow paths only | PROTECTED | CONFIRMED | Do not routinely scan Higo assets/modules |
| AM-005 | Vendor compatibility prototype | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-vendor-compat` | DERIVED/LEGACY | DERIVED | Exact originating task/input not encoded | UNKNOWN | OAF/Higo compatibility history | On demand only | PRESERVE | INFERRED | Not active implementation |
| AM-006 | Overlay inspection copy | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\overlay-inspect` | DERIVED/LEGACY | DERIVED | Likely extracted build overlay; exact source archive not proven | UNKNOWN | Higo packaging/history | On demand only | PRESERVE | INFERRED | Large Higo data remains isolated |
| AM-007 | Empty QModem source placeholder | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\QModem-src` | LEGACY/TEMP | REFERENCE | Empty at inspection | REDOWNLOADABLE | None currently | No access | APPROVAL REQUIRED FOR CLEANUP | CONFIRMED | Cleanup candidate only |
| AM-008 | Extracted FIT components | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-fit` | DERIVED/EVIDENCE | DERIVED | AM-013 parsed by AM-016; exact extraction not rerun | REGENERATABLE from AM-013 + AM-016 | Kernel/DTB comparison | On demand | PRESERVE | INFERRED | Do not promote extraction relationship to confirmed |
| AM-009 | DTB report | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-dtb-report.txt` | DERIVED/EVIDENCE | DERIVED | AM-008 `fdt-1.bin` parsed by AM-016; exact report comparison passed | REGENERATABLE | DTS/hardware mapping | On demand | PRESERVE | CONFIRMED | Report is not original evidence |
| AM-010 | FIT report | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-fit-report.txt` | DERIVED/EVIDENCE | DERIVED | AM-013 parsed by AM-016; exact report comparison passed | REGENERATABLE | Kernel/FIT/recovery analysis | On demand | PRESERVE | CONFIRMED | Identifies vendor Linux 6.6.94 and H5000M DTB |
| AM-011 | Latest full RAM analysis | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-full-latest-analysis-2026-09-03.md` | EVIDENCE/DERIVED | DERIVED | Prior SSH observations; raw session log not found | UNKNOWN | Full regression/Phase 2 planning | On demand | PRESERVE | CONFIRMED | Do not present as raw capture |
| AM-012 | Decompressed vendor kernel config | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-kernel.config` | DERIVED/EVIDENCE | DERIVED | Exact decompression of AM-020; SHA-256 match confirmed | REGENERATABLE | Kernel/module compatibility | On demand | PRESERVE | CONFIRMED | Vendor Linux 6.6.94 configuration |
| AM-013 | Decompressed device kernel partition/FIT | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-kernel.img` | DERIVED/EVIDENCE | DERIVED | Exact decompression of AM-019; SHA-256 match confirmed | REGENERATABLE | FIT/DTB/kernel/recovery analysis | On demand | PRESERVE | CONFIRMED | Not a complete factory firmware |
| AM-014 | Phase 1 project baseline | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\H5000M-PROJECT-BASELINE-V1.md` | DERIVED/GOVERNANCE | DERIVED | Prior Phase 1 audit | REGENERATABLE with substantial re-analysis | Historical lookup | Rare, on demand | PRESERVE | CONFIRMED | Not daily context |
| AM-015 | Remediation table V1 | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\H5000M-REMEDIATION-TABLE-V1.md` | DERIVED/GOVERNANCE | DERIVED | Prior Phase 1 audit | REGENERATABLE with substantial re-analysis | Phase planning/history | Rare, on demand | PRESERVE | CONFIRMED | Not daily context |
| AM-016 | FIT/DTB parser | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\parse_fit.py` | DERIVED/ACTIVE | REFERENCE | Locally authored; exact earlier authoring context not encoded | REGENERATABLE | FIT/DTB analysis | On demand | PRESERVE | CONFIRMED | Reproduces AM-009 and AM-010 reports |
| AM-017 | Actions #10 RAM baseline | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-run10-baseline.md` | EVIDENCE/DERIVED | DERIVED | SSH/device observations; raw log absent | UNKNOWN | Rescue regression baseline | On demand | PRESERVE | CONFIRMED | Not raw evidence |
| AM-018 | Actions #13 A/B analysis | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\h5000m-run13-ab-analysis.md` | EVIDENCE/DERIVED | DERIVED | SSH/device observations; raw log absent | UNKNOWN | Full regression baseline | On demand | PRESERVE | CONFIRMED | Not raw evidence |
| AM-019 | Device p4 kernel backup | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\mmcblk0p4-kernel.img.gz` | RECOVERY/EVIDENCE | ORIGINAL | This H5000M eMMC p4; AM-026 covers checksum | IRREPLACEABLE | Recovery/FIT/kernel/sysupgrade research | Approved high-risk/recovery tasks | IRREPLACEABLE | CONFIRMED | Expands exactly to AM-013 |
| AM-020 | Device kernel config backup | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\kernel-config.gz` | RECOVERY/EVIDENCE | ORIGINAL | Collected from original device OS; AM-026 covers checksum | IRREPLACEABLE | Kernel/module migration | On demand | IRREPLACEABLE | CONFIRMED | Expands exactly to AM-012 |
| AM-021 | Migration materials archive | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\migration-materials.tar.gz` | RECOVERY/EVIDENCE | ORIGINAL | Collected from original device OS; AM-026 covers checksum | IRREPLACEABLE | Higo/vendor/plugin/config recovery | Narrow archive access on demand | IRREPLACEABLE; HIGHEST PRIORITY | CONFIRMED | Selected material, not complete rootfs; source of AM-004 |
| AM-022 | Device p1 U-Boot environment backup | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\mmcblk0p1-uboot-env.img.gz` | RECOVERY/EVIDENCE | ORIGINAL | This H5000M eMMC p1; AM-026 covers checksum | IRREPLACEABLE | Boot recovery/U-Boot/write preparation | Approved recovery tasks only | IRREPLACEABLE; HIGHEST PRIORITY | CONFIRMED | Never write automatically |
| AM-023 | Device p2 factory backup | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\mmcblk0p2-factory.img.gz` | RECOVERY/EVIDENCE | ORIGINAL | This H5000M eMMC p2; AM-026 covers checksum | IRREPLACEABLE | Calibration/MAC/recovery investigation | Approved hardware/recovery tasks only | IRREPLACEABLE; HIGHEST PRIORITY | CONFIRMED | All-zero snapshot remains device evidence |
| AM-024 | Device p3 FIP backup | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\mmcblk0p3-fip.img.gz` | RECOVERY/EVIDENCE | ORIGINAL | This H5000M eMMC p3; AM-026 covers checksum | IRREPLACEABLE | Bootloader recovery/write preparation | Approved recovery tasks only | IRREPLACEABLE; HIGHEST PRIORITY | CONFIRMED | Never write automatically |
| AM-025 | Running FDT capture | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\running-fdt.dtb` | EVIDENCE/RECOVERY | ORIGINAL | Captured from original running system; AM-026 covers checksum | IRREPLACEABLE | DTS validation/hardware mapping | On demand only | IRREPLACEABLE | CONFIRMED | Distinct from AM-008 unless later proven identical |
| AM-026 | Backup integrity manifest | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\SHA256SUMS` | RECOVERY/GOVERNANCE | ORIGINAL | Generated during backup collection; hashes matched in Phase 1.1A | REGENERATABLE only while originals remain intact | Any recovery/evidence use | Read before backup use | HIGHEST PRIORITY; PRESERVE WITH BACKUPS | CONFIRMED | Integrity anchor |
| AM-027 | Original package inventory | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\installed-packages.txt` | EVIDENCE/RECOVERY | ORIGINAL | Original device package manager | IRREPLACEABLE | Plugin parity/Higo dependencies | On demand | IRREPLACEABLE | CONFIRMED | Exact historical snapshot |
| AM-028 | Original board/release metadata | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\system-board.json` | EVIDENCE/RECOVERY | ORIGINAL | Collected from original device | IRREPLACEABLE | Device/source baseline | On demand | IRREPLACEABLE | CONFIRMED | Original firmware identity |
| AM-029 | Original kernel command line | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\cmdline.txt` | EVIDENCE/RECOVERY | ORIGINAL | Collected from original device | IRREPLACEABLE | Boot/recovery/sysupgrade preparation | On demand | IRREPLACEABLE | CONFIRMED | Boot parameters snapshot |
| AM-030 | Backup tar warnings | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\outputs\h5000m-backup\tar-warnings.txt` | EVIDENCE/GOVERNANCE | ORIGINAL | Generated during backup collection | REGENERATABLE only by repeating collection | Backup integrity interpretation | Rare | PRESERVE WITH ARCHIVE | CONFIRMED | Path-normalization warnings only |
| AM-031 | Current workflow duplicate | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\workflow-h5000m-redial.yml` | LEGACY/TEMP/DERIVED | DERIVED | SHA-256 equals active workflow | REGENERATABLE from ACTIVE | Workflow history only | No routine access | APPROVAL REQUIRED FOR CLEANUP | CONFIRMED | Duplicate cleanup candidate |
| AM-032 | Earlier next-workflow draft | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\workflow-h5000m-next.yml` | LEGACY/DERIVED | DERIVED | Prior task output; exact parent/transition not encoded | UNKNOWN | Workflow regression/history | On demand only | PRESERVE | INFERRED | Not active |
| AM-033 | Old overlay workflow | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\overlay-inspect\build-h5000m-initramfs.yml` | LEGACY/DERIVED | DERIVED | Part of AM-006; exact source unknown | UNKNOWN | Early build history | Rare | PRESERVE | INFERRED | Not active |
| AM-034 | SSH askpass helper | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\ssh-askpass.cmd` | LEGACY/TEMP/EVIDENCE | REFERENCE | Prior live-device testing | REGENERATABLE | None; avoid future use | Do not read routinely | SENSITIVE; APPROVAL REQUIRED FOR CLEANUP | CONFIRMED | Potential plaintext credential material; content was not read |
| AM-035 | Asset map V1 | `C:\Users\skyyz\Documents\Codex\2026-09-01\w\work\H5000M-ASSET-MAP-V1.md` | DERIVED/GOVERNANCE | DERIVED | Phase 1.1A read-only mapping | REGENERATABLE with another mapping pass | Asset lookup/governance | Asset-related tasks only | PRESERVE | CONFIRMED | External read-only reference |

## Evidence precedence and conflict handling

When project facts conflict, use this order:

1. Current-device original evidence.
2. Verified original backups.
3. Original-firmware extracts.
4. Traceable DERIVED analysis.
5. `PROJECT_STATE.md` / `README.md`.
6. Historical chat / model memory.

If high-confidence sources conflict, do not choose automatically. Mark the fact `CONFLICT / UNKNOWN`, stop relying on it for high-risk work, and obtain further evidence.

## Provenance rules

- Critical derived assets should trace `SOURCE -> EXTRACTED -> DERIVED`.
- If the chain cannot be established, mark provenance `UNKNOWN`.
- Never describe a derived report, extracted copy, or analysis as original evidence.
- Confirmed chains include AM-019 -> AM-013 -> AM-010; AM-020 -> AM-012; and AM-021 -> AM-004. AM-013 -> AM-008 remains `INFERRED`.

## Recoverability rules

- **IRREPLACEABLE:** never delete, overwrite, modify, or automatically organize.
- **REGENERATABLE:** before deletion, confirm both original inputs and the generation method still exist.
- **REDOWNLOADABLE:** requires a traceable URL/repository plus version, tag, or SHA.
- **UNKNOWN:** preserve until provenance and recovery are resolved.

## Git worktree protection

Phase 1.1B confirmed that AM-001 and AM-003 share Git repository/worktree management. AM-001 `.git` points to:

`C:/Users/skyyz/Documents/Codex/2026-09-01/w/work/immortalwrt-25.12/.git/worktrees/h5000m-project`

Therefore AM-003 is a **GIT COMMON-DIR HOST / PROTECTED** asset. Without specific approval and a migration plan, do not move, delete, recreate, reclone over, `reset --hard`, clean, modify `.git/worktrees`, or perform any Git management operation that could break AM-001. It is not a disposable upstream cache.

## High-risk double-evidence gate

Before changing or writing DTS/DTB, MTD, GPT, partitions, U-Boot, bootloader, sysupgrade, persistent flashing, backup/restore, or the recovery chain:

1. Re-read the applicable current-device/original evidence.
2. Require in principle two independent evidence sources for critical hardware, partition, and boot-chain conclusions, such as MTD/block + DTB/DTS or GPT + boot log/bootloader evidence.
3. With only one source, do not promote the conclusion to `CONFIRMED`.
4. If two high-confidence sources conflict, mark `CONFLICT / UNKNOWN` and stop the high-risk operation.

## Source Folder policy

Phase 1.1B returned `PASS WITH CONDITIONS`: the current Codex Project can access ACTIVE, EVIDENCE, DERIVED, RECOVERY, and UPSTREAM assets on demand, so no additional Source Folder is needed. Keep AM-001 as the only daily Source Folder and access external assets by exact path.

Do not add these as daily Source Folders unless the Codex access model changes and is revalidated: `immortalwrt-25.12`, `bl-mt798x-dhcpd`, `h5000m-materials`, `overlay-inspect`, `outputs\h5000m-backup`, large Higo static assets, `build_dir`, `staging_dir`, `tmp`, `dl`, `bin`, caches, or logs.

## Recovery gaps retained from Phase 1.1A

Recovery evidence is incomplete and must not be called `FULL RECOVERY READY`. The following remain `UNKNOWN`, `PARTIAL/UNKNOWN`, or otherwise unverified:

- Complete vendor firmware distribution image: `UNKNOWN`.
- Complete p5/rootfs partition image: `UNKNOWN`.
- Raw overlay partition/image: `UNKNOWN`.
- Raw boot/U-Boot console log: `UNKNOWN`.
- Raw kernel log/dmesg: `UNKNOWN`.
- Raw USB topology/tty, modem identity, QMI/MBIM, and AT evidence: `UNKNOWN`.
- Raw thermal/hwmon/fan telemetry: `UNKNOWN`.
- Raw block/GPT/mount/fstab capture: `PARTIAL/UNKNOWN`.
- USB-storage/DiskMan/KSMBD transcript: `UNKNOWN`.
- Separate device-origin calibration/EEPROM evidence: `UNKNOWN`.
- Full eMMC image and partition-table sector backup: `UNKNOWN`.

Existing p1-p4 backups are valuable original evidence but do not establish complete factory restoration or a verified persistent-write rollback path.
