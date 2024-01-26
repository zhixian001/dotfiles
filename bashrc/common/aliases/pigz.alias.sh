__register_aliases_if_command_exist pigz \
    "tarpigz='tar --use-compress-program=\"pigz -k \" -cf'" \
    "tarunpigz='tar --use-compress-program=\"unpigz -k\" -xf'"
