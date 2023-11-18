#!/usr/bin/env zsh

# --preview '([[ -f {} ]] && (batcat -f {} || cat {}))
#             ||
#         ([[ -d {} ]] && (tree \"\.git\" {} || tree -aCI \"\.git\" {} | less info -n -q)) {}'

# export FD_DEFAULT_COMMAND='fdfind --hidden -exclude ".git" --follow -f'
# export AG_DEFAULT_COMMAND='ag -i -l --hidden -g'
# export RG_DEFAULT_COMMAND='rg -i --pretty --hidden --no-ignore-vcs'

export FZF_DEFAULT_COMMAND='ag -i -l --hidden -g ""'

# function dirs-treexa-batcat() {
#     if command -v exa >/dev/null 2>&1; then
#         exa --all --group --links --time-style=long-iso --header --color-scale --icons --tree --ignore-glob ".git" -f "$@" | batcat -f -n -p
#     else
#         tree -aC -I ".git" --dirsfirst "$@" | batcat -f -n
#     fi
# }

# alias treex='dirs-treexa-batcat'

__fzf_default_header="[^G: BACK | ^W: RESET | ^Space: SELECT/UNSEL | ^A/^U: SELECT/UNSEL ALL | ^Y: COPY | ^O: PASTE | ^?: TOGGLE | Alt+J/K: PREVIEW ↑/↓ | ^F/^B: PAGE ↑/↓ | ^E/^V: OPEN ${EDITOR}/VS${VISUAL}]"

fzf_prompt=' '

fzf_history_dir="${XDG_CACHE_HOME:-$HOME/.local/share}/fzf"

fzf_preview="
            ([[ -f {} ]] && (batcat -f -n -r :10 {})) || \
            ([[ -d {} ]] && (exa --all --group --links --time-style=long-iso --header --color-scale --icons --tree --ignore-glob ".git" | batcat -f -n -r :10 {})) || \
            echo {} 2> /dev/null | batcat -f -n -r :10"

export FZF_DEFAULT_OPTS="
		-i \
		-e \
		--ansi \
		--cycle \
		--border vertical\
        --reverse \
		--height 50% \
        --min-height 20 \
        --info inline \
        --header-first \
        --header-lines 4 \
        --header '${__fzf_default_header}' \
		--preview-window 'right:hidden:border-vertical:~6:wrap' \
		--preview '${fzf_preview}' \
		--prompt '${fzf_prompt}' \
		--history '${fzf_history_dir}' \
		--pointer ' ' \
		--marker '* ' \
        --select-1 \
        --exit-0 \
		--bind 'ctrl-/:toggle-preview' \
        --bind 'ctrl-space:toggle+down' \
        --bind 'ctrl-a:toggle-all' \
        --bind 'ctrl-u:deselect-all' \
        --bind 'ctrl-e:execute($EDITOR {+} < /dev/tty > /dev/tty)' \
        --bind 'ctrl-v:execute($VISUAL {+})' \
        --bind 'alt-j:preview-down' \
        --bind 'alt-k:preview-up' \
        --bind 'ctrl-f:preview-page-down' \
        --bind 'ctrl-b:preview-page-up' \
        --bind 'ctrl-o:accept-non-empty'"

# fzf settings. Uses fdfind for a faster alternative to `find`.
# Preview file content using batcat (https://github.com/sharkdp/batcat)
export FZF_CTRL_T_COMMAND='rg -i --pretty --hidden --no-ignore-vcs'
export FZF_CTRL_T_OPTS="
		--preview 'batcat -f -p {}' \
		--preview-window 'down:border-horizontal:~4:wrap' \
  		--color header:italic \
  		--bind 'ctrl-/:change-preview-window(down|hidden|)' \
		--header-first \
  		--select-1 \
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
export FZF_ALT_C_OPTS="
        --preview 'exa --all --links --time-style iso --header --color-scale --icons --tree {} | batcat -f -p'  --preview-window 'down:border-horizontal:~4:wrap'"

zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' prefix '${fzf_prompt}'
zstyle ':fzf-tab:*' show-group full
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' continuous-trigger space
zstyle ':fzf-tab:*' fzf-bindings tab:accept
zstyle ':fzf-tab:complete:*' disabled-on none
zstyle ':fzf-tab:complete:*' fzf-preview 'less ${realpath#-*=}'
# zstyle ':fzf-tab:user-expand::' fzf-flags '-m -e -i --layout reverse --info inline --preview-window right:border-vertical:~4:wrap --pointer=" " --marker "* "'
# zstyle ':fzf-tab:complete:(\\|)(htop|px):argument-rest' fzf-flags '--preview-window right:border-vertical:~4:wrap'
# zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window right:border-vertical:~4:wrap'

