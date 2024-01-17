#!/usr/bin/env zsh

# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
# --color 'hl:${COL_FZF_HL},hl+:${COL_FZF_HL_PLUS},pointer:${COL_FZF_POINTER},marker:${COL_FZF_MARKER},bg+:${COL_FZF_BG_PLUS},header:${COL_FZF_HEADER},fg+:${COL_FZF_FG_PLUS}'
# --marker '﫠'
# modify history command to remove duplicates
# --preview '([[ -f {} ]] && (bat --color=always {} || cat {}))
#             ||
#         ([[ -d {} ]] && (tree \"\.git\" {} || tree -aCI \"\.git\" {} | less info -n -q)) {}'

# export FZF_DEFAULT_COMMAND='fdfind --hidden -exclude ".git" --follow --color=always'

# export AG_DEFAULT_COMMAND='ag -i -l --hidden -g'
# export RG_DEFAULT_COMMAND='rg -i --pretty --hidden --no-ignore-vcs'
export FZF_DEFAULT_COMMAND='ag -i -l --hidden -g ""'

function dirs-treexa-bat() {
    if command -v exa >/dev/null 2>&1; then
        exa --all --long --group --links --time-style=long-iso --header --group-directories-first --color-scale --icons --tree --ignore-glob ".git" --color=always "$@" | bat --plain -n=6 --color=always
    else
        tree -aC -I '.git' --dirsfirst "$@" | bat --plain -n=6 --color=always
    fi
}

alias treex='dirs-treexa-bat'

__fzf_default_header="\
^G: BACK | ^W: RESET | ^Space: SELECT/UNSEL | \
^A/^U: SELECT/UNSEL ALL | ^Y: COPY | ^O: PASTE | \
^?: TOGGLE | Alt+J/K: PREVIEW ↑/↓ | ^F/^B: PAGE ↑/↓ | \
^E/^V: LAUNCH ${EDITOR} | VS${VISUAL}"

FZF_PROMPT=' '

FZF_PREVIEW="([[ -f {} ]] && (bat -f -p --color=always {} || cat {})) || ([[ -d {} ]] && (treexa {} | less -n -q)) || echo {} 2> /dev/null | head -40 | less {}"

export FZF_DEFAULT_OPTS="
		-i \
		-e \
		--ansi \
		--cycle \
        --reverse \
		--height ~60% \
		--margin 1% \
		--padding 1% \
        --inline-info \
        --header-first \
        --header '${__fzf_default_header}' \
		--border \
		--preview-window 'right,hidden,border-horizontal,~4' \
		--preview '${FZF_PREVIEW}' \
		--prompt '${FZF_PROMPT}' \
		--pointer ' ' \
		--marker '* ' \
        --select-1 \
        --exit-0 \
		--bind 'ctrl-?:toggle-preview' \
        --bind 'ctrl-space:toggle+down' \
        --bind 'ctrl-a:toggle-all' \
        --bind 'ctrl-x:deselect-all' \
        --bind 'ctrl-e:execute(nvim {+} < /dev/tty > /dev/tty)' \
        --bind 'ctrl-v:execute(code {+})' \
        --bind 'alt-j:preview-down' \
        --bind 'alt-k:preview-up' \
        --bind 'ctrl-f:preview-page-down' \
        --bind 'ctrl-b:preview-page-up' \
        --bind 'ctrl-o:accept-non-empty'"

