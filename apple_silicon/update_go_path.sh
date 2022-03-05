#!/usr/bin/env bash

ARM_GO_VERSION="1.17.6"
X86_GO_VERSION="1.16.6"

current_arch="$(arch)"
if [[ $current_arch == "i386" ]]; then
    export GOROOT="/usr/local/Cellar/go/${X86_GO_VERSION}/libexec"
else
    export GOROOT="/opt/homebrew/Cellar/go/${ARM_GO_VERSION}/libexec"
fi