zstyle ':fzf-tab:complete:*' fzf-bindings \
	'~:accept' \
	'ctrl-v:execute-silent(${_FTB_INIT_} GUI $realpath)' \
	'ctrl-e:execute-silent(${_FTB_INIT_} TUI $realpath)'

zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains|strace):argument-1|pudb:option--pre-run-1)' fzf-preview \
	'[[ $group == 'external command' ]] && less =$word'

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

zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

# -brace-parameter- will `fork/exec /usr/bin/zsh: invalid argument`
zstyle ':fzf-tab:complete:((-parameter-|unset):|(export|typeset|declare|local):argument-rest)' fzf-preview \
	'echo ${(P)word}'

zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'

zstyle ':fzf-tab:complete:(\\|)help:*' fzf-preview 'help $word'

zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'

zstyle ':fzf-tab:complete:cd:*' fzf-preview \
	'exa --tree --header --icons -l --group --git --all --links $realpath 2>/dev/null | batcat -f -p'

zstyle ':fzf-tab:complete:(_z|_zi|z|zd|zdi|zda|zdh):*' fzf-preview \
	'exa --tree --header --icons -l --group --git --all --links $realpath 2>/dev/null | batcat -f -p'

zstyle ':fzf-tab:complete:ls:*' fzf-preview \
	'exa --tree --header --icons -l --only-dirs --group --git --all $realpath | batcat -f -p'

zstyle ':fzf-tab:complete:(\\|*/|)type:argument-rest' fzf-preview 'type $word'

zstyle ':fzf-tab:complete:(\\|*/|)uname:options' fzf-preview 'uname $word | bat --color=always -plhelp'

zstyle ':fzf-tab:complete:(\\|)bindkey:option-M-1' fzf-preview \
	'case $group in
		keymap) bindkey -M$word | batcat -f -pltsv
		;;
	esac'

zstyle ':fzf-tab:complete:(\\|*/|)tar:' fzf-preview 'tar tvaf $word'

zstyle ':fzf-tab:complete:(\\|*/|)unzip:argument-1' fzf-preview \
	'[[ -f $realpath ]] && unzip -Z $realpath || less $realpath'

zstyle ':fzf-tab:complete:(\\|*/|)tput:set3-argument-1' fzf-preview 'tput $word'

# curl completion sources, destinations, protocols
zstyle ':fzf-tab:complete:(\\|*/|)curl:argument-rest' fzf-preview 'curl -I $word 2>/dev/null | batcat -f -plyaml'

# du completion
zstyle ':fzf-tab:complete:(\\|*/|)du:argument-rest' fzf-preview 'grc --colour=on du -sh $realpath'

# df completion
zstyle ':fzf-tab:complete:(\\|*/|)df:argument-rest' fzf-preview \
	'[[ $group != "[device label]" ]] && grc --colour=on df -Th $word'

# scp/rsync completion sources, destinations, protocols
zstyle ':fzf-tab:complete:(\\|*/|)(scp|rsync):argument-rest' fzf-preview \
	'case $group in
            file) less ${realpath#--*=}
            ;;
            user) finger $word
            ;;
            *host*) grc --colour=on ping -c1 $word
            ;;
			*) echo ${(P)word}
        esac'

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

zstyle ':fzf-tab:complete:systemctl-show:*' fzf-preview 'systemctl show $word | batcat -f -plini'

zstyle ':fzf-tab:complete:systemctl-cat:*' fzf-preview 'systemctl cat $word | batcat -f -plini'

zstyle ':fzf-tab:complete:systemctl-help:*' fzf-preview 'systemctl help $word 2>/dev/null | batcat -f -plhelp'

zstyle ':fzf-tab:complete:(\\|*/|)systemctl-list-dependencies:*' fzf-preview \
	'case $group in
        unit) SYSTEMD_COLORS=1 systemctl list-dependencies $word
        ;;
    esac'

# journalctl logs
zstyle ':fzf-tab:complete:(\\|*/|)journalctl:*' fzf-preview \
	'case $group in
        'boot '*) journalctl -b $word | batcat -f -pllog
    ;;
        '/dev files') journalctl -b /dev/$word | batcat -f -pllog
    ;;
        commands) journalctl $word | bat --color=always -pllog
    ;;
        'possible values') journalctl -u $word | batcat -f -pllog
    ;;
