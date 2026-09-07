#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
jshn=$root/tests/fixtures/jshn-7dd12784-init.sh
helper=$root/package/hiveton/higoros/files/usr/libexec/h5000m-ipv6-route-reconcile
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT HUP INT TERM

[ "$(sha256sum "$jshn" | awk '{print $1}')" = 89fb5871dc9f02e952168da2dd311286d5a2fdd4dd39558557611063129c4fec ] || {
	echo 'JSHN_NOUNSET_REGRESSION FAIL: locked jshn snapshot hash mismatch' >&2
	exit 1
}

if command -v busybox >/dev/null 2>&1; then
	run_target_sh() { busybox sh "$@"; }
	test_shell='busybox ash'
elif command -v bash >/dev/null 2>&1; then
	run_target_sh() { bash --posix "$@"; }
	test_shell='bash --posix (BusyBox ash pending on this host)'
else
	run_target_sh() { /bin/sh "$@"; }
	test_shell='/bin/sh (BusyBox ash pending on this host)'
fi

set +e
(
	unset JSON_PREFIX JSON_UNSET
	run_target_sh -c 'set -eu; . "$1"; json_init' sh "$jshn"
) >"$tmp/control.out" 2>"$tmp/control.err"
control_rc=$?
set -e
[ "$control_rc" -ne 0 ] || { echo 'JSHN_NOUNSET_REGRESSION FAIL: control unexpectedly passed' >&2; exit 1; }
grep -Eq 'JSON_PREFIX.*(parameter not set|unbound variable)' "$tmp/control.err" || {
	echo "JSHN_NOUNSET_REGRESSION FAIL: control rc=$control_rc" >&2
	cat "$tmp/control.err" >&2
	exit 1
}

mkdir "$tmp/bin"
cat >"$tmp/bin/ip" <<'EOF'
#!/bin/sh
case "$*" in
	'-6 route show proto 242'|'-6 route show') exit 0 ;;
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
printf '%s\n' 'JSON_SEQ=0' 'JSON_CUR=J_V' 'K_J_V='
EOF
cat >"$tmp/bin/logger" <<'EOF'
#!/bin/sh
printf '%s\n' "$*" >>"$LOGGER_MARKER"
EOF
chmod 755 "$tmp/bin/ip" "$tmp/bin/ubus" "$tmp/bin/jshn" "$tmp/bin/logger"

sed \
	-e "s|^STATE_FILE=.*|STATE_FILE=$tmp/state|" \
	-e "s|^LOCK_DIR=.*|LOCK_DIR=$tmp/lock|" \
	-e "s|^JSHN=.*|JSHN=$jshn|" \
	-e '/^[[:space:]]*if \[ -z "$new" \]; then/i\
	case $- in *u*) printf "%s\\n" nounset-restored >"$NOUNSET_MARKER" ;; *) exit 97 ;; esac' \
	-e '/^[[:space:]]*fail prefix_not_unique_shared_global_64$/i\
	printf "%s\\n" prefix_not_unique_shared_global_64 >"$BOUNDARY_MARKER"' \
	"$helper" >"$tmp/helper"
chmod 755 "$tmp/helper"

set +e
(
	unset JSON_PREFIX JSON_UNSET
	PATH="$tmp/bin:$PATH"
	JSHN_MARKER="$tmp/jshn-reached"
	LOGGER_MARKER="$tmp/logger"
	NOUNSET_MARKER="$tmp/nounset-restored"
	BOUNDARY_MARKER="$tmp/post-init-boundary"
	export PATH JSHN_MARKER LOGGER_MARKER NOUNSET_MARKER BOUNDARY_MARKER
	run_target_sh "$tmp/helper" reconcile
) >"$tmp/helper.out" 2>"$tmp/helper.err"
rc=$?
set -e

regression_fail() {
	echo "JSHN_NOUNSET_REGRESSION FAIL: $1 rc=$rc shell=$test_shell" >&2
	echo '--- stdout ---' >&2; cat "$tmp/helper.out" >&2
	echo '--- stderr ---' >&2; cat "$tmp/helper.err" >&2
	[ ! -f "$tmp/logger" ] || { echo '--- logger ---' >&2; cat "$tmp/logger" >&2; }
	exit 1
}

[ "$rc" -eq 1 ] || regression_fail 'expected controlled prefix failure'
[ -f "$tmp/jshn-reached" ] || regression_fail 'compiled jshn boundary was not reached'
[ -f "$tmp/nounset-restored" ] || regression_fail 'nounset was not restored before route/state phase'
[ -f "$tmp/post-init-boundary" ] || regression_fail 'controlled post-init boundary was not reached'
grep -qx 'prefix_not_unique_shared_global_64' "$tmp/post-init-boundary" || regression_fail 'unexpected post-init boundary'
if [ -f "$tmp/logger" ]; then
	grep -q 'prefix_not_unique_shared_global_64' "$tmp/logger" || regression_fail 'unexpected optional logger output'
fi
if grep -Eq 'parameter not set|unbound variable' "$tmp/helper.err"; then regression_fail 'patched helper retained nounset failure'; fi
[ ! -e "$tmp/lock" ] || regression_fail 'helper lock was not released'

echo "JSHN_NOUNSET_REGRESSION PASS: $test_shell used complete locked jshn; helper crossed load/read, restored nounset, and reached the controlled prefix boundary"
