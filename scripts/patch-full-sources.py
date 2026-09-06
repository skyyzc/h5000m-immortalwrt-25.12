#!/usr/bin/env python3
"""Apply fail-closed, idempotent Full source compatibility transforms."""

import pathlib
import sys


def replace_exact(path: pathlib.Path, old: str, new: str, marker: str) -> None:
    text = path.read_text(encoding="utf-8")
    if marker in text:
        return
    if text.count(old) != 1:
        raise SystemExit(f"FULL_SOURCE_GATE FAIL: unexpected source contract in {path}")
    path.write_text(text.replace(old, new), encoding="utf-8", newline="\n")


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("usage: patch-full-sources.py IMMORTALWRT_SOURCE EXTERNAL_PACKAGES")
    source = pathlib.Path(sys.argv[1])
    external = pathlib.Path(sys.argv[2])

    watchcat = source / "feeds/packages/utils/watchcat/files/watchcat.config"
    watchcat_text = watchcat.read_text(encoding="utf-8")
    if "H5000M Full Candidate" not in watchcat_text:
        if not watchcat_text.startswith("config watchcat\n"):
            raise SystemExit("FULL_SOURCE_GATE FAIL: unexpected Watchcat default contract")
        watchcat.write_text(
            "# H5000M Full Candidate: no default watchdog action. An owner must configure\n"
            "# an explicit target, interval and action after validating the failure policy.\n",
            encoding="utf-8",
            newline="\n",
        )

    hotplug = external / "wrtbwmon/net/etc/hotplug.d/iface/99-wrtbwmon"
    replace_exact(
        hotplug,
        "#!/bin/sh\n\n",
        "#!/bin/sh\n\n# H5000M Full Candidate: account LAN clients without WAN/modem restart storms.\n"
        "[ \"${INTERFACE:-}\" = lan ] || exit 0\n",
        "H5000M Full Candidate",
    )

    init = external / "wrtbwmon/net/etc/init.d/wrtbwmon"
    replace_exact(
        init,
        "stop_service() {\n\tprocd_kill wrtbwmon\n\tkill -CONT $(cat $PID_FILE)\n}",
        "stop_service() {\n\t# H5000M: resume a stopped loop before asking procd to terminate it.\n"
        "\tkill -CONT \"$(cat \"$PID_FILE\" 2>/dev/null)\" 2>/dev/null || true\n"
        "\tprocd_kill wrtbwmon\n}",
        "H5000M: resume a stopped loop",
    )
    print("FULL_SOURCE_GATE PASS: deterministic Full compatibility transforms")


if __name__ == "__main__":
    main()
