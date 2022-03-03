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
        tr "\n" ":"`

else
    TMP_PATH="/opt/homebrew/opt/llvm/bin:${PATH}"

    export PATH=`echo $TMP_PATH | tr ":" "\n" | \
            grep -v "/opt/homebrew/bin" | \
            grep -v "/opt/homebrew/sbin" | \
            grep -v "/usr/local/opt/llvm/bin" | \
        tr "\n" ":"`

    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

