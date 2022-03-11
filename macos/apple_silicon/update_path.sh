#!/usr/bin/env bash

# M1 switch shell architecture
alias arm="env /usr/bin/arch -arm64 /opt/homebrew/bin/bash"
alias intel="env /usr/bin/arch -x86_64 /usr/local/bin/bash"


current_arch="$(arch)"
if [[ $current_arch == "i386" ]]; then
    # See: https://unix.stackexchange.com/questions/108873/removing-a-directory-from-path
    TMP_PATH="/usr/local/opt/llvm/bin:${PATH}"

    export PATH=`echo $TMP_PATH | tr ":" "\n" | \
            grep -v "/opt/homebrew/bin" | \
            grep -v "/opt/homebrew/sbin" | \
            grep -v "/opt/homebrew/opt/llvm/bin" | \
        sed -r '/^\s*$/d' | tr "\n" ":"`

else
    TMP_PATH="/opt/homebrew/opt/llvm/bin:${PATH}"

    export PATH=`echo $TMP_PATH | tr ":" "\n" | \
            grep -v "/opt/homebrew/bin" | \
            grep -v "/opt/homebrew/sbin" | \
            grep -v "/usr/local/opt/llvm/bin" | \
        sed -r '/^\s*$/d' | tr "\n" ":"`

    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Move higher-priority paths forward
__reorder_path () {
    local high_priority_keywords=("rbenv" "miniconda" "nvm")

    local unordered_paths=`echo $PATH | tr ":" "\n" `

    for keyword in ${high_priority_keywords[@]}; do
        local related_paths=$(echo $unordered_paths | tr " " "\n" | grep "$keyword" | sort -u)

        for priority_path in ${related_paths[@]}; do
            local tmp_path=`echo $PATH | tr ":" "\n" | \
                grep -v "$priority_path" | sed -r '/^\s*$/d' | tr "\n" ":"`

            export PATH="$priority_path:$tmp_path"
        done
    done

    unset __reorder_path
}

__reorder_path
