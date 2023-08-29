#!/usr/bin/env zsh

# fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
# --color 'hl:${COL_FZF_HL},hl+:${COL_FZF_HL_PLUS},pointer:${COL_FZF_POINTER},marker:${COL_FZF_MARKER},bg+:${COL_FZF_BG_PLUS},header:${COL_FZF_HEADER},fg+:${COL_FZF_FG_PLUS}'
# --marker '﫠'
# use fdfind for finding directories and files
# export FZF_CHANGE_DIR_FIND_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_DIR_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_INSERT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_EDIT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
# modify history command to remove duplicates
# --preview '([[ -f {} ]] && (batcat --color=always {} || cat {}))
#             ||
#         ([[ -d {} ]] && (tree \"\.git\" {} || tree -aCI \"\.git\" {} | less info -n -q)) {}'

# export FZF_DEFAULT_COMMAND='fdfind --hidden -exclude ".git" --follow --color=always'

# export AG_DEFAULT_COMMAND='ag -i -l --hidden -g'
# export RG_DEFAULT_COMMAND='rg -i --pretty --hidden --no-ignore-vcs'

export FZF_DEFAULT_COMMAND='ag -i -l --hidden -g ""'

__fzf_default_header="\
^G: Back | ^W: Reset filter | ^Space: Toggle mark | \
^A/^U: Toogle/unselect all marks | ^Y: Copy | ^O: Paste | \
?: Toggle Preview | Alt+J/K: Preview ↑/↓ | ^F/^B: Preview Page↑/↓ | \
^E/^V: Open in ${EDITOR} | VS ${VISUAL}"

FZF_PROMPT=' '

FZF_PREVIEW="--preview '([[ -f {} ]] && (batcat --color=always -n -p {} | less)) || ([[ -d {} ]] && (treex {}) || (tree -C {} | less -R -f)) || echo {} 2> /dev/null | head -200'"

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
		--preview-window hidden:right:50%:wrap:border-vertical:~8' \
		--preview '${FZF_PREVIEW}' \
		--prompt '${FZF_PROMPT}' \
		--pointer ' ' \
		--marker '* ' \
		--bind '?:toggle-preview' \
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

# --pointer  \

FZF_TAB_OPTS="
		-m	\
		+i \
		-e \
		--ansi \
		--cycle \
		--border \
		--height ~30% \
        --reverse \
        --inline-info \
        --header-first \
        --header '${__fzf_default_header}' \
		--preview-window 'down,~4,border-vertical' \
		--prompt '${FZF_PROMPT}'
		--pointer '' \
		--marker '*' \
		--select-1 \
		--exit-0 \
		--bind '?:toggle-preview' \
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

# fzf settings. Uses fdfind for a faster alternative to `find`.
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_COMMAND='fdfind --hidden -exclude ".git" --follow --color=always'
export FZF_CTRL_T_OPTS="
		--preview 'batcat --color=always -n -p {}' \
		--preview-window down:~4:wrap \
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

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'treex {} || tree -C {} | head -200'"

zstyle ':fzf-tab:*' prefix "${FZF_PROMPT}"
zstyle ':fzf-tab:*' show-group full
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-bindings tab:accept
zstyle ':fzf-tab:*' accept-line enter
zstyle ':fzf-tab:*' continuous-trigger space
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:complete:*' disabled-on none
zstyle ':fzf-tab:user-expand::' fzf-preview 'less $word'
zstyle ':fzf-tab:user-expand::' fzf-flags '-m -e -i --ansi --inline-info --border --layout reverse --height 60% --pointer  --marker *'
# zstyle ':fzf-tab:complete:*' fzf-flags '${FZF_TAB_OPTS}'
# zstyle ':fzf-tab:complete:*' fzf-preview 'less ${realpath#-*=}'
# zstyle ':fzf-tab:complete:(\\|)(htop|px):argument-rest' fzf-flags '--preview-window=down:2:wrap'
# zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags '--preview-window=down:2:wrap'
# zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand)' fzf-flags '--preview-window=down:3:wrap'
# zstyle ':fzf-tab:complete:*' fzf-flags "${FZF_TAB_OPTS}"

zstyle ':fzf-tab:complete:*' fzf-bindings \
	'~:accept' \
	'ctrl-v:execute-silent(${_FTB_INIT_}code $realpath)' \
	'ctrl-e:execute-silent(${_FTB_INIT_}nvim $realpath)'

zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains|strace):argument-1|pudb:option--pre-run-1)' fzf-preview \
	'[[ $group == 'external command' ]] && less =$word'

