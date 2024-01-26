# fzf (https://github.com/junegunn/fzf) required
#   more dependencies
#       - highlight (http://www.andre-simon.de/index.php)
#       - fd (https://github.com/sharkdp/fd)

#  ________ ________  ________
# |\  _____\\_____  \|\  _____\
# \ \  \__/ \|___/  /\ \  \__/
#  \ \   __\    /  / /\ \   __\
#   \ \  \_|   /  /_/__\ \  \_|
#    \ \__\   |\________\ \__\
#     \|__|    \|_______|\|__|
if [ -z ${ZSH+x} ]; then
    # run only this shell is not zsh
    [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

# export FZF_TMUX_OPTS='-p80%,60%'

# Using fd
if command -v "fd" >/dev/null 2>&1; then
    # https://github.com/junegunn/fzf#respecting-gitignore
    # ignore .gitignore
    export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

    # follow symlink, search hidden files
    # export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

    # uncomment this line if add above options
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
else
    echo "bashrc(fzf extension): fd command not exist - using default find command"
fi

# Check  highlight
if command -v "highlight" >/dev/null 2>&1; then
    echo -n ""
else
    echo "bashrc(fzf extension): highlight command not exist - using default cat command"
fi

# custom completion
_fzf_setup_completion path code
_fzf_setup_completion host ping

_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
    cd) fzf --border=bottom --preview "ls -l --color=always {}" "$@" ;;
    export | unset) fzf --border=bottom --preview "eval 'echo \$'{}" "$@" ;;
    vim)
        local FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --exclude node_module"
        fzf --border=none \
            --preview '[[ -d {} ]] && ls -l --color=always {} || (command -v "highlight" > /dev/null 2>&1 && highlight -O truecolor --style darkplus {} || cat {})' \
            "$@" # --preview-window right,100,border-horizontal \
        ;;
    *) fzf --border=bottom "$@" ;;
    esac
}
_fzf_setup_completion path ag cr

function fzf-man() {
    MAN="/usr/bin/man"
    if [ -n "$1" ]; then
        $MAN "$@"
        return $?
    else
        #$MAN -k . 2> /dev/null | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
        $MAN -k . 2>/dev/null |
            fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | awk '{print $1}' | sed -E 's/(\([0-9]+\))//' | xargs $MAN" |

            #fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" |\
            #awk '{print $1 "." $2}' |\
            awk '{print $1}' |
            sed -E 's/(\([0-9]+\))//' | xargs -r $MAN
        return $?
    fi
}

# pnpm run completion
_fzf_complete_pnr_alias() {
    local FZF_COMPLETION_TRIGGER=''
    local package_json=$(__find_package_json)
    _fzf_complete --no-multi \
        --reverse \
        --height=10 \
        --prompt="pnpm run ⚡️ " \
        --cycle \
        --preview "cat $package_json | jq -r '(\"⚡️ \" + .scripts[\"{}\"])' | highlight --syntax bash -O truecolor --style darkplus" \
        --border=bottom -- "$@" < <(
            # local package_json=$(__find_package_json)

            if [ -z "$package_json" ]; then
                echo "❌ package.json 못찾음 ❌"
                return 1
            fi

            cat $package_json | jq -r '.scripts | keys[] ' | sort
        )
}
[ -n "$BASH" ] && \
    command -v "pnpm" >/dev/null 2>&1 && \
    complete -F _fzf_complete_pnr_alias -o default -o bashdefault pnr

_fzf_complete_code_editor_open() {
    local FZF_COMPLETION_TRIGGER=''
    _fzf_complete --border=none \
        --height=30 \
        --reverse \
        --no-multi \
        --cycle \
        --marker='✅' \
        --preview '[[ -d {} ]] && (command -v "gls" > /dev/null 2>&1 && gls -l --color {} || ls -l --color=always {}) || \
             (command -v "highlight" > /dev/null 2>&1 && highlight -O truecolor --style darkplus {} || cat {})' -- "$@" < <(
            fd --type f --type d --strip-cwd-prefix --exclude node_modules --exclude .git --hidden
        )
}
[ -n "$BASH" ] && command -v "code" >/dev/null 2>&1 && complete -F _fzf_complete_code_editor_open -o default -o bashdefault code
[ -n "$BASH" ] && command -v "code" >/dev/null 2>&1 && complete -F _fzf_complete_code_editor_open -o default -o bashdefault cr
