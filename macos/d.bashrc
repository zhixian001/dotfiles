# Architecture Independent Settings

# Functions
add_arm_x86_path_entry () {
   # args
    #   $1 : arm path value
    #   $2 : x86 path value

    local current_arch="$(arch)"
    if [[ $current_arch == "i386" ]]; then
        __remove_from_path $1
        append_path_leftmost_unique $2
    else
        __remove_from_path $2
        append_path_leftmost_unique $1
    fi
}

add_arm_x86_variable_entry () {
    # args
    #   $1 : env variable name
    #   $2 : arm variable value
    #   $3 : x86 variable value

    local current_arch="$(arch)"
    if [[ $current_arch == "i386" ]]; then
        export $1="$3"
    else
        export $1="$2"
    fi
}

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

# export PATH="/usr/local/sbin:$PATH:/usr/local/Cellar/avr-gcc@8/8.4.0_2/bin"

append_path_leftmost_unique "/usr/local/sbin"
append_path_rightmost_unique "/usr/local/Cellar/avr-gcc@8/8.4.0_2/bin"

# rbenv path setup
RBENV_SHIMS_PATH="$HOME/.rbenv/shims"
if [ -d "$RBENV_SHIMS_PATH" ]; then
    __remove_from_path "$RBENV_SHIMS_PATH"
    export PATH="$RBENV_SHIMS_PATH:$PATH"
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
    for f in $JH_DOTFILES_DIR/macos/apple_silicon/*.sh; do
        source "$f"
    done
fi
