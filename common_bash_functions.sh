#!/usr/bin/env bash

# Custom Alias / Function
whicharch() {
    file $(which "$@")
}

pathshow() {
    echo "$PATH" | tr ":" "\n"
}

__remove_from_path() {
   local to_remove=$(echo "$@" | tr " " "|") 
   export PATH=$(echo $PATH | tr ":" "\n" | grep -vE "$to_remove" | sed -r '/^\s*$/d' | tr "\n" ":")
}
