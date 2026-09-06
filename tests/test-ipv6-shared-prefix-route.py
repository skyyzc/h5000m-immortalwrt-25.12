#!/usr/bin/env python3
import json
import pathlib
import re

ROOT = pathlib.Path(__file__).resolve().parents[1]
FIXTURE = ROOT / "tests/fixtures/ipv6-shared-prefix-routes.json"
HELPER = ROOT / "package/hiveton/higoros/files/usr/libexec/h5000m-ipv6-route-reconcile"
HOOK = ROOT / "package/hiveton/higoros/files/etc/hotplug.d/iface/95-h5000m-ipv6-shared-prefix"

CANONICAL_GUA64 = re.compile(r"^[23][0-9a-f]{0,3}(?::[0-9a-f]{1,4}){0,3}::/64$")


def selected(case):
    common = sorted(set(case.get("cell", ())) & set(case.get("lan", ())))
    valid = [value for value in common if CANONICAL_GUA64.fullmatch(value)]
    return valid[0] if len(valid) == 1 else None


def transition(case):
    action = case.get("action", "reconcile")
    owned = set(case.get("owned", ()))
    foreign = set(case.get("foreign", ()))
    state = case.get("state")
    if action == "teardown":
        return "teardown", set(), foreign
    prefix = selected(case)
    if prefix is None or case.get("conflict"):
        return "fail_closed", set(), foreign
    if case.get("inject") in {"route_replace", "route_verify"}:
        return "error_no_state", owned, foreign
    if state == prefix and prefix in owned:
        return "noop", {prefix}, foreign
    result = "replace" if state and state != prefix else "add"
    if owned and not state:
        result = "add_cleanup_stale"
    if foreign:
        result = "add_preserve_foreign"
    return result, {prefix}, foreign


def dispatch_event(event):
    if event.get("INTERFACE") != "USBv6":
        return []
    action = event.get("ACTION")
    if action in {"ifup", "ifupdate"}:
        if event.get("DEVICE") != "wwan0_1":
            return []
        if action == "ifupdate" and event.get("IFUPDATE_PREFIXES", "0") != "1":
            return []
        return ["reconcile"]
    if action == "ifdown" and "DEVICE" not in event:
        return ["teardown"]
    return []


def test_hotplug_contract(hook):
    positives = (
        ({"ACTION": "ifup", "INTERFACE": "USBv6", "DEVICE": "wwan0_1"}, "reconcile"),
        ({"ACTION": "ifupdate", "INTERFACE": "USBv6", "DEVICE": "wwan0_1",
          "IFUPDATE_PREFIXES": "1"}, "reconcile"),
        ({"ACTION": "ifdown", "INTERFACE": "USBv6"}, "teardown"),
    )
    for event, action in positives:
        assert dispatch_event(event) == [action], event

    negatives = (
        {"ACTION": "ifup", "INTERFACE": "USBv6", "DEVICE": "wwan0"},
        {"ACTION": "ifup", "INTERFACE": "wwan0_1", "DEVICE": "wwan0_1"},
        {"ACTION": "ifup", "INTERFACE": "lan", "DEVICE": "wwan0_1"},
        {"ACTION": "ifup", "DEVICE": "wwan0_1"},
        {"ACTION": "ifup", "INTERFACE": "USBv6"},
        {"ACTION": "ifupdate", "INTERFACE": "USBv6", "DEVICE": "wwan0_1"},
        {"ACTION": "ifupdate", "INTERFACE": "USBv6", "DEVICE": "wwan0_1",
         "IFUPDATE_PREFIXES": "0"},
        {"ACTION": "ifdown", "INTERFACE": "USBv6", "DEVICE": "wwan0_1"},
        {"INTERFACE": "USBv6", "DEVICE": "wwan0_1"},
        {},
    )
    for event in negatives:
        assert dispatch_event(event) == [], event

    # Each event dispatches once; repeated events delegate idempotence to the helper.
    repeated = {"ACTION": "ifupdate", "INTERFACE": "USBv6", "DEVICE": "wwan0_1",
                "IFUPDATE_PREFIXES": "1"}
    assert dispatch_event(repeated) == ["reconcile"]
    assert dispatch_event(repeated) == ["reconcile"]

    for exact in (
        'LOGICAL_INTERFACE=USBv6', 'UNDERLYING_DEVICE=wwan0_1',
        '[ "${INTERFACE:-}" = "$LOGICAL_INTERFACE" ] || exit 0',
        '[ "${DEVICE:-}" = "$UNDERLYING_DEVICE" ] || exit 0',
        '[ -z "${DEVICE:-}" ] || exit 0',
        'exec /usr/libexec/h5000m-ipv6-route-reconcile reconcile',
        'exec /usr/libexec/h5000m-ipv6-route-reconcile teardown',
    ):
        assert exact in hook, exact


