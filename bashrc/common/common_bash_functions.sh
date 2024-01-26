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

# Usage: __register_aliases_if_command_exist docker-compose "dkc=docker-compose" "dkcup=docker-compose up"
__register_aliases_if_command_exist() {
    local command_to_check="$1"
    # remove first arg
    shift

    # Check existence
    if command -v "$command_to_check" >/dev/null 2>&1; then
        for alias_arg in "$@"; do
            # alias $alias_arg
            eval "alias $alias_arg"
        done
    fi
}

# Source all files in dir
# Usage: __source_files_in_dir_with_extension $JH_DOTFILES_DIR/bashrc/common/aliases ".alias.sh"
__source_files_in_dir_with_extension() {
    local folder_path="$1"
    local file_extension="$2"

    for file in "$folder_path"/*"$file_extension"; do
        if [ -f "$file" ]; then
            source "$file"
            # echo "Sourced: $file"
        fi
    done
}

# find package json (ascends to parent dir)
__find_package_json() {
    local current_dir=$(pwd)

    while [ "$current_dir" != "/" ]; do
        if [ -f "$current_dir/package.json" ]; then
            echo "$current_dir/package.json"
            return
        fi
        current_dir=$(dirname "$current_dir")
    done

    return 1
}