esac'

zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains|strace):argument-1|pudb:option--pre-run-1)' fzf-preview \
	'[[ $group == 'external command' ]] && batcat -f -p $word'

# give a preview of commandline arguments when completing `kill` or 'ps'
zstyle ':fzf-tab:complete:(\\|*/|)(kill|killall|ps|px|htop):argument-rest' fzf-preview \
	'[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd,pid,user,comm -w -w'

zstyle ':fzf-tab:complete:less:*' fzf-preview 'batcat -f -p'

zstyle ':fzf-tab:complete:(\\|*/|)jq:argument-rest' fzf-preview \
	'[[ -f $realpath ]] && jq -Cr . $realpath 2>/dev/null || less $realpath'

zstyle ':fzf-tab:complete:(\\|*/|)nmap:argument-rest' fzf-preview 'nmap $word'

zstyle ':fzf-tab:complete:(\\|*/|)ip:' fzf-preview \
	'case $group in
        'ip command') ip $word help 2>&1 | batcat -f -plhelp
        ;;
    esac'

zstyle ':fzf-tab:complete:(\\|*/|)xdg-settings:' fzf-preview \
	'file=$(xdg-settings get $word)
    [[ -n $file ]] && less {/usr,~/.local,~/.local/state/nix/profile,/run/current-system/sw}/share/applications/$file(N)'

zstyle ':fzf-tab:complete:git-(diff|restore):*' fzf-preview 'git diff $word | batcat -f -n -r :10'

zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log $word | batcat -f -n -r :10'

zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | batcat -f -n -r :10'

zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case $group in
	        "commit tag") git show  $word | batcat -f -n -r :10
            ;;
	        *) git show $word | batcat -f -n -r :10
            ;;
	    esac'

zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case $group in
	        "modified file") git diff $word | batcat -f -n -r :10
            ;;
	        "recent commit object name") git show -f $word | batcat -f -n -r :10
            ;;
	        *) git log -f $word | batcat -f -n -r :10
            ;;
	    esac'

zstyle ':fzf-tab:complete:gh:' fzf-preview 'gh help $word | batcat -f -n -plhelp'

zstyle ':fzf-tab:complete:(\\|*/|)apt(|-cache):argument-rest' fzf-preview 'apt-cache show $word | batcat -f -p'

zstyle ':fzf-tab:complete:(\\|*/|)nala(|-install):argument-rest' fzf-preview 'nala show $word | batcat -f -p'

zstyle ':fzf-tab:complete:(\\|*/|)npm:' fzf-preview 'npm help -l $word | batcat -f -n -l markdown'

zstyle ':fzf-tab:complete:pnpm:' fzf-preview 'pnpm help $word | batcat -f -n -l markdown'

zstyle ':fzf-tab:complete:(\\|*/|)neofetch:argument-rest' fzf-preview 'neofetch $word | batcat -f -p'

zstyle ':fzf-tab:complete:(\\|*/|)progress:*' fzf-preview \
	'case $group in
        'external command') progress -c $word
        ;;
        'process ID') progress -p $word
        ;;
    esac'

zstyle ':fzf-tab:complete:tmux:argument-rest' fzf-preview \
	'case $word in
        (show|set)(env|-environment)) tmux ${word/set/show} -g | bat --color=always -plsh
        ;;
        (show|set)(-hook?|(-window)-option?|w|)) tmux ${word/set/show} -g | bat --color=always -pltsv
        ;;
        (show|set)(msgs|-message?)) tmux ${word/set/show} | bat --color=always -pllog
        ;;
        (show|set)(b|-buffer)) tmux ${word/set/show}
        ;;
        (ls|list-)*) tmux $word
        ;;
    esac'

# Docker
zstyle ':fzf-tab:complete:docker-container:argument-1' fzf-preview 'docker container $word --help | batcat -f -p'

zstyle ':fzf-tab:complete:docker-image:argument-1' fzf-preview 'docker image $word --help | batcat -f -p'

zstyle ':fzf-tab:complete:docker-inspect:' fzf-preview 'docker inspect $word | batcat -f -p'

zstyle ':fzf-tab:complete:docker-(run|images):argument-1' fzf-preview 'docker images $word | batcat -f -p'

zstyle ':fzf-tab:complete:((\\|*/|)docker|docker-help):argument-1' fzf-preview 'docker help $word | batcat -f -p'

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
