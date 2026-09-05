# DEVICE-01R Root-Cause and Feature-Gap Audit

Date: 2026-09-05  
Branch / analysis HEAD: `rebuild-v1` / `9eb92abd0dd0864a67eae086487fd3e7c8b79c1b`

## Scope and decision

This is an analysis record, not a firmware change. Run 20 Rescue remains
`PASS_WITH_KNOWN_ISSUES`; its accepted boot, identity, LAN, DHCP, SSH,
dual-band Wi-Fi, Higo/LuCI coexistence, RG520/QMI/QMAP, IPv4, stability and
power-cycle evidence remains valid. `DEVICE_OK=YES` means only that the Rescue
core contract passed. It does not mean that every product feature passed.

The permanent mainline remains ImmortalWrt 25.12 upstream -> H5000M hardware
adaptation -> permanent Higo compatibility and LuCI coexistence -> RG520N-CN ->
hardware management -> accepted integrations -> Rescue RAM validation -> Full
-> Full RAM validation -> candidate -> manual stable promotion -> persistent
deployment only after recovery and rollback are proved.

## Rescue and Full contract

- `CORE_RESCUE`: boot and embedded identity; H5000M identity; LAN, DHCP and
  SSH; Higo core and LuCI coexistence; both Wi-Fi bands; RG520 USB, QMI/QMAP and
  IPv4; essential IPv6; RAM-only isolation and power-cycle recovery.
- `FULL_REQUIRED`: complete Higo compatibility, client inventory/blacklist and
  traffic ranking, URL/IP/application filtering, network topology, UPnP, DDNS,
  H5000M fan control, DiskMan and KSMBD integration.
- `FULL_OPTIONAL`: ZeroTier and Watchcat. They remain tracked and disabled or
  conservatively configured by default until separately accepted.
- Rescue omissions explicitly classified `ABSENT_EXPECTED` or
  `DEFERRED_TO_FULL` are not Rescue failures. A present frontend with a missing
  or incompatible backend is `PRESENT_BROKEN` or `PRESENT_PARTIAL`.

## Original -> Rescue -> Full feature matrix

`Original` is the restored 24.10 system inspected read-only plus prior durable
evidence. Package presence is not promoted to function evidence. `SHA?` is the
source SHA, not the package file hash; `UNKNOWN` is deliberate.

