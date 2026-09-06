#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
fixture=$root/tests/fixtures/jshn-7dd12784-init.sh
helper=$root/package/hiveton/higoros/files/usr/libexec/h5000m-ipv6-route-reconcile
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT HUP INT TERM

# Prefer the target shell family. Ubuntu validation hosts may expose BusyBox
# separately from /bin/sh; bash POSIX mode is the bounded host fallback.
if command -v busybox >/dev/null 2>&1; then
	run_target_sh() { busybox sh "$@"; }
	test_shell='busybox sh'
elif command -v bash >/dev/null 2>&1; then
	run_target_sh() { bash --posix "$@"; }
	test_shell='bash --posix'
else
	run_target_sh() { /bin/sh "$@"; }
	test_shell='/bin/sh'
fi

# Prove the fixture retains the exact Run23 failure when nounset stays active.
if (
	unset JSON_PREFIX JSON_UNSET
	run_target_sh -c 'set -eu; . "$1"; json_init' sh "$fixture"
) >"$tmp/control.out" 2>"$tmp/control.err"; then
	echo 'JSHN_NOUNSET_REGRESSION FAIL: control unexpectedly passed' >&2
	exit 1
fi
grep -Eq 'JSON_PREFIX.*(parameter not set|unbound variable)' "$tmp/control.err" || {
	echo 'JSHN_NOUNSET_REGRESSION FAIL: control did not reproduce Run23' >&2
	exit 1
}

mkdir "$tmp/bin"
cat >"$tmp/bin/ip" <<'EOF'
#!/bin/sh
case "$*" in
	'-6 route show proto 242') exit 0 ;;
	'-6 route show') exit 0 ;;
	*) exit 1 ;;
esac
EOF
cat >"$tmp/bin/ubus" <<'EOF'
#!/bin/sh
printf '{}\n'
EOF
cat >"$tmp/bin/jshn" <<'EOF'
#!/bin/sh
printf 'reached\n' >"$JSHN_MARKER"
exit 0
EOF
cat >"$tmp/bin/logger" <<'EOF'
#!/bin/sh
printf '%s\n' "$*" >>"$LOGGER_MARKER"
EOF
chmod 755 "$tmp/bin/ip" "$tmp/bin/ubus" "$tmp/bin/jshn" "$tmp/bin/logger"

sed \
	-e "s|^STATE_FILE=.*|STATE_FILE=$tmp/state|" \
	-e "s|^LOCK_DIR=.*|LOCK_DIR=$tmp/lock|" \
	-e "s|^JSHN=.*|JSHN=$fixture|" \
	"$helper" >"$tmp/helper"
chmod 755 "$tmp/helper"

set +e
(
	unset JSON_PREFIX JSON_UNSET
	PATH="$tmp/bin:$PATH" \
	JSHN_MARKER="$tmp/jshn-reached" \
	LOGGER_MARKER="$tmp/logger" \
	run_target_sh "$tmp/helper" reconcile
) >"$tmp/helper.out" 2>"$tmp/helper.err"
rc=$?
set -e

[ "$rc" -eq 1 ] || {
	echo "JSHN_NOUNSET_REGRESSION FAIL: expected controlled prefix failure, got $rc" >&2
	exit 1
}
[ -f "$tmp/jshn-reached" ] || {
	echo 'JSHN_NOUNSET_REGRESSION FAIL: helper did not continue past json_init' >&2
	exit 1
}
grep -q 'prefix_not_unique_shared_global_64' "$tmp/logger" || {
	echo 'JSHN_NOUNSET_REGRESSION FAIL: expected post-init failure not observed' >&2
	exit 1
}
if grep -q 'parameter not set' "$tmp/helper.err"; then
	echo 'JSHN_NOUNSET_REGRESSION FAIL: patched helper retained nounset failure' >&2
	exit 1
fi
[ ! -e "$tmp/lock" ] || {
	echo 'JSHN_NOUNSET_REGRESSION FAIL: helper lock was not released' >&2
	exit 1
}

echo "JSHN_NOUNSET_REGRESSION PASS: $test_shell helper path crossed json_init with JSON_PREFIX initially unset"