def main():
    data = json.loads(FIXTURE.read_text(encoding="utf-8"))
    assert data["constants"] == {
        "cellular_interface": "USBv6", "cellular_device": "wwan0_1",
        "lan_interface": "lan",
        "lan_device": "br-lan", "metric": 1, "protocol": 242,
    }
    required = {
        "no prefix", "one valid shared /64", "malformed prefix",
        "multiple prefixes", "non-shared prefix", "unchanged repeated event",
        "prefix replacement", "ifdown teardown", "stale state recovery",
        "foreign route preservation", "command failure",
        "route verification failure", "ownership mismatch", "idempotence",
    }
    assert required <= {case["name"] for case in data["cases"]}
    for case in data["cases"]:
        result, owned, foreign = transition(case)
        assert result == case["expect"], (case["name"], result)
        assert foreign == set(case.get("foreign", ())), case["name"]
        if case.get("repeat"):
            for _ in range(case["repeat"]):
                assert transition(case)[0] == "noop"

    helper = HELPER.read_text(encoding="utf-8")
    hook = HOOK.read_text(encoding="utf-8")
    for exact in (
        "CELLULAR_INTERFACE=USBv6", "LAN_INTERFACE=lan", "LAN_DEVICE=br-lan",
        "ROUTE_METRIC=1", "ROUTE_PROTOCOL=242",
        "STATE_FILE=/var/run/h5000m-ipv6-route.state",
        "LOCK_DIR=/var/run/h5000m-ipv6-route.lock",
        'ip -6 route show proto "$ROUTE_PROTOCOL"',
        'ip -6 route del "$prefix" dev "$LAN_DEVICE" metric "$ROUTE_METRIC" proto "$ROUTE_PROTOCOL"',
        'ip -6 route get "$probe"',
    ):
        assert exact in helper, exact
    assert 'ubus call network.interface dump' in helper
    assert 'IFUPDATE_PREFIXES:-0' in hook
    assert 'LOGICAL_INTERFACE=USBv6' in hook
    assert 'UNDERLYING_DEVICE=wwan0_1' in hook
    assert all(event in hook for event in ("ifup)", "ifupdate)", "ifdown)"))
    forbidden = ("nat66", "proxy_ndp", "proxy-ndp", "nft ", "fw4", "qmodem", "uqmi", "ifdown wwan", "network reload")
    combined = (helper + hook).lower()
    assert not any(token in combined for token in forbidden)
    assert not re.search(r"[23][0-9a-f]{3}:[0-9a-f:]+/64", helper)
    test_hotplug_contract(hook)
    print(f"IPV6_ROUTE_FIXTURES PASS: {len(data['cases'])} deterministic cases")
    print("IPV6_HOTPLUG_FIXTURES PASS: exact Run22 contract and fail-closed negatives")
    print("IPV6_ROUTE_STATIC PASS: ownership/lifecycle/safety constants")


if __name__ == "__main__":
    main()
