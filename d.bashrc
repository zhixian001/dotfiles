# OS independent settings

# PS1
# Codespaces bash prompt theme
__bash_prompt() {
    local userpart='`export XIT=$? \
        && [ ! -z "${GITHUB_USER}" ] && echo -n "\[\033[01;32m\]@${GITHUB_USER} " || echo -n "\[\033[01;32m\]\u@\h " \
        && [ "$XIT" -ne "0" ] && echo -n "\[\033[01;31m\]➜" || echo -n "\[\033[00m\]➜"`'
    local gitbranch='`\
        export BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null); \
        if [ "${BRANCH}" != "" ]; then \
            echo -n "\[\033[0;36m\](\[\033[1;31m\]${BRANCH}" \
            && if git ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                    echo -n " \[\033[1;33m\]✗"; \
               fi \
            && echo -n "\[\033[0;36m\]) "; \
        fi`'
    local lightblue='\[\033[1;34m\]'

    local yellow='\[\033[1;33m\]'

    local architecture='`\
        export OS=$(uname -s)
        export ARCH=$(arch)
        if [ "${OS}" = "Darwin" ]; then
            if [ "${ARCH}" = "arm64" ]; then
                echo -n "\[\033[0;36m\] "
            fi
        fi`'

    local removecolor='\[\033[0m\]'
    PS1="${userpart} ${lightblue}\w ${architecture}${gitbranch}${removecolor}\n${yellow}\$${removecolor} "
    unset -f __bash_prompt
}
__bash_prompt
export PROMPT_DIRTRIM=4

# Run on interactive shell
if [[ $- == *i* ]]; then

    # Color Generator
    if hash vivid 2>/dev/null; then
        export LS_COLORS="$(vivid generate snazzy)"
    else
        echo "vivid is not installed"
    fi

    # Print OS Logo
    if [[ -f "$HOME/.oslogo" ]]; then
        echo '' && cat "$HOME/.oslogo" | base64 --decode | cat && echo ''
    fi

fi

# ====================================================================== #
# load common functions
if [[ -r "$JH_DOTFILES_DIR/bashrc/common/common_bash_functions.sh" ]]; then
    [[ -n "$JH_DOTFILES_DEBUG" ]] && echo "[DOTFILES-DEBUG $(date '+%H:%M:%S')] Loading common functions: $JH_DOTFILES_DIR/bashrc/common/common_bash_functions.sh" >&2
    . "$JH_DOTFILES_DIR/bashrc/common/common_bash_functions.sh"
fi
# ====================================================================== #
# load aliases
__dotfiles_debug_log "${__DEBUG_BLUE}Loading aliases from:${__DEBUG_RESET} ${__DEBUG_GRAY}$JH_DOTFILES_DIR/bashrc/common/aliases${__DEBUG_RESET}"
__source_files_in_dir_with_extension $JH_DOTFILES_DIR/bashrc/common/aliases ".alias.sh"
# ====================================================================== #


# OS Dependent settings
JH_OS_NAME="$(uname -s)"

if [[ $JH_OS_NAME == "Darwin" ]]; then
    # Mac OS
    __dotfiles_debug_log "${__DEBUG_GREEN}Detected ${__DEBUG_BOLD}macOS${__DEBUG_RESET}${__DEBUG_GREEN}, loading macOS-specific bashrc${__DEBUG_RESET}"
    [[ -r "$JH_DOTFILES_DIR/bashrc/macos/d.bashrc" ]] && . "$JH_DOTFILES_DIR/bashrc/macos/d.bashrc"
elif [[ $JH_OS_NAME == "Linux" ]]; then
    # Linux
    __dotfiles_debug_log "${__DEBUG_GREEN}Detected ${__DEBUG_BOLD}Linux${__DEBUG_RESET}${__DEBUG_GREEN}, loading Linux-specific bashrc${__DEBUG_RESET}"
    [[ -r "$JH_DOTFILES_DIR/bashrc/linux/d.bashrc" ]] && . "$JH_DOTFILES_DIR/bashrc/linux/d.bashrc"
else
    # Unknown
    echo "(bashrc) Unknown OS NAME: ${JH_OS_NAME}"
    __dotfiles_debug_log "${__DEBUG_YELLOW}Unknown OS detected: ${__DEBUG_BOLD}${JH_OS_NAME}${__DEBUG_RESET}"
fi

# ====================================================================== #

# Extensions (copy these lines to ~/.bashrc and uncomment)

# fzf extension
#[[ -r "$JH_DOTFILES_DIR/bashrc/common/extensions/fzf.sh" ]] && . "$JH_DOTFILES_DIR/bashrc/common/extensions/fzf.sh"

# blsd extension
#[[ -r "$JH_DOTFILES_DIR/bashrc/common/extensions/blsd.sh" ]] && . "$JH_DOTFILES_DIR/bashrc/common/extensions/blsd.sh"
