# Exact initialization/load subset of OpenWrt libubox jshn.sh at
# 7dd127841e82eb1cfb61185da37dde7b9bd9ba6d (ISC), used only to reproduce
# the locked Run23 nounset boundary with the real shell functions.

_json_get_var() {
	eval "$1=\"\$${JSON_PREFIX}$2\""
}

json_cleanup() {
	local unset tmp

	_json_get_var unset JSON_UNSET
	for tmp in $unset J_V; do
		unset \
			${JSON_PREFIX}U_$tmp \
			${JSON_PREFIX}K_$tmp \
			${JSON_PREFIX}S_$tmp \
			${JSON_PREFIX}T_$tmp \
			${JSON_PREFIX}N_$tmp \
			${JSON_PREFIX}$tmp
	done

	unset \
		${JSON_PREFIX}JSON_SEQ \
		${JSON_PREFIX}JSON_CUR \
		${JSON_PREFIX}JSON_UNSET
}

json_init() {
	json_cleanup
	export -n ${JSON_PREFIX}JSON_SEQ=0
	export -- \
		${JSON_PREFIX}JSON_CUR="J_V" \
		${JSON_PREFIX}K_J_V=
}

json_load() {
	eval "`jshn -r "$1"`"
}
