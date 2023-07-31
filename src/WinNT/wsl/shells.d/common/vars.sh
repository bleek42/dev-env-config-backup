#!/usr/bin/env bash

export LESS='-R -F -i -J -M -W -x4 -z4'
export PAGER='less'
export LESSOPEN="|~/.lessfilter %s"
export BROWSER='powershell.exe -command start'
export MANPAGER="sh -c 'col -bx | batcat --style=numbers --language=help man -p || less man -p'"

# export FD_FIND='fdfind --hidden --no-ignore --exclude .git --follow --color always'
# LESS_TERMCAP_md="$(tput setaf 136)"
# [ -e "$LESS_TERMCAP_md" ] && export LESS_TERMCAP_md
# TREE_CMD="$(tree -aC -I '.git' --dirsfirst "$@" | batcat --plain)"
# [ -e "$TREE_CMD" ] && alias tree="${TREE_CMD}"
