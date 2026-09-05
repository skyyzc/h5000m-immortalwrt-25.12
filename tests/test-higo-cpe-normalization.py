#!/usr/bin/env python3
import importlib.util
import json
import shutil
import tempfile
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
ASSET = ROOT / "package/hiveton/higoros/files/www/higoros/assets/CPEManagement-CuEyMeyg.js"
FIXTURES = ROOT / "tests/fixtures/higo-cpe-network-modes.json"
PATCHER = ROOT / "scripts/patch-higo-cpe-frontend.py"

spec = importlib.util.spec_from_file_location("higo_cpe_patcher", PATCHER)
patcher = importlib.util.module_from_spec(spec)
assert spec.loader is not None
spec.loader.exec_module(patcher)

LABELS = {
    "3G|4G|5G": "5G 优先",
    "3G|4G": "4G 优先",
    "4G|5G": "4G + 5G",
    "5G": "仅 5G",
    "4G": "仅 4G",
    "3G": "仅 3G",
}


def normalized_key(values):
    selected = {str(value).upper() for value in values}
    return "|".join(item for item in ("3G", "4G", "5G") if item in selected)


fixtures = json.loads(FIXTURES.read_text(encoding="utf-8"))
for fixture in fixtures:
    actual = LABELS.get(normalized_key(fixture["selectedNetworks"]), "未识别配置")
    assert actual == fixture["title"], (fixture, actual)

with tempfile.TemporaryDirectory() as directory:
    candidate = Path(directory) / ASSET.name
    shutil.copyfile(ASSET, candidate)
    first = patcher.patch_file(candidate, True)
    first_bytes = candidate.read_bytes()
    second = patcher.patch_file(candidate, True)
    assert candidate.read_bytes() == first_bytes
    assert first.startswith("applied ")
    assert second.startswith("already-applied ")
    assert first_bytes.count(patcher.PATCHED.encode()) == 1
    assert first_bytes.count(patcher.ORIGINAL.encode()) == 0

print("HIGO_CPE_FIXTURE PASS: 7 cases; deterministic idempotent patch")
