#!/usr/bin/env bash

# ====================================================================== #
# Debug Logging Functions
# ====================================================================== #

# Debug logging function - only works when JH_DOTFILES_DEBUG is set
__dotfiles_debug_log() {
    if [[ -n "$JH_DOTFILES_DEBUG" ]]; then
        local timestamp=$(date '+%H:%M:%S')
        echo "[DOTFILES-DEBUG $timestamp] $@" >&2
    fi
}

# Log file sourcing
__dotfiles_debug_source() {
    local file="$1"
    __dotfiles_debug_log "Sourcing file: $file"
}

# Log function execution
__dotfiles_debug_func() {
    local func_name="$1"
    shift
    __dotfiles_debug_log "Function: $func_name($@)"
}

# ====================================================================== #
# Custom Alias / Function
# ====================================================================== #
whicharch() {
    file $(which "$@")
}

pathshow() {
    echo "$PATH" | tr ":" "\n"
}

__remove_from_path() {
    __dotfiles_debug_func "__remove_from_path" "$@"
    local to_remove=$(echo -n "$@" | tr " " "|")
    export PATH=$(echo -n $PATH | tr ":" "\n" | grep -vE "$to_remove" | sed -r '/^\s*$/d' | tr "\n" ":")
}

append_path_leftmost_unique() {
    __dotfiles_debug_func "append_path_leftmost_unique" "$@"
    __remove_from_path $1
    export PATH="$1:$PATH"
}

append_path_rightmost_unique() {
    __dotfiles_debug_func "append_path_rightmost_unique" "$@"
    __remove_from_path $1
    export PATH="$PATH$1"
}

# VSCode terminal SetMark sequence support
vscodemark() {
    echo -e "$@\x1b]1337;SetMark\x07"
}

# Usage: __register_aliases_if_command_exist docker-compose "dkc=docker-compose" "dkcup=docker-compose up"
__register_aliases_if_command_exist() {
    __dotfiles_debug_func "__register_aliases_if_command_exist" "$@"
    local command_to_check="$1"
    # remove first arg
    shift

    # Check existence
    if command -v "$command_to_check" >/dev/null 2>&1; then
        __dotfiles_debug_log "Command '$command_to_check' found, registering aliases"
        for alias_arg in "$@"; do
            # alias $alias_arg
            eval "alias $alias_arg"
            __dotfiles_debug_log "Registered alias: $alias_arg"
        done
    else
        __dotfiles_debug_log "Command '$command_to_check' not found, skipping aliases"
    fi
}

# Source all files in dir
# Usage: __source_files_in_dir_with_extension $JH_DOTFILES_DIR/bashrc/common/aliases ".alias.sh"
__source_files_in_dir_with_extension() {
    __dotfiles_debug_func "__source_files_in_dir_with_extension" "$@"
    local folder_path="$1"
    local file_extension="$2"

    __dotfiles_debug_log "Looking for files in: $folder_path/*$file_extension"
    local found_files=false
    for file in "$folder_path"/*"$file_extension"; do
        if [ -f "$file" ]; then
            __dotfiles_debug_source "$file"
            source "$file"
            found_files=true
        fi
    done
    
    if [[ "$found_files" = "false" ]]; then
        __dotfiles_debug_log "No files found matching pattern: $folder_path/*$file_extension"
    fi
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
