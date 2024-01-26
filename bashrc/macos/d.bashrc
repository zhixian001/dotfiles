# Architecture Independent Settings

# Functions
add_arm_x86_path_entry() {
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

add_arm_x86_variable_entry() {
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

# mac alert utility
export __ALERT_MAC_SOUND_NAME=Hero # See: /System/Library/Sounds/
alert-mac() {
    local title=""
    local subtitle=""
    local message=""

    # case - number of params
    case "$#" in
    1)
        message="$1"
        ;;
    2)
        title="$1"
        message="$2"
        ;;
    3)
        title="$1"
        subtitle="$2"
        message="$3"
        ;;
    *)
        echo "Usage: alert-mac [title] [subtitle] message"
        echo "       alert-mac title message"
        echo "       alert-mac message"
        return 1
        ;;
    esac

    # run AppleScript
    if [[ -n "$title" ]] && [[ -n "$subtitle" ]]; then
        osascript -e "display notification \"$message\" with title \"$title\" subtitle \"$subtitle\" sound name \"$__ALERT_MAC_SOUND_NAME\""
    elif [[ -n "$title" ]]; then
        osascript -e "display notification \"$message\" with title \"$title\" sound name \"$__ALERT_MAC_SOUND_NAME\""
    else
        osascript -e "display notification \"$message\" sound name \"$__ALERT_MAC_SOUND_NAME\""
    fi
}

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
    # source "$BREW_PREFIX/share/bash-completion/completions/cmake"
    source "$BREW_PREFIX/share/bash-completion/completions/pigz"
    source "$BREW_PREFIX/share/bash-completion/completions/psql"
    source "$BREW_PREFIX/share/bash-completion/completions/gzip"
    source "$BREW_PREFIX/share/bash-completion/completions/tar"
    source "$BREW_PREFIX/share/bash-completion/completions/htop"
fi

# ====================================================================== #

# Architecture Dependent Settings

JH_CURRENT_CPU=$(sysctl -a | grep machdep.cpu.brand_string | tr " " "\n" | grep M1)
if [[ $JH_CURRENT_CPU == "M1" ]]; then
    # M1 CPU
    for f in $JH_DOTFILES_DIR/bashrc/macos/apple_silicon/*.sh; do
        source "$f"
    done
fi
