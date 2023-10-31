#!/usr/bin/env zsh

# fzf settings
# --preview ([[ -f {} ]] && (bat --color=always -n -p {} || cat {})) || ([[ -d {} ]] && (tree -aCI {} | less)) || echo {} 2> /dev/null | head -200 | less {}

# export FZF_DEFAULT_COMMAND='fdfind --hidden -exclude ".git" --follow --color=always'
# export AG_DEFAULT_COMMAND='ag -i -l --hidden -g'
# export RG_DEFAULT_COMMAND='rg -i --pretty --hidden --no-ignore-vcs'
# FZF_DEFAULT_PREVIEW="([[ -f {} ]] && (bat --color=always -n -p {} || cat {}))
#               ||
#             ([[ -d {} ]] && (exa -lT --color-scale --icons {} | head -50 | less))
#               ||
#             echo {} 2> /dev/null | head -50 | less {}"

__fzf_default_header="\
[^G: Back| ^W: Reset| ^Space: Select| \
^A/^U: Select All/None| ^Y: Copy| ^O: Paste| \
^?: Show/Hide| Alt+J/K: ↑/↓| ^F/^B: Page↑/↓| \
^E/^V: Edit ${EDITOR}|VSCODE}"

FZF_DEFAULT_PREVIEW="([[ -f {} ]] && (bat --color=always -n -p {} || cat {})) || 
                     ([[ -d {} ]] && (tree -aCI {} | head -50)) ||
                     echo {} 2> /dev/null | head -50 | less {}"

FZF_HISTORY_DIR="${XDG_DATA_HOME:=$HOME/.local/share}/fzf"

FZF_DEFAULT_PROMPT=' '

export FZF_DEFAULT_COMMAND='ag -i -l --hidden -g ""'

export FZF_DEFAULT_OPTS="
                  -m	\
                  -i \
                  -e \
                  --ansi \
                  --cycle \
                  --border \
                  --reverse \
                  --height 50% \
                  --inline-info \
                  --header-first \
                  --header '${__fzf_default_header}' \
                  --preview-window=right,50%,border-vertical,hidden,wrap \
                  --preview '${FZF_DEFAULT_PREVIEW}' \
                  --prompt '${FZF_DEFAULT_PROMPT}' \
                  --history '${FZF_HISTORY_DIR}' \
                  --bind 'ctrl-/:toggle-preview' \
                  --bind 'ctrl-space:toggle+down' \
                  --bind 'ctrl-a:toggle-all' \
                  --bind 'ctrl-x:deselect-all' \
                  --bind 'ctrl-e:execute(neovim {+} < /dev/tty > /dev/tty)' \
                  --bind 'ctrl-v:execute(vscode {+})' \
                  --bind 'alt-j:preview-down' \
                  --bind 'alt-k:preview-up' \
                  --bind 'ctrl-f:preview-page-down' \
                  --bind 'ctrl-b:preview-page-up' \
                  --bind 'ctrl-o:accept-non-empty'"

# fzf settings. Uses ripgrep for a faster alternative to `find`.
# Preview file content using  bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_COMMAND='rg -i --pretty --hidden --no-ignore-vcs'
export FZF_CTRL_T_OPTS="
  	--bind 'ctrl-/:change-preview-window(down|hidden|)'
		--preview-window down:wrap:hidden:~4'
  	--header '${__fzf_default_header}'
		--preview 'bat --color=always -n -p {}'
  	--color header:italic
		--header-first
  	--select-1
  	--exit-0"

# ? to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
# export FZF_CTRL_R_OPTS="\
#   		--preview 'echo {}' --preview-window 'down:~4:wrap' \
#         --header-first --header 'Press CTRL-Y to copy command into clipboard' \
#   		--color 'header:italic' --inline-info \
#   		--bind 'ctrl-/:toggle-preview' \
#   		--bind 'ctrl-x:execute-silent(echo -n {2..} | pbcopy)+abort'"

# use fdfind for finding directories and files
# export FZF_CHANGE_DIR_FIND_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_DIR_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_EDIT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND}"

# # Print tree structure in the preview window
export FZF_ALT_C_COMMAND='rg -i --pretty --hidden --no-ignore-vcs'
export FZF_ALT_C_OPTS="--preview 'exa --all --links --time-style iso --header --color-scale --icons --tree {} | batcat -f -p'  --preview-window 'down:~4:border-horizontal:wrap'"

zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' prefix '$FZF_PROMPT'
zstyle ':fzf-tab:*' show-group full
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-bindings tab:accept
zstyle ':fzf-tab:*' accept-line enter
zstyle ':fzf-tab:*' continuous-trigger space
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:complete:*' disabled-on none
zstyle ':fzf-tab:complete:*' fzf-preview 'less ${realpath#-*=}'

# zstyle ':fzf-tab:user-expand:' fzf-preview 'less $word'
# zstyle ':fzf-tab:user-expand::' fzf-flags '-m -e -i --ansi --inline-info --border --layout reverse --height 50% --pointer  --marker *'
zstyle ':fzf-tab:complete:*' fzf-bindings '~:accept' \
    'ctrl-v:execute-silent(${_FTB_INIT_}code $realpath)' \
    'ctrl-e:execute-silent(${_FTB_INIT_}nvim $realpath)'

# zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand)' fzf-flags '--preview-window=hidden,down,40%,wrap'
# zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window=hidden,down,40%,wrap'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:less:*' fzf-preview 'bat --color=always -n=8 -p'

zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains|strace):argument-1|pudb:option--pre-run-1)' fzf-preview \
    '[[ $group == 'external command' ]] && bat -f -p $word'

# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --header --icons -l --only-dirs --group --all --links --color=always $realpath'

# zstyle ':fzf-tab:complete:ls:*' fzf-preview 'exa --header --icons -l --only-dirs --group --all --color=always $realpath'

zstyle ':fzf-tab:complete:(z|zi|zd|zdi):*' fzf-preview 'exa --header --icons -l --only-dirs --group --all --links --color=always $realpath'

zstyle ':fzf-tab:complete:((-parameter-|unset):|(export|typeset|declare|local):argument-rest)' fzf-preview \
    'echo ${(P)word}'

# # Command
zstyle ':fzf-tab:complete:(-command-:|command:option-(v|V)-rest)' fzf-preview \
    'case $group in
            "external command") less $word
            ;;
            "executable file") less ${realpath#--*=}
            ;;
            "builtin command") run-help $word | batcat -f -p
            ;;
            parameter) echo ${(P)word}
            ;;
        esac'

zstyle ':fzf-tab:complete:(\\|)bindkey:option-M-1' fzf-preview \
    'case $group in
		keymap) bindkey -M$word | bat --color=always -pltsv
		;;
	esac'

zstyle ':fzf-tab:complete:(\\|*/|)curl:argument-rest' fzf-preview \
    'curl -I $word 2>/dev/null | bat --color=always -plyaml'

zstyle ':fzf-tab:complete:(\\|*/|)du:argument-rest' fzf-preview \
    'grc --colour=on du -sh $realpath'

# give a preview of commandline arguments when completing `kill` or 'ps'
zstyle ':fzf-tab:complete:(\\|*/|)(kill|ps):argument-rest' fzf-preview \
    '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd,pid,user,comm -w -w'

zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'

zstyle ':fzf-tab:complete:(\\|)help:*' fzf-preview 'help $word'

zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'

<<<<<<< HEAD
zstyle ':fzf-tab:complete:(\\|)bindkey:option-M-1' fzf-preview \
    'case $group in
                keymap) bindkey -M$word | batcat -f -pltsv
                ;;
        esac'

# curl completion
zstyle ':fzf-tab:complete:(\\|*/|)curl:argument-rest' fzf-preview \
    'curl -I $word 2>/dev/null | batcat -f -plyaml'

# du completion
zstyle ':fzf-tab:complete:(\\|*/|)du:argument-rest' fzf-preview \
    'grc --colour=on du -sh $realpath'

# df completion
zstyle ':fzf-tab:complete:(\\|*/|)df:argument-rest' fzf-preview \
    '[[ $group != "[device label]" ]] && grc --colour=on df -Th $word'
=======
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

zstyle ':fzf-tab:complete:gh:' fzf-preview 'gh help $word | bat --color=always -n=4 -p -plhelp'
zstyle ':fzf-tab:complete:(\\|*/|)npm:' fzf-preview 'npm help -l $word | bat --color=always -n=4 -p -l markdown'

zstyle ':fzf-tab:complete:pnpm:' fzf-preview 'pnpm run-help $word | bat --color=always -n=4 -p -l markdown'

# Docker
zstyle ':fzf-tab:complete:docker-container:argument-1' fzf-preview \
    'docker container $word --help | bat --color=always -n=4 -p'

