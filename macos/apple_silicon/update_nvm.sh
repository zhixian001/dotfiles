#!/usr/bin/env bash

export JH_ARM_NVM_DIR="$HOME/.nvm_arm"
export JH_X86_NVM_DIR="$HOME/.nvm"

# remove previous nvm paths
__remove_from_path "nvm"

current_arch="$(arch)"
if [[ $current_arch == "i386" ]]; then
    export NVM_DIR="$JH_X86_NVM_DIR"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
else
    if [[ -r "$JH_ARM_NVM_DIR" ]]; then
        export NVM_DIR="$JH_ARM_NVM_DIR"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    else
        export NVM_DIR="$JH_X86_NVM_DIR"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    fi
fi