| Feature | Original 24.10 | Run 20 Rescue / expected | Expected Full | Class; front/back | Package/service; owner; version; SHA? | Integration, validation, issue, dependency, next action | Priority |
|---|---|---|---|---|---|---|---|
| Connection/status/signal | PRESENT_WORKING | PRESENT_WORKING / CORE_RESCUE | PRESENT_WORKING | core; yes/yes | Higo + QModem; VENDOR_HIGO/THIRD_PARTY; 1.26.04.29.09-r1/3.2.0-r1; Higo hash-pinned/QModem `c1db0fe` | Run 20 FUNCTION_TESTED; preserve RG520 adapter and retest reconnect | P1 |
| Neighbour cells | PRESENT_PARTIAL; QModem 3.0.2 implementation present, response unverified | PRESENT_BROKEN / CORE_RESCUE | PRESENT_WORKING | yes/partial | Higo/QModem/RG520; mixed; current SHAs above | QModem has `get_neighborcell` and Quectel `AT+QENG` parser, but Run 20 returned no rows; controlled raw-response/API trace needed | P1 |
| Band lock | PRESENT_PARTIAL | PRESENT_PARTIAL / CORE_RESCUE | PRESENT_WORKING | yes/yes | Higo/QModem; mixed; current SHAs above | Run 20 UI_OK; mutation deliberately untested; later controlled reversible test | P1 |
| AT debug | PRESENT_PARTIAL | PRESENT_WORKING / CORE_RESCUE | PRESENT_WORKING | yes/yes | Higo/QModem; mixed; current SHAs above | Run 20 read-only `ATI` FUNCTION_TESTED; retain port arbitration and safe-command gate | P1 |
| SMS / SIM | PRESENT_PARTIAL | PRESENT_PARTIAL / CORE_RESCUE | PRESENT_WORKING | yes/yes | Higo/QModem; mixed; current SHAs above | Run 20 UI_OK; send/delete and SIM mutation unverified | P1 |
| Traffic/APN/network mode | PRESENT_PARTIAL | PRESENT_PARTIAL / CORE_RESCUE | PRESENT_WORKING | yes/partial | Higo/QModem; mixed; current SHAs above | data works, but current profile mapping is unrecognized; repair schema adapter before mutation tests | P1 |
| Device list | PRESENT_PARTIAL; wrtbwmon installed/running | no useful data / DEFERRED_TO_FULL | PRESENT_WORKING | yes/no usable aggregator | wrtbwmon/Higo; IMMORTALWRT_FEED/VENDOR_HIGO; 1.2.1-r3; UNKNOWN | Rescue omits collector; historical Full had leases/neighbours/usage DB but empty Higo array, proving a format/path adapter is also required | P2 |
| Blacklist | UNVERIFIED | ABSENT_EXPECTED / DEFERRED_TO_FULL | PRESENT_WORKING | yes/backend unverified | Higo + fw4/nft; VENDOR_HIGO/IMMORTALWRT_CORE; exact core at `1d34e7b`; Higo hash-pinned | define nft/fw4-compatible adapter and reversible test; do not infer from menu | P2 |
| Traffic/application ranking | PRESENT_PARTIAL | no useful data / DEFERRED_TO_FULL | PRESENT_WORKING | yes/no usable aggregator | wrtbwmon + Higo; owners/versions as above | same collector-to-Higo schema/path gap as device list; app ranking may additionally require OAF | P2 |
| WAN | BLOCKED_BY_ENVIRONMENT | BLOCKED_BY_ENVIRONMENT / CORE_RESCUE | PRESENT_WORKING | yes/core | netifd/fw4; IMMORTALWRT_CORE; source `1d34e7b` | no cable; cellular WAN passed but wired WAN remains a separate gate | BLOCKED |
| LAN/DHCP/routing | PRESENT_WORKING | PRESENT_WORKING / CORE_RESCUE | PRESENT_WORKING | yes/yes | netifd/dnsmasq/fw4; IMMORTALWRT_CORE; source `1d34e7b` | Run 20 FUNCTION_TESTED; retain | P0 |
| IPv6 | PRESENT_PARTIAL; device routes/config inspected | device-side PASS, LAN-client FAIL / CORE_RESCUE | PRESENT_WORKING | yes/partial | netifd/odhcp6c/odhcpd/fw4/QModem; core + THIRD_PARTY; core `1d34e7b`, QModem `c1db0fe` | preserve split status; collect packet/rule/prefix evidence on next Rescue test | P0 |
| Interface/port-forward/DMZ/diagnostics | PRESENT_PARTIAL | frontend/API present, mostly UNVERIFIED / CORE_RESCUE where non-mutating | PRESENT_WORKING | yes/adapter present | Higo Lua + netifd/fw4; VENDOR_HIGO/CORE; Higo hash-pinned | API routes exist; Run 20 interface page passed; mutations intentionally untested | P1/P2 |
| UPnP | PRESENT_PARTIAL; 2.3.9-r1 installed, disabled | ABSENT_EXPECTED / DEFERRED_TO_FULL | PRESENT_WORKING, safe default off | yes/no package | miniupnpd/luci-app-upnp; IMMORTALWRT_FEED; 2.3.9-r1; UNKNOWN | Full config selects LuCI package; resolve dependency/source, build and controlled mapping test | P2 |
| DDNS | PRESENT_PARTIAL; 2.8.2-r65 installed | ABSENT_EXPECTED / DEFERRED_TO_FULL | PRESENT_WORKING | yes/no package | ddns-scripts/LuCI; IMMORTALWRT_FEED; target 2.8.3-r5; UNKNOWN | exact feed resolution and test account required; never embed credentials | P2 |
| Network topology | PRESENT_PARTIAL | PRESENT_PARTIAL / DEFERRED_TO_FULL | PRESENT_WORKING | yes/no aggregation | Higo + DHCP/neighbour/wrtbwmon; mixed; SHAs as above | build common client inventory adapter instead of a second collector | P2 |
| Administrator/firewall/DoS | PRESENT_PARTIAL | PRESENT_PARTIAL / CORE_RESCUE | PRESENT_WORKING | yes/core/adapter | Higo + firewall4/nft; VENDOR_HIGO/CORE; source locks above | baseline fw4 passed; configuration operations require reversible Full tests | P1/P2 |
| IP/URL filtering | PRESENT_PARTIAL | frontend present, function UNVERIFIED / DEFERRED_TO_FULL | PRESENT_WORKING | yes/backend incomplete | Higo + fw4/nft/OAF as applicable; mixed; SHA UNKNOWN for OAF | define native fw4/nft ownership; do not treat static UI as implementation | P2 |
| Application filtering | PRESENT_PARTIAL; appfilter 6.1.8/kmod-oaf installed | ABSENT_EXPECTED / DEFERRED_TO_FULL | PRESENT_WORKING | yes/no package | appfilter/kmod-oaf/luci-app-oaf; THIRD_PARTY; target 7.0.1-r1; UNKNOWN | historical Full OAF backend worked but Higo API did not; source lock and compatibility adapter required | P2 |
| Upgrade / backup-restore | PRESENT_PARTIAL | frontend present; prohibited/unverified | PRESENT_WORKING only after recovery gates | yes/backend unknown | Higo + sysupgrade/backup; mixed; exact SHA varies | persistent paths remain prohibited until rollback is proved | P2 safety gate |
| Logs/tasks/info/resources/terminal | PRESENT_WORKING/PARTIAL | PRESENT_WORKING/PARTIAL / CORE_RESCUE | PRESENT_WORKING | yes/yes | Higo/core; mixed; source locks above | Run 20 logs, runtime task create/delete and safe terminal command passed; destructive operations remain gated | P1 |
| Notifications | UNVERIFIED | PRESENT_BROKEN / expected Higo core | PRESENT_WORKING | yes/no matching route | Higo; VENDOR_HIGO; 1.26.04.29.09-r1; hash-pinned | frontend calls `/system/notifications*`; current Lua dispatcher has no matching handlers and returns its 404 `not found`; implement compatibility routes | P1 |
| Fan control | PRESENT_WORKING; 1-r3 installed/running, PWM node present | ABSENT_EXPECTED from minimal image / DEFERRED_TO_FULL | PRESENT_WORKING | yes/no user policy in Rescue | fancontrol; PROJECT_LOCAL; target 2.0-r1; UNKNOWN | H5000M hardware compatibility, not cosmetic; historical Full bound thermal zone to `hwmon2/pwm1`; recover source/config and handle absent RPM | P1 |
| Disk management | PRESENT_PARTIAL; 0.2.13-r1 installed | ABSENT_EXPECTED / DEFERRED_TO_FULL | PRESENT_WORKING with safety gates | yes/no package | luci-app-diskman; THIRD_PARTY; 0.2.13-r1; UNKNOWN | historical Full API inventory passed; validate only sacrificial external media, never eMMC format | P2 |
| KSMBD/file sharing | PRESENT_PARTIAL; 3.5.5-r1 running | ABSENT_EXPECTED / DEFERRED_TO_FULL | PRESENT_WORKING | yes/no package | ksmbd/LuCI; IMMORTALWRT_FEED; target 3.5.6-r1; UNKNOWN | historical Full service/445 passed; user/share and SMB read/write unverified | P2 |
| Watchcat | PRESENT_PARTIAL; 1-r17 running | ABSENT_EXPECTED / FULL_OPTIONAL | PRESENT_PARTIAL then controlled acceptance | yes/no package | watchcat/LuCI; IMMORTALWRT_FEED; target 1-r25; UNKNOWN | disabled/conservative policy and later fault-injection test | P3 |
| ZeroTier | PRESENT_PARTIAL; 1.14.1 installed, disabled | ABSENT_EXPECTED / FULL_OPTIONAL | PRESENT_PARTIAL, default off | yes/no package | zerotier/LuCI; IMMORTALWRT_FEED; target 1.16.0-r2; UNKNOWN | exact source and isolated join test required; credentials remain local | P3 |

