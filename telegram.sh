#!/bin/bash

telegram_curl() {
    local ACTION=${1}
    shift
    local HTTP_REQUEST=${1}
    shift
    if [[ "${HTTP_REQUEST}" != "POST_FILE" ]]; then
        curl -s -X "${HTTP_REQUEST}" "https://api.telegram.org/bot$TG_TOKEN/$ACTION" "$@" | jq .
    else
        curl -s "https://api.telegram.org/bot$TG_TOKEN/$ACTION" "$@" | jq .
    fi
}

telegram_main() {
    local ACTION=${1}
    local HTTP_REQUEST=${2}
    local CURL_ARGUMENTS=()
    while [[ "${#}" -gt 0 ]]; do
        case "${1}" in
            --animation | --audio | --document | --photo | --video )
                local CURL_ARGUMENTS+=(-F $(echo "${1}" | sed 's/--//')=@"${2}")
                shift
                ;;
            --* )
                if [[ "$HTTP_REQUEST" != "POST_FILE" ]]; then
                    local CURL_ARGUMENTS+=(-d $(echo "${1}" | sed 's/--//')="${2}")
                else
                    local CURL_ARGUMENTS+=(-F $(echo "${1}" | sed 's/--//')="${2}")
                fi
                shift
                ;;
        esac
        shift
    done
    telegram_curl "${ACTION}" "${HTTP_REQUEST}" "${CURL_ARGUMENTS[@]}"
}

telegram_curl_get() {
    local ACTION=${1}
    shift
    telegram_main "${ACTION}" GET "$@"
}

telegram_curl_post() {
    local ACTION=${1}
    shift
    telegram_main "${ACTION}" POST "$@"
}

telegram_curl_post_file() {
    local ACTION=${1}
    shift
    telegram_main "${ACTION}" POST_FILE "$@"
}

tg_send_message() {
    telegram_main sendMessage POST "$@"
}

tg_edit_message_text() {
    telegram_main editMessageText POST "$@"
}

tg_send_document() {
    telegram_main sendDocument POST_FILE "$@"
}


build_message() {
CI_MESSAGE_ID=$(tg_send_message --chat_id "$CHAT_ID" --text "<b>=== Starting Build ${KERNELNAME} ===</b>
<b>Branch:</b> <code>${KERNELBRANCH}</code>
<b>Device:</b> <code>${DEVICE}</code>
<b>Compile use:</b> <code>${COMPILE}</code>
<b>Job:</b> <code>$(nproc --all) COMPILE KERNEL</code>
<b>Running on:</b> <code>$DISTRO</code>
<b>Started at</b> <code>$DATE</code>
<b>Status:</b> <code>${1}</code>" --parse_mode "html" | jq .result.message_id)
tg_edit_message_text --chat_id "$CHAT_ID" --message_id "$CI_MESSAGE_ID" --text "<b>=== Starting Buil ===<\b>
<b>Branch:</b> <code>${KERNELBRANCH}</code>
<b>Device:</b> <code>${DEVICE}</code>
<b>Compile use:</b> <code>${COMPILE}</code>
<b>Job:</b> <code>$(nproc --all) COMPILE KERNEL</code>
<b>Running on:</b> <code>$DISTRO</code>
<b>Started at</b> <code>$DATE</code>
<b>Status:</b> <code>${1}</code>" --parse_mode "html"

}
