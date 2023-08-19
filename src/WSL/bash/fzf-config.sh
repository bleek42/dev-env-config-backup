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

if [[ -n ${ZSH_VERSION} ]]; then
  zstyle ':fzf-tab:*' show-group full
  zstyle ':fzf-tab:*' switch-group 'F1' 'F2'
  zstyle ':fzf-tab:*' prefix ' '
  zstyle ':fzf-tab:*' continuous-trigger space

  zstyle ':fzf-tab:*' accept-line enter
  zstyle ':fzf-tab:complete:*' disabled-on none
  zstyle ':fzf-tab:complete:*' fzf-preview 'less ${(Q)realpath#-*=}'

  zstyle ':fzf-tab:complete:*' fzf-bindings \
    '~:accept' \
    'ctrl-v:execute-silent(${_FTB_INIT_}$VISUAL $realpath)' \
    'ctrl-e:execute-silent(${_FTB_INIT_}$EDITOR $realpath)'

  # Command
  zstyle ':fzf-tab:complete:(-command-:|command:option-(v|V)-rest)' fzf-preview \
    'case $group in
            "external command") batcat --style=numbers --color=always -n=4 $word || less
            ;;
            "executable file") batcat --style=numbers --color=always -n=4 ${realpath#--*=} || less -Rf ${realpath#--*=}
            ;;
            "builtin command") $word --help | batcat --color=always -n=4 || less -Rf
            ;;
            *) echo ${(P)word}
            ;;
        esac'

  # zstyle ':fzf-tab:complete:less:*' fzf-preview \
  #     'batcat --style=numbers --color=always || cat'
  # disable sort when completing `git checkout`

  zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --header --icons --group-directories-first --group --git --all --links --color=always $realpath'

  zstyle ':fzf-tab:complete:(_z|_zi|zd|zdi):*' fzf-preview 'exa -1 --header --icons --group-directories-first --group --git --all --links --color=always $realpath'

  zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
  zstyle ':fzf-tab:complete:(\\|*/|)(kill|ps):argument-rest' fzf-flags '--preview-window=down:4:wrap'

  # give a preview of commandline arguments when completing `kill` or 'ps'
  zstyle ':fzf-tab:complete:(\\|*/|)(kill|ps):argument-rest' fzf-preview \
    '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'

  zstyle ':fzf-tab:complete:px:*' fzf-preview \
    '[[ $group == "[process ID]" ]] && px --top --color $word | batcat --style=numbers --color=always -n=4'

  zstyle ':fzf-tab:complete:git-(diff|restore):*' fzf-preview 'git diff $word | batcat --style=numbers --color=always -n=6 || less'

  zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
    'git log --color=always $word | batcat --style=numbers --color=always -n=6 || less'

  zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | batcat --style=numbers --color=always -n=6 || less'

  zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
    'case $group in
	        "commit tag") git show  $word | batcat --style=numbers --color=always -n=12 || less
            ;;
	        *) git show $word | batcat --style=numbers --color=always -n=12 || less
            ;;
	    esac'

  zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
    'case $group in
	        "modified file") git diff $word | batcat --style=numbers --color=always || less
            ;;
	        "recent commit object name") git show --color=always $word | batcat --style=numbers --color=always -n=12 || less
            ;;
	        *) git log --color=always $word | batcat --style=numbers --color=always -n=12 || less
            ;;
	    esac'

  # Docker
  zstyle ':fzf-tab:complete:docker-container:argument-1' fzf-preview 'docker container $word --help | batcat --style=numbers --color=always -n=12'
  zstyle ':fzf-tab:complete:docker-image:argument-1' fzf-preview 'docker image $word --help | batcat --style=numbers --color=always -n=12'
  zstyle ':fzf-tab:complete:docker-inspect:' fzf-preview 'docker inspect $word | batcat --style=numbers --color=always -n=12'
  zstyle ':fzf-tab:complete:docker-(run|images):argument-1' fzf-preview 'docker images $word'
  zstyle ':fzf-tab:complete:((\\|*/|)docker|docker-help):argument-1' fzf-preview 'docker help $word | batcat --color=always -plhelp'
  # df
  zstyle ':fzf-tab:complete:(\\|*/|)df:argument-rest' fzf-preview \
    '[[ $group != "[device label]" ]] && grc --colour=on df -Th $word'

  # Go
  # zstyle ':fzf-tab:complete:(\\|*/|)go:argument-1' fzf-preview 'go help $word | batcat --color=always -plhelp'

  # Man
  zstyle ':fzf-tab:complete:(\\|*/|)man:' fzf-preview 'man $word | batcat --style=numbers --color=always -n=12 || less'

  # scp
  zstyle ':fzf-tab:complete:(\\|*/|)(scp|rsync):argument-rest' fzf-preview \
    'case $group in
            file) less ${realpath#--*=}
            ;;
            user) finger $word
            ;;
            *host*) grc --colour=on ping -c1 $word
            ;;
        esac'
fi

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