## Root-cause reports

### P0 — LAN-client external IPv6

- `ROOT_CAUSE: UNKNOWN`.
- `CONFIDENCE: HIGH` that the failure is beyond RA/DNS and below or at
  forwarding, firewall, return-path/NDP, prefix handling or QMAP policy;
  `LOW` for any one mechanism without a simultaneous packet trace.
- `EVIDENCE:` Run 20 device-side IPv6 traffic passed. A LAN client received an
  RA-derived address and default route, but numeric IPv6 ICMP and HTTPS both
  timed out. The restored original system has forwarding enabled, an
  `USBv6` DHCPv6 interface with `reqprefix=auto`/`extendprefix=1`, a source-
  specific default route, the delegated `/64` on `br-lan`, and `USB/USBv6` in
  the WAN firewall zone. This is useful comparison evidence, not proof that the
  original client path currently passes.
- `MINIMAL_FIX:` none is justified yet. First capture sanitized Run 20
  `network.interface` status, `ip -6 rule/route`, relevant nft forward/ICMPv6
  rules, sysctls, and simultaneous LAN/wwan packet counters or tcpdump during
  one numeric IPv6 request. Compare prefix lifetime and source selection with
  the original configuration.
- `REGRESSION_RISK:` high; speculative NAT66, proxy-NDP or firewall changes can
  hide a PD/routing defect or break working device-side IPv6.
