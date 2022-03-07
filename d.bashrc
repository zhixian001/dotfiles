# OS independent settings

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