zstyle ':fzf-tab:complete:docker-image:argument-1' fzf-preview \
    'docker image $word --help | bat --color=always -n=4 -p'

zstyle ':fzf-tab:complete:docker-inspect:' fzf-preview \
    'docker inspect $word | bat --color=always -n=4 -p'

zstyle ':fzf-tab:complete:docker-(run|images):argument-1' fzf-preview \
    'docker images $word | bat --color=always -n=4 -p'

zstyle ':fzf-tab:complete:((\\|*/|)docker|docker-help):argument-1' fzf-preview \
    'docker help $word | bat --color=always -n=4 -p'

# df completion
zstyle ':fzf-tab:complete:(\\|*/|)df:argument-rest' fzf-preview \
    '[[ $group != "[device label]" ]] && grc --colour=on -Th $word'
>>>>>>> eeb0c53b83d2413dd0ef6bd0ecfb776c4876651a

# scp
zstyle ':fzf-tab:complete:(\\|*/|)(scp|rsync):argument-rest' fzf-preview \
    'case $group in
            file) less ${realpath#--*=}
            ;;
            user) finger $word
            ;;
            *host*) grc --colour=on ping -c1 $word
            ;;
<<<<<<< HEAD
            *) echo ${(P)word}
        esac'

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains|strace):argument-1|pudb:option--pre-run-1)' fzf-preview \
    '[[ $group == 'external command' ]] && batcat -f -p -n $word'

# give a preview of commandline arguments when completing `kill` or 'ps'
zstyle ':fzf-tab:complete:(\\|*/|)(kill|ps):argument-rest' fzf-preview \
    '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd,pid,user,comm -w -w'

zstyle ':fzf-tab:complete:(\\|*/)(px|htop):argument-rest' fzf-preview 'px --top'

zstyle ':fzf-tab:complete:less:*' fzf-preview 'batcat -f -p'

zstyle ':fzf-tab:complete:git-(diff|restore):*' fzf-preview \
    'git diff $word | batcat -f -n'

zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
    'git log $word | batcat -f -n'

zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
    'git help $word | batcat -f -n'

zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
    'case $group in
                "commit tag") git show  $word | batcat -f -n
            ;;
                *) git show $word | batcat -f -n
            ;;
            esac'

zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
    'case $group in
                "modified file") git diff $word | batcat -f -n
            ;;
                "recent commit object name") git show -f $word | batcat -f -n
            ;;
                *) git log -f $word | batcat -f -n
            ;;
            esac'

zstyle ':fzf-tab:complete:gh:' fzf-preview 'gh help $word | batcat -f -n -plhelp'

zstyle ':fzf-tab:complete:(\\|*/|)npm:' fzf-preview 'npm help -l $word | batcat -f -n -l markdown'

zstyle ':fzf-tab:complete:pnpm:' fzf-preview 'pnpm help $word | batcat -f -n -l markdown'

# Docker
zstyle ':fzf-tab:complete:docker-container:argument-1' fzf-preview \
    'docker container $word --help | batcat -f -p'

zstyle ':fzf-tab:complete:docker-image:argument-1' fzf-preview \
    'docker image $word --help | batcat -f -p'

zstyle ':fzf-tab:complete:docker-inspect:' fzf-preview \
    'docker inspect $word | batcat -f -p'

zstyle ':fzf-tab:complete:docker-(run|images):argument-1' fzf-preview \
    'docker images $word batcat -f -p'

zstyle ':fzf-tab:complete:((\\|*/|)docker|docker-help):argument-1' fzf-preview \
    'docker help $word | batcat -f -p'