- `RETEST_PLAN:` next explicitly authorized Rescue RAM boot; one LAN client,
  numeric ICMP and HTTPS plus packet-path evidence, then repeat after reconnect.

### P1 — Higo notifications

- `ROOT_CAUSE:` Higo frontend/backend contract is incomplete. The shipped
  frontend invokes `/system/notifications` and item-update routes, while the
  hash-pinned `api.lua` dispatcher implements network/Wi-Fi routes only and
  falls through to its own HTTP 404/code 1404 `not found` response.
- `CONFIDENCE: HIGH` for the observed error path. The restored original system
  has the same higorosd and `api.lua` hashes, so this is not proved to be a
  Rescue-only missing-file regression; original operation remains UNVERIFIED.
- `EVIDENCE:` exact payload hashes match candidate; source inspection shows the
  frontend routes and no matching Lua handlers; the displayed Run 20 error
  text matches the dispatcher fallback.
- `MINIMAL_FIX:` add a project-local compatibility implementation for the
  required notification GET/PUT contract backed by a defined UCI/ubus service,
  or explicitly bind a proven native handler. Do not hide the menu.
- `REGRESSION_RISK:` medium; schema/default mismatch or unsafe delivery targets.
- `RETEST_PLAN:` API contract tests plus UI toggle tests in RAM with no external
  secret or recipient, followed by persistence-policy review.

### P1 — CPE current profile recognition

- `ROOT_CAUSE:` the current QModem 3.2 integration lacks an exact RG520N-CN
  model profile and seeds a generic project-local `modem-device` UCI section.
  Dialing consumes that fixed section successfully, but Higo's presentation
  mapping does not recognize it as a canonical 4G/5G configuration.
- `CONFIDENCE: HIGH` for the schema/model mismatch; the exact frontend field
  predicate inside the closed binary remains UNKNOWN.
