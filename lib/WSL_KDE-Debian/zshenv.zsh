#!/usr/bin/env zsh

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
export LESS='-R -F -i -J -M -W -x4 -z4'
export EDITOR='/usr/bin/nvim'
export VISUAL='code.exe'
export LESSOPEN="|~/.lessfilter %s 2>&-"
export BROWSER='powershell.exe -command start'
export MANROFFOPT=-c
export MANPAGER=$'/bin/sh -c \'col -b | batcat -p -l man\''

# export NODE_PRESERVE_SYMLINKS=1
# export FD_FIND='fdfind --hidden --no-ignore --exclude .git --follow --color always'
# LESS_TERMCAP_md="$(tput setaf 136)"
# [ -e "$LESS_TERMCAP_md" ] && export LESS_TERMCAP_md
# TREE_CMD="$(tree -aC -I '.git' --dirsfirst "$@" | batcat --plain)"
# [ -e "$TREE_CMD" ] && alias tree="${TREE_CMD}"
