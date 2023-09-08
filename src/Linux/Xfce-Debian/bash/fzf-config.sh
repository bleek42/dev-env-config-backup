__fzf_default_header="\
^G: Back | ^W: Reset filter | ^Space: Toggle mark | \
^A/^U: Toogle/unselect all marks | ^Y: Copy | ^O: Paste | \
?: Toggle Preview | Alt+J/K: Preview ↑/↓ | ^F/^B: Preview Page↑/↓ | \
^E/^V: Open in ${EDITOR}/VS Code"

export FZF_PROMPT_CHAR=' '

# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
# --color 'hl:${COL_FZF_HL},hl+:${COL_FZF_HL_PLUS},pointer:${COL_FZF_POINTER},marker:${COL_FZF_MARKER},bg+:${COL_FZF_BG_PLUS},header:${COL_FZF_HEADER},fg+:${COL_FZF_FG_PLUS}'
# --marker '﫠'
if command -v ag >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -i -g ""'
    elif command -v rg >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='rg --hidden --ignore .git --files --no-ignore-vcs --glob "!.git/*"'
    elif command -v fdfind >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fdfind --hidden --exclude .git --exclude .cache'
    elif command -v fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd --hidden --exclude .git --exclude .cache'
    else
        export FZF_DEFAULT_COMMAND='find . -path "*/\.*" -prune -o -type f -print -o -type l -print 2> /dev/null | sed 1d'
fi
export FZF_DEFAULT_OPTS="
        -m
        --cycle
        --height 60%
        --layout reverse
        --border
        --line-range :50
        --inline-info
        --header '${__fzf_default_header}
        --header-first
        --preview '([[ -f {} ]] && (batcat --style=numbers --color=always {} || cat {}))
                    ||
                ([[ -d {} ]] && (treex \"\.git\" {} || tree -aCI \"\.git\" {} | less info -n -q || less)) || less {}'
        --preview-window right:50%
        --pointer ''
        --prompt '${FZF_PROMPT_CHAR}'
        --info 'inline:  '
        --bind '?:toggle-preview'
        --bind 'ctrl-space:toggle+down'
        --bind 'ctrl-a:toggle-all'
        --bind 'ctrl-x:deselect-all'
        --bind 'ctrl-e:execute(micro {+} < /dev/tty > /dev/tty)'
        --bind 'ctrl-v:execute(code.exe {+})'
        --bind 'alt-j:preview-down'
        --bind 'alt-k:preview-up'
        --bind 'ctrl-f:preview-page-down'
        --bind 'ctrl-b:preview-page-up'
        --bind 'ctrl-o:accept-non-empty'"

export FZF_TAB_OPTS="
    -m
    --height 40%
    --layout reverse
    --border
    --line-range :50
    --inline-info
    --header '${__fzf_default_header}'
    --header-first
    --preview '([[ -f {} ]] && (batcat --style=numbers --color=always --line-range :50 {} || cat {}))
                ||
            ([[ -d {} ]] && (treex {} | batcat || less))
                ||
            echo {} 2> /dev/null | head -10 || less -n -q {} || less {}'
    --prompt '${FZF_PROMPT_CHAR}'"

# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
export FZF_CTRL_T_COMMAND='fdfind --type f --hidden --exclude .git --exclude .cache'
export FZF_ALT_C_COMMAND='fdfind --type d --hidden --exclude .git']]']]']']'
# # use fd for finding directories and files
# export FZF_CHANGE_DIR_FIND_COMMAND="fdfind -t d"
# export FZF_INSERT_DIR_COMMAND="fdfind -t d"
# export FZF_INSERT_FILES_COMMAND="fdfind -t f"
# export FZF_EDIT_FILES_COMMAND="fdffind -t f"

# modify history command to remove duplicates
export FZF_HISTORY_COMMAND="fdfind -l 1 | sed  's/ *[0-9]*  //g' | awk '!seen[\$0]++'"
