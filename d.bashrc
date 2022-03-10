# OS independent settings

# Color Generator
if hash vivid 2>/dev/null; then
    export LS_COLORS="$(vivid generate snazzy)"
else
    echo "vivid is not installed"
fi

# Custom Alias / Function
whicharch() {
    file $(which "$@")
}

# ====================================================================== #

# OS Dependent settings
JH_OS_NAME="$(uname -s)"

if [[ $JH_OS_NAME == "Darwin" ]]; then
    # Mac OS
    [[ -r "$JH_DOTFILES_DIR/macos/d.bashrc" ]] && . "$JH_DOTFILES_DIR/macos/d.bashrc"
elif [[ $JH_OS_NAME == "Linux" ]]; then
    # Linux
    [[ -r "$JH_DOTFILES_DIR/linux/d.bashrc" ]] && . "$JH_DOTFILES_DIR/linux/d.bashrc"
else
    # Unknown
    echo "(bashrc) Unknown OS NAME: ${JH_OS_NAME}"
fi
