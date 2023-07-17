export EDITOR='micro'
export VISUAL='code.exe'
export PAGER='less'
export BAT_PAGER='less -Rf'
export MANPAGER='less -Rf'
export BROWSER='powershell.exe -command start'
export MANPAGER="sh -c 'col --no-backspaces --spaces | batcat --language=help --theme=ansi --plain'"
export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions
export FD_FIND="fdfind --hidden --no-ignore --exclude .git --follow --color always"
LESS_TERMCAP_md="$(tput setaf 136)"
[ -e "$LESS_TERMCAP_md" ] && export LESS_TERMCAP_md
# TREE_CMD="$(tree -aC -I '.git' --dirsfirst "$@" | batcat --plain)"
# [ -e "$TREE_CMD" ] && alias tree="${TREE_CMD}"
