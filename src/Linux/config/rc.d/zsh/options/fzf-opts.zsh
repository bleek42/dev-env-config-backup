#!/usr/bin/env zsh

if command -v fzf >/dev/null 2>&1; then

    _fzf_comprun() {
        local command=$1
        shift

        case "${command}" in
        cd | zd)
            fd --hidden --type d --exclude ".git" . | fzf --preview 'lsd -d --tree -I=".git" -a {}' "$@"
            ;;
        export | set | unset | typeset)
            fzf --preview "eval 'echo \$'{}" "$@"
            ;;
        ssh)
            fzf --preview 'dig {}' "$@"
            ;;
        *)
            fzf --preview 'bat -f -p {}' "$@"
            ;;
        esac
    }

    _fzf_compgen_path() {
        rg --files --glob "!.git" . "$1"
    }

    _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
    }

    # Advanced customization of fzf options via _fzf_comprun function
    # - The first argument to the function is the name of the command.
    # - You should make sure to pass the rest of the arguments to fzf.
    _fzf_comprun() {
        local command=$1
        shift

        case "$command" in
        cd | zd)
            fzf --preview 'tree -C {} | head -200' "$@"
            ;;
        export | unset) ;;
        esac
    }

    # --preview '([[ -f {} ]] && ( bat -f {} || cat {}))
    #             ||
    #         ([[ -d {} ]] && (tree \"\.git\" {} || tree -aCI \"\.git\" {} | less info -n -q)) {}'

    # export FD_DEFAULT_COMMAND='fdfind --hidden -exclude ".git" --follow -f'
    # export AG_DEFAULT_COMMAND=''
    # export RG_DEFAULT_COMMAND='rg --column --line-number --no-heading --color=always --smart-case'

    typeset -g editor_symbol visual_symbol

    case "${EDITOR}" in
    *nvim*)
        editor_symbol=''
        ;;
    *vim*)
        editor_symbol=''
        ;;
    *)
        editor_symbol='󱔽'
        ;;
    esac

    case "${VISUAL}" in
    *codium* | *code*)
        visual_symbol='󰨞'
        ;;
    *)
        visual_symbol='󰘙'
        ;;
    esac

    # fd -H -i -L -d=4 --follow --stats --color=always -E="*.git" -g ""
    export FZF_DEFAULT_COMMAND='ag -S -l --hidden --ignore .git -g ""'

    __fzf_default_header="[^G: 󰱞 |^W:  |^SPC: 󰒅 |^A/^U: 󰒆 |^Y:  | ^O:  |^?:  |Alt+J/K: 󰏕/󰏔 |^F/^B: ↑/↓ |^E: ${editor_symbol} |^V: ${visual_symbol}]"

    # __fzf_default_colors='fg:#f0f0f0,bg:#252c31,bg+:#005f5f,hl:#87d75f,gutter:#252c31'
    # __fzf_default_info_colors='query:#ffffff,prompt:#f0f0f0,pointer:#dfaf00,marker:#00d7d7'

    __fzf_histfile="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/fzf-histfile"

    __fzf_preview_files='lsd --color=always -1 -aA -F -L --extensionsort --group-dirs=first '
    __fzf_preview_dirs='lsd --color=always --tree --blocks=permission,user,size,date,name -a -d'
    __fzf_default_preview="([[ -f {} ]] && (bat -f {} || cat {})) || \
                        ([[ -d {} ]] && (lsd --color=always --tree -A -F -d {}) || tree -C -a -f -L 2 {}) || \
                        echo {} 2> /dev/null | bat -f || echo {} 2> /dev/null | less -Rf"

    __fzf_colors_fg_bg="fg:#33cfad,fg+:#46e253,bg:#121212,bg+:#231f32"
    __fzf_colors_info_marker_hl="hl:#77c6d6,hl+:#3d9d47,info:#afaf87,marker:#5ed7d7"
    __fzf_colors_prompt_icons="prompt:#03ff1c,spinner:#1081f2,pointer:#8dee0e,header:#87afaf"
    __fzf_colors_border="gutter:#1d1717,border:#4afbfb"
    __fzf_colors_label="label:#aeaeae,query:#d9d9d"
    # --preview='${__fzf_default_preview}'

    export FZF_DEFAULT_OPTS="-i \
                -e \
                -m \
                --ansi \
                --cycle \
                --sync \
                --info='inline' \
                --border=sharp \
                --reverse \
                --height='60%' \
                --min-height='54' \
                --padding='2' \
                --margin='1' \
                --header-first \
                --header='${__fzf_default_header}' \
                --preview-window='right:50%:hidden:border-sharp:wrap:~4' \
                --preview='${__fzf_default_preview}' \
                --color='${__fzf_colors_fg_bg}','${__fzf_colors_info_marker_hl}','${__fzf_colors_prompt_icons}','${__fzf_colors_border}' \
                --history='${__fzf_histfile}' \
                --history-size=8000 \
                --prompt='' \
                --pointer='->' \
                --marker='*' \
                --select-1 \
                --exit-0 \
                --bind='ctrl-/:toggle-preview' \
                --bind='ctrl-space:toggle+down' \
                --bind='ctrl-a:toggle-all' \
                --bind='ctrl-u:deselect-all' \
                --bind='ctrl-e:execute($EDITOR {+} < /dev/tty > /dev/tty)' \
                --bind='ctrl-v:execute($VISUAL {+})' \
                --bind='alt-j:preview-down' \
                --bind='alt-k:preview-up' \
                --bind='ctrl-f:preview-page-down' \
                --bind='ctrl-b:preview-page-up' \
                --bind='ctrl-o:accept-non-empty'"

    # --color='${__fzf_colors_info_marker_hl}'
    # fzf settings. Uses fdfind for a faster alternative to `find`.
    # Preview file content using  bat (https://github.com/sharkdp/)bat
    export FZF_CTRL_T_COMMAND='rg --column --line-number --no-heading --color=always --smart-case ""'
    export FZF_CTRL_T_OPTS="\
                    --height 60% \
                    --border sharp \
                    --reverse \
                    --prompt '∷ ' \
                    --pointer '▶ ' \
                    --marker *"

    # ? to toggle small preview window to see the full command
    # CTRL-Y to copy the command into clipboard using pbcopy
    # export FZF_CTRL_R_OPTS="\
    #               --preview 'echo {}' --preview-window 'down:~4:wrap' \
    #         --header-first --header 'Press CTRL-Y to copy command into clipboard' \
    #               --color 'header:italic' --inline-info \
    #               --bind 'ctrl-/:toggle-preview' \
    #               --bind 'ctrl-x:execute-silent(echo -n {2..} | pbcopy)+abort'"

    # use fdfind for finding directories and files
    # export FZF_CHANGE_DIR_FIND_COMMAND="$FZF_DEFAULT_COMMAND"
    # export FZF_INSERT_DIR_COMMAND="$FZF_DEFAULT_COMMAND"
    # export FZF_INSERT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
    # export FZF_EDIT_FILES_COMMAND="$FZF_DEFAULT_COMMAND"
    # export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND}"

    # # Print tree structure in the preview window
    export FZF_ALT_C_COMMAND="${FZF_CTRL_T_COMMAND}"
    export FZF_ALT_C_OPTS="${FZF_CTRL_T_OPTS}"

    # zstyle ':complete:px:*:*:*:processes' command "px --top "

    # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
    is_ftb_key_binded="$(bindkey '^I' | grep -o 'fzf-tab-complete')"

    if [[ ${is_ftb_key_binded} == fzf-tab-complete ]]; then
        echo "fzf-tab keybinding detected: initializing relevant completions..."
        zstyle ':completion:*' menu no
        # zstyle ':completion:*:*:*:*:*' menu no
        zstyle ':fzf-tab:*' fzf-command fz
        zstyle ':fzf-tab:*' prefix ' '
        zstyle ':fzf-tab:*' query-string input
        zstyle ':fzf-tab:*' show-group full
        zstyle ':fzf-tab:*' switch-group '<' '>'
        zstyle ':fzf-tab:*' accept enter
        zstyle ':fzf-tab:*' continuous-trigger space
        zstyle ':fzf-tab:*' fzf-bindings enter:accept

        zstyle ':fzf-tab:complete:*' disabled-on none
        zstyle ':fzf-tab:complete:*' fzf-preview 'less ${realpath#-*=}'
        zstyle ':fzf-tab:user-expand::' fzf-flags '-m -e -i --layout reverse --info inline --preview-window right:border-vertical:~4:wrap --pointer=" " --marker "* "'
        # zstyle ':fzf-tab:complete:(\\|)(htop|px):argument-rest' fzf-flags '--preview-window right:border-vertical:~4:wrap'
        # zstyle ':fzf-tab:complete:(kill|ps|px):argument-rest' fzf-flags '--preview-window right:border-vertical:~4:wrap'

        # zstyle ':fzf-tab:*'

        zstyle ':fzf-tab:complete:*' fzf-bindings \
            '~:accept' \
            'ctrl-v:execute-silent(${_FTB_INIT_} $VISUAL $realpath)' \
            'ctrl-e:execute-silent(${_FTB_INIT_} $EDITOR $realpath)'

        # User expand
        # zstyle ':fzf-tab:user-expand:' fzf-preview 'less $word'

        zstyle ':fzf-tab:complete:*' fzf-preview 'less ${realpath#-*=}'

        zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains|strace):argument-1|pudb:option--pre-run-1)' fzf-preview \
            '[[ $group == 'external command' ]] && bat -f -p $word || less =$word'

        # # Command
        zstyle ':fzf-tab:complete:(-command-:|command:option-(v|V)-rest)' fzf-preview \
            'case $group in
            "executable file") less ${realpath#--*=}
                ;;
            "builtin command") run-help $word |  bat -f -p
                ;;
            "external command*) less $word
                ;;
            *) echo ${(P)word}
                ;;
        esac'

        zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

        # -brace-parameter- will `fork/exec /usr/bin/zsh: invalid argument`
        zstyle ':fzf-tab:complete:((-parameter-|unset):|(export|typeset|declare|local):argument-rest)' fzf-preview \
            'echo ${(P)word}'

        zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'

        zstyle ':fzf-tab:complete:(\\|)help:*' fzf-preview 'help $word'

        zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'

        zstyle ':fzf-tab:complete:(cd|zd):*' fzf-preview \
            'lsd --tree -I="*.git" --color=always --extensionsort --group-dirs=first -aA -d $realpath'

        zstyle ':fzf-tab:complete:(ls|lsd|exa|eza):*' fzf-preview \
            'lsd --tree -I="*.git" --color=always --extensionsort --group-dirs=first -aA -d $realpath'

        zstyle ':fzf-tab:complete:(\\|*/|)type:argument-rest' fzf-preview 'type $word'

        zstyle ':fzf-tab:complete:(\\|*/|)uname:options' fzf-preview 'uname $word | bat -p -l help'

        zstyle ':fzf-tab:complete:(\\|)bindkey:option-M-1' fzf-preview \
            'case $group in
		    keymap) bindkey -M $word | bat -f -p -l ini
		;;
	    esac'

        zstyle ':fzf-tab:complete:(\\|*/|)sqlite3:argument-1' fzf-preview \
            '[[ -f $realpath ]] && yes .q | sqlite3 $realpath | bat -lsql || less $realpath'

        zstyle ':fzf-tab:complete:(\\|*/|)tar:' fzf-preview 'tar tvaf $word'

        zstyle ':fzf-tab:complete:(\\|*/|)unzip:argument-1' fzf-preview \
            '[[ -f $realpath ]] && unzip -Z $realpath || less $realpath'

        zstyle ':fzf-tab:complete:(\\|*/|)tput:set3-argument-1' fzf-preview 'tput $word'

        zstyle ':fzf-tab:complete:(\\|)zmodload:argument-rest' fzf-preview \
            'case $group in
                'module file') zmodload -d $ctxt[hpre]$word
                ;;
        esac'

        # curl completion sources, destinations, protocols
        zstyle ':fzf-tab:complete:(\\|*/|)curl:argument-rest' fzf-preview \
            'curl -I $word 2>/dev/null |  bat -f -p -l=yaml'

        # du completion
        zstyle ':fzf-tab:complete:(\\|*/|)du:argument-rest' fzf-preview \
            'grc --colour=on du -sh $realpath'

        # df completion
        zstyle ':fzf-tab:complete:(\\|*/|)df:argument-rest' fzf-preview \
            '[[ $group != "[device label]" ]] && grc --colour=on df -Th $word'

        # scp/rsync completion sources, destinations, protocols
        zstyle ':fzf-tab:complete:(\\|*/|)(ssh|scp|rsync):argument-rest' fzf-preview \
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

        zstyle ':fzf-tab:complete:systemctl-show:*' fzf-preview 'systemctl show $word |  bat -f -p -l ini'

        zstyle ':fzf-tab:complete:systemctl-cat:*' fzf-preview 'systemctl cat $word |  bat -f -p -l ini'

        zstyle ':fzf-tab:complete:systemctl-help:*' fzf-preview 'systemctl help $word 2>/dev/null |  bat -f -p -l=help'

        zstyle ':fzf-tab:complete:(\\|*/|)systemctl-list-dependencies:*' fzf-preview \
            'case $group in
            unit) SYSTEMD_COLORS=1 systemctl list-dependencies $word
        ;;
        esac'

        zstyle ':fzf-tab:complete:(\\|*/|)bat:argument-rest' fzf-preview \
            'case $group in
            subcommand) bat cache --help
        ;;
            *) [[ -f ${realpath#--*=} ]] && bat ${realpath#--*=} || less ${realpath#--*=}
        ;;
        esac'

        # journalctl logs
        zstyle ':fzf-tab:complete:(\\|*/|)journalctl:*' fzf-preview \
            'case $group in
            'boot '*) journalctl -b $word |  bat -f -p -l=log
        ;;
            '/dev files') journalctl -b /dev/$word |  bat -f -p -l=log
        ;;
            commands) journalctl $word | bat -f -pllog
        ;;
            'possible values') journalctl -u $word |  bat -f -p -l=log
        ;;
        esac'

        # give a preview of commandline  arguments when completing `kill/all` or 'ps/px'
        zstyle ':fzf-tab:complete:(\\|*/|)(kill|killall|ps|px):argument-rest' fzf-preview \
            '[[ $group == "[process ID]" ]] && px --color --top || ps --pid=$word -o cmd,pid,user,comm -w -w'

        zstyle ':fzf-tab:complete:(\\|*/|)(pkill:o-argument-rest|killall:argument-1)' fzf-preview \
            'grc --colour=on ps -C$word'

        zstyle ':fzf-tab:complete:(\\|*/|)jq:argument-rest' fzf-preview \
            '[[ -f $realpath ]] && jq -Cr . $realpath 2>/dev/null || less $realpath'

        zstyle ':fzf-tab:complete:(\\|*/|)nmap:argument-rest' fzf-preview 'nmap $word'

        zstyle ':fzf-tab:complete:(\\|*/|)ip:' fzf-preview \
            'case $group in
                'ip command') ip $word help 2>&1 |  bat -f -p -l help
            ;;
        esac'

        zstyle ':fzf-tab:complete:(\\|*/|)gcc:*' fzf-preview \
            'case $group in
                'input file') gcc -o- -S $realpath | bat -lasm
            ;;
                help) gcc --help=$word | bat -f -l=help
            ;;
        esac'

        zstyle ':fzf-tab:complete:(\\|*/|)help2man:' fzf-preview \
            '[[ -f $realpath ]] && help2man $realpath | man --local-file - | bat -f -l=man || less $realpath'

        zstyle ':fzf-tab:complete:(\\|*/|)xdg-settings:' fzf-preview \
            'file=$(xdg-settings get $word)
            [[ -n $file ]] && less {/usr,~/.local,~/.local/state/nix/profile,/run/current-system/sw}/share/applications/$file(N)'

        zstyle ':fzf-tab:complete:(\\|*/|)dconf(|-help):' fzf-preview \
            'case $group in
                command) dconf help $word | bat -f -p -l=help
                ;;
            esac'

        zstyle ':fzf-tab:complete:(\\|*/|)dconf-list:' fzf-preview \
            'case $group in
                directory)
                # https://github.com/Aloxaf/fzf-tab/issues/325
                dconf list $ctxt[hpre]$word
            ;;
        esac'

        zstyle ':fzf-tab:complete:(\\|*/|)dconf-dump:' fzf-preview \
            'case $group in
                directory)
                # https://github.com/Aloxaf/fzf-tab/issues/325
                # no real toml
                dconf dump $ctxt[hpre]$word | bat -f -p -l=toml
            ;;
        esac'

        zstyle ':fzf-tab:complete:(\\|*/|)jq:argument-rest' fzf-preview \
            '[[ -f $realpath ]] && jq -Cr . $realpath 2>/dev/null || less $realpath'

        zstyle

        zstyle ':fzf-tab:complete:git-(diff|restore):*' fzf-preview 'git diff $word |  bat -f -r :16'

        zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log $word |  bat -f -r :16'

        zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word |  bat -f -r :16'

        zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
            'case $group in
	        "commit tag") git show  $word |  bat -f -n -r :16
            ;;
	        *) git show $word |  bat -f -n -r :16
            ;;
	    esac'

        zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
            'case $group in
	        "modified file") git diff $word |  bat -f -n -r :16
            ;;
	        "recent commit object name") git show -f $word |  bat -f -n -r :16
            ;;
	        *) git log -f $word |  bat -f -n -r :16
            ;;
	    esac'

        zstyle ':fzf-tab:complete:gh:' fzf-preview 'gh help $word |  bat -f -p -l help'

        zstyle ':fzf-tab:complete:(\\|*/|)apt(|-cache):argument-rest' fzf-preview 'apt-cache show $word |  bat -f -p'

        zstyle ':fzf-tab:complete:(\\|*/|)nala(|-install):argument-rest' fzf-preview 'nala show $word |  bat -f -p'

        zstyle ':fzf-tab:complete:(\\|*/|)npm:' fzf-preview 'npm help -l $word |  bat -f -n -l markdown'

        zstyle ':fzf-tab:complete:pnpm:' fzf-preview 'pnpm help $word | bat -f -n -l markdown'

        zstyle ':fzf-tab:complete:(\\|*/|)neofetch:argument-rest' fzf-preview 'neofetch $word |  bat -f -p'

        zstyle ':fzf-tab:complete:(\\|*/|)progress:*' fzf-preview \
            'case $group in
            'external command') progress -c $word
        ;;
            'process ID') progress -p $word
        ;;
        esac'

        zstyle ':fzf-tab:complete:(\\|*/|)pyenv:' fzf-preview \
            'pyenv help $word | bat -f -l=help'

        zstyle ':fzf-tab:complete:tmux-(show-window-options|set-window-option):argument-rest' fzf-preview \
            'tmux show-window-options -g $word | bat -l=tsv'

        zstyle ':fzf-tab:complete:tmux-(show-hooks|set-hook):argument-rest' fzf-preview \
            'tmux show-hook -g $word'

        zstyle ':fzf-tab:complete:tmux-(show-options|set-option):argument-rest' fzf-preview \
            'tmux show-options -gq $word | bat -l=tsv'

        zstyle ':fzf-tab:complete:tmux:argument-rest' fzf-preview \
            'case $word in
            (show|set)(env|-environment)) tmux ${word/set/show} -g | bat -f -p -l=sh
        ;;
            (show|set)(-hook?|(-window)-option?|w|)) tmux ${word/set/show} -g | bat -f -p -l=sv
        ;;
            (show|set)(msgs|-message?)) tmux ${word/set/show} | bat -f -p -l=log
        ;;
            (show|set)(b|-buffer)) tmux ${word/set/show}
        ;;
            (ls|list-)*) tmux $word
        ;;
        esac'

        zstyle ':fzf-tab:complete:(\\|)zi-*' fzf-preview \
            'case $group in
            plugins) bat -f -l=md ~/.local/share/zsh/plugins/$word/README*
        ;;
            )
        esac'

        # Docker
        zstyle ':fzf-tab:complete:docker-container:argument-1' fzf-preview 'docker container $word --help |  bat -f -p'

        zstyle ':fzf-tab:complete:docker-image:argument-1' fzf-preview 'docker image $word --help |  bat -f -p'

        zstyle ':fzf-tab:complete:docker-inspect:' fzf-preview 'docker inspect $word |  bat -f -p'

        zstyle ':fzf-tab:complete:docker-(run|images):argument-1' fzf-preview 'docker images $word |  bat -f -p'

        zstyle ':fzf-tab:complete:((\\|*/|)docker|docker-help):argument-1' fzf-preview 'docker help $word |  bat -f -p'

        # * fzf in hidden files, optional arg: location
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
                    --bind "enter:execute([[ -f {} ]] && LESS='--RAW-CONTROL-CHARS'  bat -f --paging=always {})" \
                    --bind "ctrl-r:reload(${cmd})" \
                    --header 'Enter: VIEW | ^R: RELOAD'
            return 0
        }

        # * Browse docker containers
        fzd() {
            # Optionally: colorize log preview via ` | ccze -m ansi` (ccze needs to be installed first via apt install ccze)
            local get_id="\$(echo {} | cut --delimiter=\" \" --fields=1)"
            # Note: After arg query, we must use =. Otherwise and empty arg list won't work.
            local opts="${FZF_DEFAULT_OPTS}
            --preview 'docker logs ${get_id}'
            --preview-window right:80%:hidden
            --bind 'ctrl-e:execute(docker exec --interactive --tty ${get_id} bash < /dev/tty > /dev/tty)'
            --bind 'alt-i:execute(docker inspect ${get_id} |  bat -n -f --language=cjson )'
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

    fi

fi
