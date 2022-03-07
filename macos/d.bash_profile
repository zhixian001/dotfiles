# Architecture Independent Settings

# Aliases
# ls
alias l='gls --color'
alias ls='gls --color'
alias ll='gls -l --color'
alias la='gls -a --color'
alias lla='gls -al --color'

alias lx='exa'
alias lxl='exa -l'
alias lxa='exa -a'
alias lxla='exa -al'

# pigz
alias tarpigz='tar --use-compress-program="pigz -k " -cf'
alias tarunpigz='tar --use-compress-program="unpigz -k" -xf'

# Docker
alias dk='docker'
alias dkc='docker-compose'
alias d-c='docker-compose'

# Colorized cat (pygmentize / pygments)
alias ccat='pygmentize -g'

# Grep Color
alias grep='grep --color=auto'

# =================================== #

# PATH

export PATH="/usr/local/sbin:$PATH:/usr/local/Cellar/avr-gcc@8/8.4.0_2/bin"

# rbenv path setup
RBENV_SHIMS_PATH="$HOME/.rbenv/shims"
if [ -d "$RBENV_SHIMS_PATH" ]; then
    TMP_PATH=`echo $PATH | tr ":" "\n" | \
            grep -v "$RBENV_SHIMS_PATH" | \
        tr "\n" ":"`
    export PATH="$RBENV_SHIMS_PATH:$TMP_PATH"
fi

# =================================== #

# ETC exports

export BASH_SILENCE_DEPRECATION_WARNING=1

export HOMEBREW_NO_AUTO_UPDATE=1

export GPG_TTY=$(tty)



# =================================== #

# Bash Completion

BREW_PREFIX=$(brew --prefix)

if [[ -r "$BREW_PREFIX/etc/profile.d/bash_completion.sh" ]]; then
    source "${BREW_PREFIX}/etc/profile.d/bash_completion.sh"
    export BASH_COMPLETION_COMPAT_DIR="${BREW_PREFIX}/etc/bash_completion.d"

    # Other Completions (brew)
    source "$BREW_PREFIX/share/bash-completion/completions/cmake"
    source "$BREW_PREFIX/share/bash-completion/completions/pigz"
    source "$BREW_PREFIX/share/bash-completion/completions/psql"
    source "$BREW_PREFIX/share/bash-completion/completions/gzip"
    source "$BREW_PREFIX/share/bash-completion/completions/tar"
    source "$BREW_PREFIX/share/bash-completion/completions/htop"
fi




# ====================================================================== #

# Architecture Dependent Settings

JH_CURRENT_CPU=$(sysctl -a | grep machdep.cpu.brand_string | tr " " "\n" |  grep M1)
if [[ $JH_CURRENT_CPU == "M1" ]]; then
    # M1 CPU
    # other setup scripts
    for f in $JH_DOTFILES_DIR/macos/apple_silicon/*.sh; do
        source "$f"
    done
fi
