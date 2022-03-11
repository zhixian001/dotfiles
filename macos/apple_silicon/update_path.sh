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

    local unordered_paths=`echo $PATH | tr ":" "\n" `

    for keyword in ${high_priority_keywords[@]}; do
        local related_paths=$(echo $unordered_paths | tr " " "\n" | grep "$keyword" | sort -u)

        __remove_from_path "${related_paths[@]}"

        export PATH="$(echo ${related_paths[@]} | tr ' ' ':'):$PATH"
    done

    unset __reorder_path
}

__reorder_path
