#!/usr/bin/env python3
"""Apply the narrow Higo CPE 4G+5G presentation compatibility patch."""

import argparse
import hashlib
from pathlib import Path


ORIGINAL = (
    'return a.find(n=>Ie(n.networks)===s)||null})'
)
PATCHED = (
    'return a.find(n=>Ie(n.networks)===s)||(s==="4G|5G"?'
    '{value:"4g-5g",title:"4G + 5G",networks:["4G","5G"]}:null)})'
)


def sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def patch_file(path: Path, apply: bool) -> str:
    raw = path.read_bytes()
    original = ORIGINAL.encode()
    patched = PATCHED.encode()
    original_count = raw.count(original)
    patched_count = raw.count(patched)
    if original_count == 1 and patched_count == 0:
        if not apply:
            raise SystemExit("HIGO_CPE_PATCH FAIL: canonical input is not patched")
        result = raw.replace(original, patched, 1)
        path.write_bytes(result)
        return f"applied source={sha256(raw)} runtime={sha256(result)}"
    if original_count == 0 and patched_count == 1:
        return f"already-applied runtime={sha256(raw)}"
    raise SystemExit(
        "HIGO_CPE_PATCH FAIL: expected exactly one canonical or patched "
        f"predicate; original={original_count} patched={patched_count}"
    )


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("mode", choices=("apply", "check"))
    parser.add_argument("asset", type=Path)
    args = parser.parse_args()
    print("HIGO_CPE_PATCH PASS:", patch_file(args.asset, args.mode == "apply"))


if __name__ == "__main__":
    main()
