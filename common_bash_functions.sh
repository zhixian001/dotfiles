#!/usr/bin/env bash

# Custom Alias / Function
whicharch() {
    file $(which "$@")
}

pathshow() {
    echo "$PATH" | tr ":" "\n"
}

__remove_from_path() {
   local to_remove=$(echo -n "$@" | tr " " "|") 
   export PATH=$(echo -n $PATH | tr ":" "\n" | grep -vE "$to_remove" | sed -r '/^\s*$/d' | tr "\n" ":")
}

append_path_leftmost_unique() {
    __remove_from_path $1
    export PATH="$1:$PATH"
}

append_path_rightmost_unique() {
    __remove_from_path $1
    export PATH="$PATH$1"
}

# VSCode terminal SetMark sequence support
vscodemark() {
    echo -e "$@\x1b]1337;SetMark\x07"
}

