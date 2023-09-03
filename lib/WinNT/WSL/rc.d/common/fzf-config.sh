__fzf_default_header="\
^G: Back | ^W: Reset filter | ^Space: Toggle mark | \
^A/^U: Toogle/unselect all marks | ^Y: Copy | ^O: Paste | \
?: Toggle Preview | Alt+J/K: Preview ↑/↓ | ^F/^B: Preview Page↑/↓ | \
^E/^V: Open in ${EDITOR}/VS Code"

export FZF_PROMPT_CHAR=' '

# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
# --color 'hl:${COL_FZF_HL},hl+:${COL_FZF_HL_PLUS},pointer:${COL_FZF_POINTER},marker:${COL_FZF_MARKER},bg+:${COL_FZF_BG_PLUS},header:${COL_FZF_HEADER},fg+:${COL_FZF_FG_PLUS}'
# --marker '﫠'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -i -g ""'
export FZF_DEFAULT_OPTS="
        -m
        --cycle
        --height 60%
        --layout reverse
        --border
        --line-range :50
        --inline-less
        --header '${__fzf_default_header}
        --header-first
        --preview '([[ -f {} ]] && (batcat --style=numbers --color=always {} || cat {})) 
                    || 
                ([[ -d {} ]] && (treex \"\.git\" {} || tree -aCI \"\.git\" {} | less less -n -q || less)) || less {}'
        --preview-window right:50%
        --pointer ''
        --prompt '${FZF_PROMPT_CHAR}'
        --less 'inline:  '
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
    --inline-less 
    --header '${__fzf_default_header}' 
    --header-first 
    --preview '([[ -f {} ]] && (batcat --style=numbers --color=always --line-range :50 {} || cat {})) 
                || 
            ([[ -d {} ]] && (treex {} | less less -n -q || less)) 
                || 
            echo {} 2> /dev/null | head -10 || less less -n -q {} || less {}' 
    --prompt '${FZF_PROMPT_CHAR}'"

export FZF_CTRL_C_COMMAND="${FD_FIND} "
export FZF_CTRL_T_COMMAND="${FD_FIND} "
export FZF_CTRL_T_OPTS="--type directory"

export FZF_CTRL_R_COMMAND="${FD_FIND} "
# export FZF_CTRL_R_OPTS="--preview-window :hidden"
export FZF_ALT_C_COMMAND="${FD_FIND} "

# use fd for finding directories and files
# export FZF_CHANGE_DIR_FIND_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_DIR_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_EDIT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# FZF_PREVIEW=--preview "([[ -f {} ]] && (batcat --style=numbers --color=always --line-range :100 {} || batcat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200"
# modify history command to remove duplicates

# # fzf in hidden files, optional arg: location
# fz() {
#     local location="${1}"
#     local cmd="fdfind --hidden --exclude \.git --color=always"
#     if [[ -z "${location}" ]]; then
#         cmd="${cmd} --strip-cwd-prefix"
#     else
#         cmd="${cmd} . ${location}"
#     fi
#     eval "${cmd}" |
#         ~/dotfiles/lib/fzf/fzf-tmux-digdown -p90% \
#             --bind "enter:execute([[ -f {} ]] && LESS='--RAW-CONTROL-CHARS' bat --paging=always {})" \
#             --bind "ctrl-r:reload(${cmd})" \
#             --header 'Enter: View with bat | ^R: Reload'
#     return 0
# }

# # Browse docker containers
# fzd() {
#     # Optionally: colorize log preview via ` | ccze -m ansi` (ccze needs to be installed first via apt install ccze)
#     local get_id="\$(echo {} | cut --delimiter=\" \" --fields=1)"
#     # Note: After arg query, we must use =. Otherwise and empty arg list won't work.
#     local opts="${FZF_DEFAULT_OPTS}
#             --preview 'docker logs ${get_id}'
#             --preview-window right:80%:hidden
#             --bind 'ctrl-e:execute(docker exec --interactive --tty ${get_id} bash < /dev/tty > /dev/tty)'
#             --bind 'alt-i:execute(docker inspect ${get_id} | batcat --language cjson --style numbers)'
#             --bind 'alt-e:execute(docker exec --user root ${get_id} bash -c \"apt-get update \
#                                     && apt-get install --yes curl micro telnet\" \
#                                     | bash && exec bash --login\")'
#             --bind 'enter:execute(docker logs ${get_id} | LESS=\"--RAW-CONTROL-CHARS\" less --LINE-NUMBERS +G)'
#             --bind 'alt-enter:execute(echo {} \
#                                         | tr --squeeze-repeats \" \" \
#                                         | cut --delimiter=\" \" --fields=2 \
#                                         | xargs dive)'
#             --bind 'ctrl-r:reload(docker ps --format \"table {{.ID}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}\")'
#             --query='$*'
#             --header '^E: Exec Bash | Alt+E: Install min apt pkgs | ^R: Reload | Alt+I: Inspect | Enter: Log | Alt+Enter: Dive'
#             --header-lines 1"
#     # ~/dotfiles/lib/fzf/fzf-tmux-digdown -p90%
#     docker-ps-format | FZF_DEFAULT_OPTS="${opts}"
#     return 0
# }
