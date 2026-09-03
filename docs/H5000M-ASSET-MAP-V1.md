# H5000M asset map V1

| Asset | Canonical/current location | Historical source | Role | Evidence | Recovery | Policy |
|---|---|---|---|---|---|---|
| Higo package | `package/hiveton/higoros/` | `../work/h5000m-materials`, overlay ZIP, overlay-inspect | Vendor UI/backend plus compatibility defaults | CONFIRMED matching hashes | repository | editable only by scoped task |
| H5000M hardware port | locked ImmortalWrt candidate | historical ImmortalWrt tree | DTS, image, LED, network, MAC handling | CONFIRMED source | REDOWNLOADABLE | do not duplicate as patch |
| Rescue profile | `configs/rescue.config` | historical initramfs config and device tests | minimal recovery target | CONFIGURED | repository | preserve core gates |
| Full profile | `configs/full.config` | latest-full evidence | optional feature target | UNVERIFIED in this project | repository | outside BUILD-02 |
| Source locks | `versions/*.json` | Git metadata and remote verification | machine-readable source truth | CONFIRMED/PARTIAL per field | repository | exact SHA only |
| Factory backups | `../outputs/h5000m-backup/` | device extraction | recovery evidence | ORIGINAL | IRREPLACEABLE | never modify/delete |
| Build outputs | GitHub Actions artifacts | fresh locked build | firmware and traceability | UNVERIFIED until generated | REGENERATABLE | identify by SHA/run |
