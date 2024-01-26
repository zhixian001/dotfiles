__register_aliases_if_command_exist ls \
    "l='ls --color=auto'" \
    "ls='ls --color=auto'" \
    "ll='ls -l --color=auto'" \
    "la='ls -a --color=auto'" \
    "lla='ls -al --color=auto'"

__register_aliases_if_command_exist gls \
    "l='gls --color'" \
    "ls='gls --color'" \
    "ll='gls -l --color'" \
    "la='gls -a --color'" \
    "lla='gls -al --color'"
