#!/usr/bin/env -S bash -euET -o pipefail -O inherit_errexit

catch() {
	echo "[ERROR] returned a non-zero exit status $? on $0:$1" "$(\date +'[%F %T %Z]')" >&2
}
trap 'catch ${LINENO[0]}' ERR

die() {
	echo "[FATAL] $*" >&2
	exit 1
}

finally() {
	:
}
trap finally EXIT

retry_until_success() {
	local CHECK_COUNT="${1}"
	local CHECK_INTERVAL="${2}"
	local EXIT_CODE
	for _ in $(seq 1 "${CHECK_COUNT}"); do
		"${@:3}" && return 0
		EXIT_CODE=$?
		sleep "${CHECK_INTERVAL}"
	done
	return "${EXIT_CODE}"
}
