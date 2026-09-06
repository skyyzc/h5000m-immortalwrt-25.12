# Vendor Compatibility Matrix

Kernel binary modules, firmware blobs, EEPROM/calibration and userspace
contracts are distinct. Linux 6.6.94 `.ko` files must not be reused on 6.12.

| LEGACY_COMPONENT | LEGACY_CAPABILITY | CURRENT_25_12_PATH | MIGRATION_CLASS | EVIDENCE | REMAINING_GAP | PRODUCT_IMPACT |
|---|---|---|---|---|---|---|
| MT7992 vendor kernel stack | dual-band Wi-Fi/vendor radio | maintained ImmortalWrt/mac80211 6.12; no old `.ko` | REPLACED | current dual-band client function | advanced parity | core wireless |
| MT7992 firmware blobs | radio microcode | blobs handled separately from drivers | MIGRATED | current radios run | exact blob map partly UNKNOWN | core wireless |
| EEPROM/calibration | board RF calibration | preserve as data, not module substitute | MIGRATED | working radios | complete provenance/factory audit | RF correctness |
| MediaTek WED | wireless acceleration | maintained native path if selected | DEFERRED | historical only | current config/counters/function | performance |
| HNAT/offload | flow offload | native firewall/kernel integration | DEFERRED | historical only | provenance and IPv6/QMAP tests | performance/Full |
| qmi_wwan_f/q history | RG520 QMI/QMAP | exact qmi_wwan_q lock/in-tree 6.12 build | REPLACED | Run 20/21 data path; Run 22 build | reconnect/exact-run regression | core modem |
| QModem controller | management/dial policy | exact lock plus local profile/redial adaptation | PORTED | current Rescue connectivity | adapters/neighbour/reconnect | modem/Higo |
| legacy OAF kernel/userspace | app recognition/filtering | recover contract; never reuse kernel binary | SUPERSEDED | historical services/data | exact provenance UNKNOWN | Full required |
| current OAF7 | current filter candidate | exact source-built OAF7 plus PROJECT_LOCAL typed UCI/reload shim | PORTED | source lock and compatibility contract | build/kernel API/Higo block proof | Full required |
| fan control | thermal PWM | PROJECT_LOCAL procd/UCI policy through pwm-fan sysfs | PORTED | historical PWM plus auditable source | build/current thermal test; RPM unsupported | hardware safety |
| storage/service coupling | DiskMan/KSMBD/upgrade/backup | current feed packages; external-media first | MIGRATED | exact feed locks and explicit Full selection | build/external-media function; internal writes prohibited | Full/persistence |

Migration classes are defined in the Charter. Exact component locks and
ownership remain in `PACKAGES.md` and version-lock files.
