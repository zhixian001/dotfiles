#!/usr/bin/env bash

# M1 switch shell architecture
alias arm="env /usr/bin/arch -arm64 /opt/homebrew/bin/bash"
alias intel="env /usr/bin/arch -x86_64 /usr/local/bin/bash"

current_arch="$(arch)"
if [[ $current_arch == "i386" ]]; then
    __remove_from_path "/opt/homebrew/bin" "/opt/homebrew/sbin" "/opt/homebrew/opt/llvm/bin"

    export PATH="/usr/local/opt/llvm/bin:$PATH"
else
    __remove_from_path "/opt/homebrew/bin" "/opt/homebrew/sbin" "/usr/local/opt/llvm/bin"

    export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Move higher-priority paths forward
__reorder_path () {
    local high_priority_keywords=("rbenv" "miniconda" "nvm")

    local high_priority_keywords_piped=$(echo -n "${high_priority_keywords[@]}" | tr " " "|")
    local priority_path=$(echo -n $PATH | tr ":" "\n" | grep -E "${high_priority_keywords_piped}" | sort -u | tr "\n" ":")

    __remove_from_path "${high_priority_keywords[@]}"

    export PATH="$priority_path$PATH"

    unset __reorder_path
}

__reorder_path
