# BUILD-02 Current State

- Phase: `BUILD-02`
- State: `COMPLETE`
- External Build: `SUCCESS`
- Branch: `rebuild-v1`
- Project SHA: `698aecdc52218c3565239e97bfd224b6c4af8f02`
- Workflow: `Build H5000M initramfs`
- Run ID: `33836565597`
- Run Number: `20`
- Run Attempt: `1`
- Profile: `rescue`
- Source: `candidate`
- Last Confirmed Gate: Run 20 success artifact accepted; exact source/feed,
  prepare, double apply, defconfig, resolved config, H5000M, Higo,
  RG520/QModem, compile, initramfs, embedded identity, manifest, report,
  checksums, and artifact upload all passed.
- Wait Reason: `NONE`
- Next Action: stop after BUILD-02 review. The next authorized gate is
  `DEVICE-01` RAM validation; it was not executed by BUILD-02.
- Firmware: `immortalwrt-mediatek-filogic-hiveton_h5000m-initramfs-kernel.bin`
- Firmware Size: `19778796` bytes
- Firmware SHA256: `af4f129d68cbb0b2e6d06ed2dbccd64e100bc7403cf69f62b95093d7e86af13e`
- SOURCE_LOCKED: `YES`
- CONFIG_RESOLVED: `YES`
- BUILD_OK: `YES`
- RAM_BOOT_OK: `NO`
- DEVICE_OK: `NO`
- FUNCTION_TESTED: `NO`

Run 19 failure evidence and its repair remain recorded in `CHANGELOG.md`.
The embedded identity matches Run 20, build project SHA `698aecd`, locked
ImmortalWrt SHA `1d34e7b8`, and profile `rescue`. Its optional kernel-version
field is empty and is explicitly recorded as UNKNOWN in the manifest/report;
the source revision and target release identity remain exact. One clean build
does not establish byte-for-byte reproducibility.