# fzf in hidden files, optional arg: location
fz() {
    local location="${1}"
    local cmd="fdfind --hidden --exclude \.git -f"
    if [[ -z "${location}" ]]; then
        cmd="${cmd} --strip-cwd-prefix"
    else
        cmd="${cmd} . ${location}"
    fi
    eval "${cmd}" |
        fzf-tmux-digdown -p90% \
            --bind "enter:execute([[ -f {} ]] && LESS='--RAW-CONTROL-CHARS' batcat --color=auto --paging=always {})" \
            --bind "ctrl-r:reload(${cmd})" \
            --header 'Enter: VIEW | ^R: RELOAD'
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
            --bind 'alt-i:execute(docker inspect ${get_id} | batcat -n -f --language=cjson )'
            --bind 'alt-e:execute(docker exec --user root ${get_id} bash -c \"apt-get update \
                                    && apt-get install --yes curl telnet\" \
                                    | bash && exec bash --login\")'
            --bind 'enter:execute(docker logs ${get_id} | LESS=\"--RAW-CONTROL-CHARS\" less --LINE-NUMBERS +G)'
            --bind 'alt-enter:execute(echo {} \
                                        | tr --squeeze-repeats \" \" \
                                        | cut --delimiter=\" \" --fields=2 \
                                        | xargs dive)'
            --bind 'ctrl-r:reload(docker ps --format \"table {{.ID}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}\")'
            --query='$*'
            --header ' ^E: EXEC | Alt+E: PKGS | ^R: RELOAD | Alt+I: INSPECT | Enter: LOGS | Alt+Enter: DIVE'
            --header-lines 2"
    # ~/dotfiles/lib/fzf/fzf-tmux-digdown -p90%
    docker-ps-format | FZF_DEFAULT_OPTS="${opts}"
    return 0
}
=======
			*) echo ${(P)word}
        esac'

zstyle ':fzf-tab:complete:git-(diff|restore):*' fzf-preview \
    'git diff $word | bat --color=always -n=6 -p'

zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
    'git log $word | bat --color=always -n=6 -p'

zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
    'git help $word | bat --color=always -n=6 -p'

zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
    'case $group in
	        "commit tag") git show  $word | bat --color=always -n=6 -p
            ;;
	        *) git show $word | bat --color=always -n=6 -p
            ;;
	    esac'

zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
    'case $group in
	        "modified file") git diff $word | bat --color=always -n=6 -p
            ;;
	        "recent commit object name") git show --color=always $word | bat --color=always -n=6 -p
            ;;
	        *) git log --color=always $word | bat --color=always -n=6 -p
            ;;
	    esac'

# # # ? to toggle small preview window to see the full command
# # CTRL-Y to copy the command into clipboard using pbcopy
# export FZF_CTRL_R_OPTS="
#   		--preview 'echo {}' \
#   		--preview-window down:~4:wrap:hidden \
#   		--bind 'ctrl-/:toggle-preview' \
#   		--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' \
#   		--color header:italic \
#   		--header 'Press CTRL-Y to copy command into clipboard'"

# use fdfind for finding directories and files
# export FZF_CHANGE_DIR_FIND_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_DIR_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_EDIT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"

# # Print tree structure in the preview window
# export FZF_ALT_C_COMMAND=$FZF_DEFAULT_COMMAND
# export FZF_ALT_C_OPTS="tree -aCI {} | head -200 | less {}"
# # fzf in hidden files, optional arg: location
# fz() {
# 	local location="${1}"
# 	local cmd="fdfind --hidden --exclude \.git --color=always"
# 	if [[ -z "${location}" ]]; then
# 		cmd="${cmd} --strip-cwd-prefix"
# 	else
# 		cmd="${cmd} . ${location}"
# 	fi
# 	eval "${cmd}" |
# 		~/dotfiles/lib/fzf/fzf-tmux-digdown -p90% \
# 			--bind "enter:execute([[ -f {} ]] && LESS='--RAW-CONTROL-CHARS' bat --paging=always {})" \
# 			--bind "ctrl-r:reload(${cmd})" \
# 			--header 'Enter: View with bat | ^R: Reload'
# 	return 0
# }

# # Browse docker containers
# fzd() {
# 	# Optionally: colorize log preview via ` | ccze -m ansi` (ccze needs to be installed first via apt install ccze)
# 	local get_id="\$(echo {} | cut --delimiter=\" \" --fields=1)"
# 	# Note: After arg query, we must use =. Otherwise and empty arg list won't work.
# 	local opts="${FZF_DEFAULT_OPTS}
#             --preview 'docker logs ${get_id}'
#             --preview-window right:80%:hidden
#             --bind 'ctrl-e:execute(docker exec --interactive --tty ${get_id} bash < /dev/tty > /dev/tty)'
#             --bind 'alt-i:execute(docker inspect ${get_id} | bat --language cjson --style numbers)'
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
# 	# ~/dotfiles/lib/fzf/fzf-tmux-digdown -p90%
# 	docker-ps-format | FZF_DEFAULT_OPTS="${opts}"
# 	return 0
# }
>>>>>>> eeb0c53b83d2413dd0ef6bd0ecfb776c4876651a