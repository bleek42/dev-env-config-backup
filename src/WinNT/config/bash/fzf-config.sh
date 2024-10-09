#!/usr/bin/env bash

__fzf_default_header="\
^G: Back | ^W: Reset filter | ^Space: Toggle mark | \
^A/^U: Toogle/unselect all marks | ^Y: Copy | ^O: Paste | \
?: Toggle Preview | Alt+J/K: Preview ↑/↓ | ^F/^B: Preview Page↑/↓ | \
^E/^V: Open w/ ${EDITOR:-vim}/${VISUAL:-code}"

FZF_PROMPT=' '

FZF_PREVIEW="'([[ -f {} ]] && (bat -f -p {} | less -R -f)) || ([[ -d {} ]] && (lsd --tree {} | less -R -f)) || echo {} 2> /dev/null | head -200'"
# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
# --color 'hl:${COL_FZF_HL},hl+:${COL_FZF_HL_PLUS},pointer:${COL_FZF_POINTER},marker:${COL_FZF_MARKER},bg+:${COL_FZF_BG_PLUS},header:${COL_FZF_HEADER},fg+:${COL_FZF_FG_PLUS}'
# --marker '﫠'
export FZF_DEFAULT_COMMAND='fd --hidden --ignore=".git" -i'

export FZF_DEFAULT_OPTS="\
        -m \
        --cycle \
        --height=50% \
        --layout=reverse \
        --border \
        --header=${__fzf_default_header} \
        --header-first \
        --preview-window=down:50%:wrap:~4 \
        --preview=${FZF_PREVIEW} \
        --pointer='' \
        --prompt=${FZF_PROMPT} \
        --bind='ctrl+?:toggle-preview' \
        --bind='ctrl-space:toggle+down' \
        --bind='ctrl-a:toggle-all' \
        --bind='ctrl-x:deselect-all' \
        --bind='ctrl-e:execute(vim {+} < /dev/tty > /dev/tty)' \
        --bind='ctrl-v:execute(code {+})' \
        --bind='alt-j:preview-down' \
        --bind='alt-k:preview-up' \
        --bind='ctrl-f:preview-page-down' \
        --bind='ctrl-b:preview-page-up' \
        --bind='ctrl-o:accept-non-empty'"

# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
# --color 'hl:${COL_FZF_HL},hl+:${COL_FZF_HL_PLUS},pointer:${COL_FZF_POINTER},marker:${COL_FZF_MARKER},bg+:${COL_FZF_BG_PLUS},header:${COL_FZF_HEADER},fg+:${COL_FZF_FG_PLUS}'
# --marker '﫠'
# use fdfind for finding directories and files
# export FZF_CHANGE_DIR_FIND_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_DIR_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_EDIT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# modify history command to remove duplicates
# --preview '([[ -f {} ]] && (batcat -f {} || cat {}))
#             ||
#         ([[ -d {} ]] && (tree \"\.git\" {} || tree -aCI \"\.git\" {} | less info -n -q)) {}'

# export FZF_DEFAULT_COMMAND='fdfind --hidden -exclude ".gf--color=always'
# --pointer  \
# --border \