# # Command
zstyle ':fzf-tab:complete:(-command-:|command:option-(v|V)-rest)' fzf-preview \
	'case $group in
            "external command") less $word
            ;;
            "executable file") less ${realpath#--*=}
            ;;
            "builtin command") run-help $word | batcat --color=always -n=8
            ;;
            parameter) echo ${(P)word}
            ;;
        esac'

zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
# -brace-parameter- will `fork/exec /usr/bin/zsh: invalid argument`
zstyle ':fzf-tab:complete:((-parameter-|unset):|(export|typeset|declare|local):argument-rest)' fzf-preview \
	'echo ${(P)word}'

zstyle ':fzf-tab:complete:(\\|)bindkey:option-M-1' fzf-preview \
	'case $group in
		keymap) bindkey -M$word | batcat --color=always -pltsv
		;;
	esac'

zstyle ':fzf-tab:complete:(\\|*/|)curl:argument-rest' fzf-preview \
	'curl -I $word 2>/dev/null | batcat --color=always -plyaml'

zstyle ':fzf-tab:complete:(\\|*/|)du:argument-rest' fzf-preview \
	'grc --colour=on du -sh $realpath'

# give a preview of commandline arguments when completing `kill` or 'ps'
zstyle ':fzf-tab:complete:(\\|*/|)(kill|ps):argument-rest' fzf-preview \
	'[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd,pid,user,comm -w -w'

zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'

zstyle ':fzf-tab:complete:(\\|)(px|htop):argument-rest' fzf-preview 'px --top'

zstyle ':fzf-tab:complete:(\\|)help:*' fzf-preview 'help $word'

zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'

zstyle ':fzf-tab:complete:cd:*' fzf-preview \
	'exa -1 --header --icons -l --only-dirs --group --git --all --links --color=always $realpath'

zstyle ':fzf-tab:complete:ls:*' fzf-preview \
	'exa -1 --header --icons -l --only-dirs --group --git --all --color=always $realpath'

zstyle ':fzf-tab:complete:(_z|_zi|zd|zdi):*' fzf-preview \
	'exa -1 --header --icons -l --only-dirs --group --git --all --links --color=always $realpath'

# zstyle ':fzf-tab:complete:less:*' fzf-preview \
# 'batcat --color=always -n=8'

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

zstyle ':fzf-tab:complete:gh:' fzf-preview 'gh help $word | batcat --color=always -n -plhelp'
zstyle ':fzf-tab:complete:(\\|*/|)npm:' fzf-preview 'npm help -l $word | batcat --color=always -n -l markdown'

zstyle ':fzf-tab:complete:pnpm:' fzf-preview 'pnpm help $word | batcat --color=always -n -l markdown'

# Docker
zstyle ':fzf-tab:complete:docker-container:argument-1' fzf-preview \
	'docker container $word --help | batcat --color=always'

zstyle ':fzf-tab:complete:docker-image:argument-1' fzf-preview \
	'docker image $word --help | batcat --color=always'

zstyle ':fzf-tab:complete:docker-inspect:' fzf-preview \
	'docker inspect $word | batcat --color=always'

zstyle ':fzf-tab:complete:docker-(run|images):argument-1' fzf-preview \
	'docker images $word batcat --color=always -n=4'

zstyle ':fzf-tab:complete:((\\|*/|)docker|docker-help):argument-1' fzf-preview \
	'docker help $word | batcat --color=always -n=4'

# df completion
zstyle ':fzf-tab:complete:(\\|*/|)df:argument-rest' fzf-preview \
	'[[ $group != "[device label]" ]] && grc --colour=on df -Th $word'

# scp
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

zstyle ':fzf-tab:complete:git-(diff|restore):*' fzf-preview \
	'git diff $word | batcat --color=always -n=6'

zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log $word | batcat --color=always -n=6'

zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | batcat --color=always -n=6'

zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case $group in
	        "commit tag") git show  $word | batcat --color=always
            ;;
	        *) git show $word | batcat --color=always -n=6
            ;;
	    esac'

zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case $group in
	        "modified file") git diff $word | batcat --color=always -n=6
            ;;
	        "recent commit object name") git show --color=always $word | batcat --color=always -n=6
            ;;
	        *) git log --color=always $word | batcat --color=always -n=6
            ;;
	    esac'

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
# 	# ~/dotfiles/lib/fzf/fzf-tmux-digdown -p90%
# 	docker-ps-format | FZF_DEFAULT_OPTS="${opts}"
# 	return 0
# }
