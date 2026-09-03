#!/bin/sh
set -eu

# Usage: check-h5000m-governance.sh [base-ref [head-ref]].
if [ "$#" -ge 1 ]; then
	changed="$(git diff --name-only "$1...${2:-HEAD}")"
else
	changed="$(git diff --name-only)
$(git diff --cached --name-only)"
fi
[ -n "$changed" ] || exit 0

has_changelog=0
has_readme=0
has_state=0
needs_changelog=0
needs_readme=0
needs_state=0

for file in $changed; do
	case "$file" in CHANGELOG.md) has_changelog=1;; esac
	case "$file" in README.md) has_readme=1;; esac
	case "$file" in PROJECT_STATE.md) has_state=1;; esac
	case "$file" in .github/workflows/*|config/*|include/*|package/*|scripts/*|target/*|toolchain/*|tools/*|feeds.conf*|Makefile|*.config|*.patch) needs_changelog=1;; esac
	case "$file" in .github/workflows/*|package/*|target/linux/mediatek/*|feeds.conf*|*h5000m*|*.config) needs_readme=1;; esac
	case "$file" in .github/workflows/*|package/*|target/*|*h5000m*|*.config) needs_state=1;; esac
done
fail=0

if [ "$needs_changelog" -eq 1 ] && [ "$has_changelog" -ne 1 ]; then
	echo "ERROR: core/build/plugin/device changes require CHANGELOG.md"; fail=1
fi
if [ "$needs_readme" -eq 1 ] && [ "$has_readme" -ne 1 ]; then
	echo "ERROR: user-visible/version/compatibility changes require a README.md check"; fail=1
fi
if [ "$needs_state" -eq 1 ] && [ "$has_state" -ne 1 ]; then
	echo "ERROR: build/test-sensitive changes require PROJECT_STATE.md"; fail=1
fi
for required in AGENTS.md PROJECT_STATE.md CHANGELOG.md README.md; do
	[ -s "$required" ] || { echo "ERROR: missing or empty: $required"; fail=1; }
done
exit "$fail"
