#!/bin/sh
set -eu

overwrite=0
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
output_dir=${TASK_LOG_OUTPUT_DIR:-"$script_dir/../docs/task-logs"}

TASK_ID=${TASK_ID:-}
DATE_UTC=${DATE_UTC:-}
DOMAIN=${DOMAIN:-}
TASK_TYPE=${TASK_TYPE:-}
START_HEAD=${START_HEAD:-}
END_HEAD=${END_HEAD:-}
FIRMWARE_IMPLEMENTATION_BASELINE=${FIRMWARE_IMPLEMENTATION_BASELINE:-}
FILES_CHANGED=${FILES_CHANGED:-}
TESTS_RUN=${TESTS_RUN:-}
TEST_RESULT=${TEST_RESULT:-}
BUILD_TRIGGERED=${BUILD_TRIGGERED:-}
GITHUB_RUN_ID=${GITHUB_RUN_ID:-}
DEVICE_TOUCHED=${DEVICE_TOUCHED:-}
PERSISTENT_TOUCHED=${PERSISTENT_TOUCHED:-}
WHAT_CHANGED=${WHAT_CHANGED:-}
WHY_CHANGED=${WHY_CHANGED:-}
FIRST_CAUSAL_ERROR=${FIRST_CAUSAL_ERROR:-}
KNOWN_ISSUES=${KNOWN_ISSUES:-}
UNRESOLVED=${UNRESOLVED:-}
NEXT_GATE=${NEXT_GATE:-}
SANITIZED=${SANITIZED:-YES}
RAW_TRANSCRIPT_INCLUDED=${RAW_TRANSCRIPT_INCLUDED:-NO}

usage() {
    echo "usage: $0 [--overwrite] [--output-dir DIR] FIELD=VALUE ..." >&2
    exit 2
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --overwrite) overwrite=1 ;;
        --output-dir)
            [ "$#" -ge 2 ] || usage
            output_dir=$2
            shift
            ;;
        *=*)
            key=${1%%=*}
            value=${1#*=}
            case "$key" in
                TASK_ID) TASK_ID=$value ;; DATE_UTC) DATE_UTC=$value ;;
                DOMAIN) DOMAIN=$value ;; TASK_TYPE) TASK_TYPE=$value ;;
                START_HEAD) START_HEAD=$value ;; END_HEAD) END_HEAD=$value ;;
                FIRMWARE_IMPLEMENTATION_BASELINE) FIRMWARE_IMPLEMENTATION_BASELINE=$value ;;
                FILES_CHANGED) FILES_CHANGED=$value ;; TESTS_RUN) TESTS_RUN=$value ;;
                TEST_RESULT) TEST_RESULT=$value ;; BUILD_TRIGGERED) BUILD_TRIGGERED=$value ;;
                GITHUB_RUN_ID) GITHUB_RUN_ID=$value ;; DEVICE_TOUCHED) DEVICE_TOUCHED=$value ;;
                PERSISTENT_TOUCHED) PERSISTENT_TOUCHED=$value ;; WHAT_CHANGED) WHAT_CHANGED=$value ;;
                WHY_CHANGED) WHY_CHANGED=$value ;; FIRST_CAUSAL_ERROR) FIRST_CAUSAL_ERROR=$value ;;
                KNOWN_ISSUES) KNOWN_ISSUES=$value ;; UNRESOLVED) UNRESOLVED=$value ;;
                NEXT_GATE) NEXT_GATE=$value ;; SANITIZED) SANITIZED=$value ;;
                RAW_TRANSCRIPT_INCLUDED) RAW_TRANSCRIPT_INCLUDED=$value ;;
                *) echo "unknown field: $key" >&2; exit 2 ;;
            esac
            ;;
        *) usage ;;
    esac
    shift
done

required="TASK_ID DATE_UTC DOMAIN TASK_TYPE START_HEAD END_HEAD FIRMWARE_IMPLEMENTATION_BASELINE FILES_CHANGED TESTS_RUN TEST_RESULT BUILD_TRIGGERED GITHUB_RUN_ID DEVICE_TOUCHED PERSISTENT_TOUCHED WHAT_CHANGED WHY_CHANGED FIRST_CAUSAL_ERROR KNOWN_ISSUES UNRESOLVED NEXT_GATE"
for key in $required; do
    eval "value=\${$key}"
    if [ -z "$value" ]; then
        echo "missing required field: $key" >&2
        exit 2
    fi
done

case "$TASK_ID" in *[!A-Za-z0-9._-]*|'') echo "invalid TASK_ID" >&2; exit 2 ;; esac
case "$DATE_UTC" in ????-??-??*) ;; *) echo "DATE_UTC must begin YYYY-MM-DD" >&2; exit 2 ;; esac
case "$DOMAIN" in PLATFORM_HARDWARE|VENDOR_WIRELESS|RG520_MODEM|HIGO_PRODUCT|FULL_CAPABILITIES|LIFECYCLE|TOOLING) ;; *) echo "invalid DOMAIN" >&2; exit 2 ;; esac
case "$TASK_TYPE" in IMPLEMENTATION|DIAGNOSIS|BUILD_TRIGGER|BUILD_REVIEW|RAM_VALIDATION|AUTOMATION|DOCUMENTATION|RECOVERY) ;; *) echo "invalid TASK_TYPE" >&2; exit 2 ;; esac
[ "$SANITIZED" = YES ] || { echo "SANITIZED must be YES" >&2; exit 2; }
[ "$RAW_TRANSCRIPT_INCLUDED" = NO ] || { echo "RAW_TRANSCRIPT_INCLUDED must be NO" >&2; exit 2; }

all_values=$(printf '%s\n' "$TASK_ID" "$DOMAIN" "$TASK_TYPE" "$FILES_CHANGED" "$TESTS_RUN" "$WHAT_CHANGED" "$WHY_CHANGED" "$FIRST_CAUSAL_ERROR" "$KNOWN_ISSUES" "$UNRESOLVED" "$NEXT_GATE")
if printf '%s\n' "$all_values" | grep -Eiq '(password|token|cookie|private[ _-]?key|api[ _-]?secret|imei|iccid|imsi)[[:space:]]*[:=]|([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}'; then
    echo "refusing content that resembles secret or unique-device material" >&2
    exit 2
fi

mkdir -p -- "$output_dir"
date_part=$(printf '%s' "$DATE_UTC" | cut -c1-10)
target="$output_dir/$date_part-$TASK_ID.md"
if [ -e "$target" ] && [ "$overwrite" -ne 1 ]; then
    echo "task log already exists: $target" >&2
    exit 3
fi

tmp="$target.tmp.$$"
trap 'rm -f -- "$tmp"' EXIT HUP INT TERM
{
    echo '# Codex Task Log'
    echo
    for key in TASK_ID DATE_UTC DOMAIN TASK_TYPE START_HEAD END_HEAD FIRMWARE_IMPLEMENTATION_BASELINE FILES_CHANGED TESTS_RUN TEST_RESULT BUILD_TRIGGERED GITHUB_RUN_ID DEVICE_TOUCHED PERSISTENT_TOUCHED WHAT_CHANGED WHY_CHANGED FIRST_CAUSAL_ERROR KNOWN_ISSUES UNRESOLVED NEXT_GATE SANITIZED RAW_TRANSCRIPT_INCLUDED; do
        eval "value=\${$key}"
        printf '%s=%s\n' "$key" "$value"
    done
} > "$tmp"
mv -- "$tmp" "$target"
trap - EXIT HUP INT TERM
printf '%s\n' "$target"