# FZF_TAB_OPTS="
# 		-m	\
# 		+i \
# 		-e \
# 		--ansi \
# 		--cycle \
# 		--border \
# 		--height ~30% \
#         --reverse \
#         --inline-info \
#         --header-first \
#         --header '${__fzf_default_header}' \
# 		--preview-window 'down,~4,border-vertical' \
# 		--preview '([[ -f {} ]] && (bat -n --color=always {} || cat {}))
# 						||
# 					([[ -d {} ]] && (treex \"\.git\" {} || tree -aCI \"\.git\" {} | less info -n -q ||))
# 						||
# 					echo {} 2> /dev/null | head -10 | less {}' \
# 		--prompt '${FZF_PROMPT}'
# 		--pointer '' \
# 		--marker '*' \
# 		--select-1 \
# 		--exit-0 \
# 		--bind '?:toggle-preview' \
#         --bind 'ctrl-space:toggle+down' \
#         --bind 'ctrl-a:toggle-all' \
#         --bind 'ctrl-x:deselect-all' \
#         --bind 'ctrl-e:execute(nvim {+} < /dev/tty > /dev/tty)' \
#         --bind 'ctrl-v:execute(code {+})' \
#         --bind 'alt-j:preview-down' \
#         --bind 'alt-k:preview-up' \
#         --bind 'ctrl-f:preview-page-down' \
#         --bind 'ctrl-b:preview-page-up' \
#         --bind 'ctrl-o:accept-non-empty'"

# fzf settings. Uses fdfind for a faster alternative to `find`.
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_COMMAND='rg -i --pretty --hidden --no-ignore-vcs'
export FZF_CTRL_T_OPTS="
		--preview 'bat --color=always -n -p {}' \
		--preview-window 'down,wrap,~4' \
  		--bind 'ctrl-/:change-preview-window(down|hidden|)' \
  		--color header:italic \
  		--header '${__fzf_default_header}' \
		--header-first \
  		--select-1 \
  		--exit-0 "

# ? to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  		--preview 'echo {}' --preview-window down:~4:wrap \
  		--bind '?:toggle-preview' \
  		--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
  		--color header:italic \
  		--header 'Press CTRL-Y to copy command into clipboard'"

# use fdfind for finding directories and files
# export FZF_CHANGE_DIR_FIND_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_DIR_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_EDIT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'treex {} || tree -C {} | head -200'"

# fzf in hidden files, optional arg: location
fz() {
    local location="${1}"
    local cmd="fdfind --hidden --exclude \.git --color=always"
    if [[ -z "${location}" ]]; then
        cmd="${cmd} --strip-cwd-prefix"
    else
        cmd="${cmd} . ${location}"
    fi
    eval "${cmd}" |
        ~/dotfiles/lib/fzf/fzf-tmux-digdown -p90% \
            --bind "enter:execute([[ -f {} ]] && LESS='--RAW-CONTROL-CHARS' bat --paging=always {})" \
            --bind "ctrl-r:reload(${cmd})" \
            --header 'Enter: View with bat | ^R: Reload'
    return 0
}

# Browse docker containers
fzd() {
    # Optionally: colorize log preview via ` | ccze -m ansi` (ccze needs to be installed first via apt install ccze)
    local get_id="\$(echo {} | cut --delimiter=\" \" --fields=1)"
    # Note: After arg query, we must use =. Otherwise and empty arg list won't work.
    local opts="${FZF_DEFAULT_OPTS}
            --preview 'docker logs ${get_id}'
            --preview-window right:80%:hidden
            --bind 'ctrl-e:execute(docker exec --interactive --tty ${get_id} bash < /dev/tty > /dev/tty)'
            --bind 'alt-i:execute(docker inspect ${get_id} | bat --language cjson --style numbers)'
            --bind 'alt-e:execute(docker exec --user root ${get_id} bash -c \"apt-get update \
                                    && apt-get install --yes curl micro telnet\" \
                                    | bash && exec bash --login\")'
            --bind 'enter:execute(docker logs ${get_id} | LESS=\"--RAW-CONTROL-CHARS\" less --LINE-NUMBERS +G)'
            --bind 'alt-enter:execute(echo {} \
                                        | tr --squeeze-repeats \" \" \
                                        | cut --delimiter=\" \" --fields=2 \
                                        | xargs dive)'
            --bind 'ctrl-r:reload(docker ps --format \"table {{.ID}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}\")'
            --query='$*'
            --header '^E: Exec Bash | Alt+E: Install min apt pkgs | ^R: Reload | Alt+I: Inspect | Enter: Log | Alt+Enter: Dive'
            --header-lines 1"
    # ~/dotfiles/lib/fzf/fzf-tmux-digdown -p90%
    docker-ps-format | FZF_DEFAULT_OPTS="${opts}"
    return 0
}
