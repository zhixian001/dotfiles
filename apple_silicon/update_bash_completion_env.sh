#!/usr/bin/env bash

current_arch="$(arch)"
if [[ $current_arch == "i386" ]]; then
    ETC_PATH="/usr/local/etc"

    export BASH_COMPLETION_COMPAT_DIR="${ETC_PATH}/bash_completion.d"
    [[ -r "${ETC_PATH}/profile.d/bash_completion.sh" ]] && . "${ETC_PATH}/profile.d/bash_completion.sh"
else
    ETC_PATH="/opt/homebrew/etc"

    export BASH_COMPLETION_COMPAT_DIR="${ETC_PATH}/bash_completion.d"
    [[ -r "${ETC_PATH}/profile.d/bash_completion.sh" ]] && . "${ETC_PATH}/profile.d/bash_completion.sh"
fi

