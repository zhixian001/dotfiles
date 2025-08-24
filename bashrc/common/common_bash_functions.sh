#!/usr/bin/env bash

# ====================================================================== #
# Debug Logging Functions
# ====================================================================== #

# ANSI Color codes for debug output
__DOTFILES_DEBUG_COLORS() {
    if [[ -t 2 ]]; then  # Only use colors if stderr is a terminal
        export __DEBUG_GRAY='\033[90m'
        export __DEBUG_BLUE='\033[34m'
        export __DEBUG_GREEN='\033[32m'
        export __DEBUG_YELLOW='\033[33m'
        export __DEBUG_CYAN='\033[36m'
        export __DEBUG_MAGENTA='\033[35m'
        export __DEBUG_RESET='\033[0m'
        export __DEBUG_BOLD='\033[1m'
    else
        export __DEBUG_GRAY=''
        export __DEBUG_BLUE=''
        export __DEBUG_GREEN=''
        export __DEBUG_YELLOW=''
        export __DEBUG_CYAN=''
        export __DEBUG_MAGENTA=''
        export __DEBUG_RESET=''
        export __DEBUG_BOLD=''
    fi
}

# Initialize colors
__DOTFILES_DEBUG_COLORS

# Debug logging function - only works when JH_DOTFILES_DEBUG is set
__dotfiles_debug_log() {
    if [[ -n "$JH_DOTFILES_DEBUG" ]]; then
        local timestamp=$(date '+%H:%M:%S')
        echo -e "${__DEBUG_GRAY}[${__DEBUG_CYAN}DOTFILES-DEBUG${__DEBUG_GRAY} ${__DEBUG_YELLOW}$timestamp${__DEBUG_GRAY}]${__DEBUG_RESET} $@" >&2
    fi
}

# Log file sourcing
__dotfiles_debug_source() {
    local file="$1"
    local filename=$(basename "$file")
    __dotfiles_debug_log "${__DEBUG_GREEN}Sourcing file:${__DEBUG_RESET} ${__DEBUG_BLUE}$filename${__DEBUG_RESET} ${__DEBUG_GRAY}($file)${__DEBUG_RESET}"
}

# Log function execution
__dotfiles_debug_func() {
    local func_name="$1"
    shift
    __dotfiles_debug_log "${__DEBUG_MAGENTA}Function:${__DEBUG_RESET} ${__DEBUG_BOLD}$func_name${__DEBUG_RESET}${__DEBUG_GRAY}($@)${__DEBUG_RESET}"
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
        __dotfiles_debug_log "${__DEBUG_GREEN}Command '${__DEBUG_BOLD}$command_to_check${__DEBUG_RESET}${__DEBUG_GREEN}' found, registering aliases${__DEBUG_RESET}"
        for alias_arg in "$@"; do
            # alias $alias_arg
            eval "alias $alias_arg"
            __dotfiles_debug_log "  ${__DEBUG_CYAN}→${__DEBUG_RESET} Registered alias: ${__DEBUG_YELLOW}$alias_arg${__DEBUG_RESET}"
        done
    else
        __dotfiles_debug_log "${__DEBUG_GRAY}Command '${__DEBUG_BOLD}$command_to_check${__DEBUG_RESET}${__DEBUG_GRAY}' not found, skipping aliases${__DEBUG_RESET}"
    fi
}

# Source all files in dir
# Usage: __source_files_in_dir_with_extension $JH_DOTFILES_DIR/bashrc/common/aliases ".alias.sh"
__source_files_in_dir_with_extension() {
    __dotfiles_debug_func "__source_files_in_dir_with_extension" "$@"
    local folder_path="$1"
    local file_extension="$2"

    __dotfiles_debug_log "${__DEBUG_BLUE}Looking for files in:${__DEBUG_RESET} ${__DEBUG_GRAY}$folder_path/*$file_extension${__DEBUG_RESET}"
    local found_files=false
    for file in "$folder_path"/*"$file_extension"; do
        if [ -f "$file" ]; then
            __dotfiles_debug_source "$file"
            source "$file"
            found_files=true
        fi
    done
    
    if [[ "$found_files" = "false" ]]; then
        __dotfiles_debug_log "${__DEBUG_GRAY}No files found matching pattern: $folder_path/*$file_extension${__DEBUG_RESET}"
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
