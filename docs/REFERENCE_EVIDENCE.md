# Reference evidence

Historical evidence is read-only input. Current source locks and new build
outputs take precedence according to `AGENTS.md`.

| Location | Type | Use | Evidence | Original | Recovery | Modification |
|---|---|---|---|---|---|---|
| `../work/h5000m-full-latest-analysis-2026-09-03.md` | REFERENCE | Latest RAM full behavior | CONFIRMED device observations | no | REGENERATABLE only by a new test | read-only |
| `../work/h5000m-run13-ab-analysis.md` | REFERENCE | Full #13 comparison | CONFIRMED/PARTIAL device observations | no | REGENERATABLE | read-only |
| `../work/h5000m-run10-baseline.md` | REFERENCE | Minimal Rescue baseline | CONFIRMED device observations | no | REGENERATABLE | read-only |
| `../H5000M-MIGRATION-BLUEPRINT.md` | DERIVED/REFERENCE | Migration planning and Higo matrix source | PARTIAL | no | REGENERATABLE from evidence | read-only |
| `../outputs/h5000m-backup/` | ORIGINAL | Factory partitions and recovery evidence | CONFIRMED origin; contents require item review | yes | IRREPLACEABLE | never modify/delete |
| `../outputs/h5000m-25.12-build-overlay.zip` | DERIVED/REFERENCE | Historical Higo/config overlay | CONFIRMED hash comparison source | no | REGENERATABLE from migrated package | read-only |
| `../work/h5000m-materials/` | DERIVED/REFERENCE | Extracted Higo/QModem runtime material | PARTIAL provenance | no | REGENERATABLE from protected sources | read-only |
| `../work/immortalwrt-25.12/` | LEGACY/TEMP + UPSTREAM | Historical working tree only | CONFIRMED historical state | no | REDOWNLOADABLE | read-only; never active project |

Build reports, manifests and resolved configs are `DERIVED` and
`REGENERATABLE`. A fresh ImmortalWrt clone is `UPSTREAM` and `REDOWNLOADABLE`.
Unknown backup provenance remains `UNKNOWN`; never assume it is disposable.
