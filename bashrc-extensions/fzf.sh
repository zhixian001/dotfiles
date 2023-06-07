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

# https://github.com/junegunn/fzf#respecting-gitignore
# ignore .gitignore
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'

# follow symlink, search hidden files
# export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# uncomment this line if add above options
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# custom completion
_fzf_setup_completion path code
_fzf_setup_completion host ping

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --border=bottom --preview "ls -l --color=always {}"    "$@" ;;
    export|unset) fzf --border=bottom --preview "eval 'echo \$'{}"         "$@" ;;
    code|vim)     fzf --border=bottom --preview '[[ -d {} ]] && ls -l --color=always {} || highlight -O ansi {}'     "$@" ;;
    *)            fzf --border=bottom "$@" ;;
  esac
}