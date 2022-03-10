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

    local removecolor='\[\033[0m\]'
    PS1="${userpart} ${lightblue}\w ${gitbranch}${removecolor}\n${yellow}\$${removecolor} "
    unset -f __bash_prompt
}
__bash_prompt
export PROMPT_DIRTRIM=4

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

# Print OS Logo
if [[ -f "$HOME/.oslogo" ]]; then
    echo '' && base64 --decode "$HOME/.oslogo" | cat && echo ''
fi

# ====================================================================== #

# OS Dependent settings
JH_OS_NAME="$(uname -s)"

if [[ $JH_OS_NAME == "Darwin" ]]; then
    # Mac OS
    [[ -r "$JH_DOTFILES_DIR/macos/d.bash_profile" ]] && . "$JH_DOTFILES_DIR/macos/d.bash_profile"
elif [[ $JH_OS_NAME == "Linux" ]]; then
    # Linux
    [[ -r "$JH_DOTFILES_DIR/linux/d.bash_profile" ]] && . "$JH_DOTFILES_DIR/linux/d.bash_profile"
else
    # Unknown
    echo "(bash_profile) Unknown OS NAME: ${JH_OS_NAME}"
fi
