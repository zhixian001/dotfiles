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
if command -v "fd" > /dev/null 2>&1; then
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
if command -v "highlight" > /dev/null 2>&1; then
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
    cd)           fzf --border=bottom --preview "ls -l --color=always {}"    "$@" ;;
    export|unset) fzf --border=bottom --preview "eval 'echo \$'{}"         "$@" ;;
    code|vim)     fzf --border=bottom --preview '[[ -d {} ]] && ls -l --color=always {} || (command -v "highlight" > /dev/null 2>&1 && highlight -O ansi {} || cat {})'     "$@" ;;
    *)            fzf --border=bottom "$@" ;;
  esac
}

function fzf-man(){
    MAN="/usr/bin/man"
    if [ -n "$1" ]; then
        $MAN "$@"
        return $?
    else
        #$MAN -k . 2> /dev/null | fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" | awk '{print $1 "." $2}' | tr -d '()' | xargs -r $MAN
        $MAN -k . 2> /dev/null |\
            fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | awk '{print $1}' | sed -E 's/(\([0-9]+\))//' | xargs $MAN" |\

            #fzf --reverse --preview="echo {1,2} | sed 's/ (/./' | sed -E 's/\)\s*$//' | xargs $MAN" |\
            #awk '{print $1 "." $2}' |\
            awk '{print $1}' |\
            sed -E 's/(\([0-9]+\))//' | xargs -r $MAN
        return $?
    fi
}