- `EVIDENCE:` `99-h5000m-qmodem` states that QModem 3.2 has no exact model
  profile and creates `name=rg520n-cn`, manufacturer/platform/bands/ports. The
  restored original system exposes the same fixed section. Run 20 QMI/QMAP and
  traffic passed while only the Higo label was unrecognized.
- `MINIMAL_FIX:` define one canonical RG520N-CN profile/normalization adapter
  consumed by both QModem and Higo; preserve the proven fixed QMAP path and do
  not change modem bands or radio configuration during schema validation.
- `REGRESSION_RISK:` medium-high; QModem scanner, dialer and Higo share the
  section and AT port.
- `RETEST_PLAN:` static UCI/API fixtures, RAM boot read-only profile display,
  first dial, IPv4/IPv6, and controlled reconnect regression.

### P1 — neighbour cells

- `ROOT_CAUSE: UNKNOWN`. The failure is narrowed to the Higo -> QModem ->
  Quectel response/parse chain, not modem registration or the QMI data path.
- `CONFIDENCE: HIGH` in the narrowed boundary; `LOW` on whether the carrier/
  modem returned no neighbours, Higo invoked the wrong contract, or the parser
  rejected RG520 NSA/SA output.
- `EVIDENCE:` QModem contains `get_neighborcell`; its Quectel implementation
  sends read-only `AT+QENG="neighbourcell"` and parses legacy LTE/WCDMA-shaped
  lines. Run 20 serving status and data passed but the Higo page stayed empty.
- `MINIMAL_FIX:` none until a controlled read-only test captures the Higo API
  response, QModem invocation/JSON and sanitized raw response under exclusive
  AT-port ownership. Then adjust only the failing contract/parser layer.
- `REGRESSION_RISK:` high if polling races with `quectel-CM-M`/QModem or a
  mutating cell-lock path is accidentally invoked.
- `RETEST_PLAN:` future explicit safe-AT gate, exclusive port arbitration,
  bounded `QENG` read, sanitized fixture, UI/API comparison; no lock command.

## Provenance gaps and backlog

Exact source SHA is still `UNKNOWN` for wrtbwmon, OpenAppFilter, fancontrol,
DiskMan, KSMBD, UPnP, DDNS, Watchcat and ZeroTier. Full must not build until
each required source is resolved against the locked feeds or an explicit
third-party repository and recorded in `docs/PACKAGES.md`/candidate locks.

1. `P0`: prove and repair LAN-client IPv6 forwarding/return path without
   weakening firewall or essential IPv6 acceptance.
2. `P1`: implement Higo notification contract; normalize RG520 profile; close
   neighbour-cell read path; then regression-test Higo/QModem port ownership.
3. `P1`: restore H5000M thermal/PWM policy as hardware compatibility, including
   capability-based handling when no RPM input exists.
4. `P2`: create one client inventory/traffic compatibility layer using DHCP,
   neighbour and wrtbwmon data; expose device list, blacklist and rankings.
5. `P2`: lock and integrate OAF plus IP/URL filtering, topology, UPnP, DDNS,
   DiskMan and KSMBD with feature-specific safety tests.
6. `P3`: lock optional Watchcat and ZeroTier, default conservatively, and test
   fault recovery/joining separately.
7. `BLOCKED`: wired WAN validation until a cable/upstream environment exists.

## Final status and stop

DEVICE-01: `PASS_WITH_KNOWN_ISSUES`  
DEVICE-01R_ANALYSIS: `COMPLETE`  
RESCUE_CORE_VALIDATED: `YES`  
FINAL_FEATURE_COMPLETE: `NO`  
FULL_INTEGRATION_COMPLETE: `NO`  
REPAIR_PLAN_READY: `YES`  
REVIEW_REQUIRED: `YES`

No Run 21, build, source/config/package change, Full work, device write,
mutating AT command or persistent operation was performed by this audit.
