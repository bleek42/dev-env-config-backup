#!/usr/bin/env zsh

if (( ! ${+functions[fzf-tab-complete]} )); then

    printf "ERROR: %s: fzf-tab-plugin must be loaded before %s\n" "${0##*/}" "${0##*/}" >&2
    printf "Could not find fzf-tab-complete function required to initiate tab completions..! \n"
    return 1
else
    printf "NOTE: fzf-tab keybinding detected: initializing relevant completions... \n"
    printf "NOTE: certain command completion behaviors may need additonal configuration and fine-tuning. \n"
    # zstyle ':completion:*' menu no
    # zstyle ':completion:*:*:*:*:*' menu no
    # (( ${+commands[tmux]})) && \
    #     zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

    ## ! NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
    zstyle ':fzf-tab:*' use-fzf-default-opts yes
    zstyle ':fzf-tab:*' prefix ' '
    zstyle ':fzf-tab:*' query-string input
    zstyle ':fzf-tab:*' show-group full
    zstyle ':fzf-tab:*' switch-group '<' '>'
    zstyle ':fzf-tab:*' accept enter
    zstyle ':fzf-tab:*' continuous-trigger space
    zstyle ':fzf-tab:*' fzf-bindings enter:accept
    zstyle ':fzf-tab:complete:*' disabled-on none

    zstyle ':fzf-tab:complete:*' fzf-bindings \
        '~:accept' \
        'ctrl-v:execute-silent(${_FTB_INIT_} $VISUAL $realpath)' \
        'ctrl-e:execute-silent(${_FTB_INIT_} $EDITOR $realpath)'

    # zstyle ':fzf-tab:complete:*' fzf-flags \
    #     '-m -e -i '

    zstyle ':fzf-tab:user-expand::' fzf-flags \
        '-m -e -i --layout=reverse --info=inline --preview-window=right:border-vertical:~4:wrap --pointer=" " --marker="* "'

    zstyle ':fzf-tab:complete:(\\|)(htop|btop):argument-rest' fzf-flags \
        '--preview-window=right:border-vertical:~5:wrap'

    zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags \
        '--preview-window=right:border-vertical:~5:wrap'

    ## * User expand
    zstyle ':fzf-tab:user-expand:' fzf-preview \
        'less -Rf $word'

    zstyle ':fzf-tab:complete:*' fzf-preview \
        'less -Rf ${realpath#-*=}'

    zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains|strace):argument-1|pudb:option--pre-run-1)' fzf-preview \
        '[[ $group == 'external command' ]] && less =$word'

        ## * command options
    zstyle ':fzf-tab:complete:(-command-:|command:option-(v|V)-rest)' fzf-preview \
        'case $group in
            *executable*) less ${realpath#--*=}
        ;;
            *builtin*) run-help $word | bat -f -p
        ;;
            *external*) less $word
        ;;
            *) echo ${(P)word}
        ;;
        esac'

    zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview \
        'echo ${(P)word}'

    # -brace-parameter- will `fork/exec /usr/bin/zsh: invalid argument`
    zstyle ':fzf-tab:complete:((-parameter-|unset):|(export|typeset|declare|local):argument-rest)' fzf-preview \
        'echo ${(P)word}'

    zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview \
        'man $word'

    zstyle ':fzf-tab:complete:(\\|)help:*' fzf-preview \
        'help $word'

    zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview \
        'run-help $word'

    zstyle ':fzf-tab:complete:(cd|zd):*' fzf-preview \
        'lsd --tree -I="*.git" --color=always --extensionsort --group-dirs=first -aA -d $realpath'

    zstyle ':fzf-tab:complete:(ls|lsd|exa|eza):*' fzf-preview \
        'lsd --tree -I="*.git" --color=always --extensionsort --group-dirs=first -aA -d $realpath'

    zstyle ':fzf-tab:complete:(\\|*/|)type:argument-rest' fzf-preview \
        'type $word'

    zstyle ':fzf-tab:complete:(\\|*/|)uname:options' fzf-preview \
        'uname $word | bat -p -l help'

    zstyle ':fzf-tab:complete:(\\|)bindkey:option-M-1' fzf-preview \
        'case $group in
		        keymap) bindkey -M $word | bat -f -p -l ini
		;;
	    esac'

    if (( ${+commands[dconf]} )); then

        zstyle ':fzf-tab:complete:(\\|*/|)dconf-list:' fzf-preview \
            'case $group in
                directory) dconf list $ctxt[hpre]$word
            ;;
            esac'

    fi

    zstyle ':fzf-tab:complete:(\\|*/|)tar:' fzf-preview \
        'tar tvaf $word'

    (( ${+commands[unzip]} )) && \
        zstyle ':fzf-tab:complete:(\\|*/|)unzip:argument-1' fzf-preview \
            '[[ -f $realpath ]] && unzip -Z $realpath || less $realpath'

    zstyle ':fzf-tab:complete:(\\|*/|)tput:set3-argument-1' fzf-preview \
        'tput $word'

    ## * curl completion sources, destinations, protocols
    zstyle ':fzf-tab:complete:(\\|*/|)curl:argument-rest' fzf-preview \
        'curl -I $word 2>/dev/null |  bat -f -p -l=yaml'

    ## * du completion
    zstyle ':fzf-tab:complete:(\\|*/|)du:argument-rest' fzf-preview \
        'grc --colour=on du -sh $realpath'

    ## * df completion
    zstyle ':fzf-tab:complete:(\\|*/|)df:argument-rest' fzf-preview \
        '[[ $group != "[device label]" ]] && grc --colour=on df -Th $word'

    ## * scp/rsync completion sources, destinations, protocols
    zstyle ':fzf-tab:complete:(\\|*/|)(ssh|scp|rsync):argument-rest' fzf-preview \
        'case $group in
            file) less ${realpath#--*=}
        ;;
            user) finger $word
        ;;
            *host*) grc --colour=on ping -c1 $word
        ;;
			*) echo ${(P)word}
        ;;
        esac'

    if (( ${+commands[systemctl]} )); then

        zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview \
            'SYSTEMD_COLORS=1 systemctl status $word'

        zstyle ':fzf-tab:complete:systemctl-show:*' fzf-preview \
            'systemctl show $word |  bat -f -p -l ini'

        zstyle ':fzf-tab:complete:systemctl-cat:*' fzf-preview \
            'systemctl cat $word |  bat -f -p -l=ini'

        zstyle ':fzf-tab:complete:systemctl-help:*' fzf-preview \
            'systemctl help $word 2>/dev/null |  bat -f -p -l=help'

        zstyle ':fzf-tab:complete:(\\|*/|)systemctl-list-dependencies:*' fzf-preview \
            'case $group in
                unit) SYSTEMD_COLORS=1 systemctl list-dependencies $word
            ;;
            esac'

    fi

        ## * journalctl logs
    if (( ${+commands[journalctl]} )); then

        zstyle ':fzf-tab:complete:(\\|*/|)journalctl:*' fzf-preview \
            'case $group in
                "boot "*) journalctl -b $word |  bat -f -p -l=log
            ;;
                "/dev files") journalctl -b /dev/$word |  bat -f -p -l=log
            ;;
                commands) journalctl $word | bat -f -p -l=log
            ;;
                "possible values") journalctl -u $word |  bat -f -p -l=log
            ;;
            esac'

    fi

        zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains|strace):argument-1|pudb:option--pre-run-1)' fzf-preview \
            '[[ $group == 'external command' ]] && bat -f -p $word'

        # give a preview of commandline arguments when completing `kill/all` or 'ps/px'
        zstyle ':fzf-tab:complete:(\\|*/|)(kill|killall|ps):argument-rest' fzf-preview \
            '[[ $group == "[process ID]" ]] && htop -d 16 --pid=$word || ps --pid=$word -o cmd,pid,user,comm -w -w'

    (( ${+commands[jq]} )) && \
        zstyle ':fzf-tab:complete:(\\|*/|)jq:argument-rest' fzf-preview \
            '[[ -f $realpath ]] && jq -Cr . $realpath 2>/dev/null || less $realpath'

    (( ${+commands[nmap]} )) && \
        zstyle ':fzf-tab:complete:(\\|*/|)nmap:argument-rest' fzf-preview 'nmap $word'

    (( ${+commands[ip]} )) && \
        zstyle ':fzf-tab:complete:(\\|*/|)ip:' fzf-preview \
            'case $group in
                'ip command') ip $word help 2>&1 |  bat -f -p -l help
            ;;
            esac'

    (( ${+commands[xdg-settings]} )) && \
        zstyle ':fzf-tab:complete:(\\|*/|)xdg-settings:' fzf-preview \
            'file=$(xdg-settings get $word)
            [[ -n $file ]] && less {/usr,~/.local,~/.local/state/nix/profile,/run/current-system/sw}/share/applications/$file(N)'

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

    if (( ${+commands[gh]} )); then

        zstyle ':fzf-tab:complete:gh:' fzf-preview 'gh help $word |  bat -f -p -l help'

    fi

    if (( ${+commands[apt]} )); then

        zstyle ':fzf-tab:complete:(\\|*/|)apt(|-cache):argument-rest' fzf-preview \
            'apt-cache show $word |  bat -f -p'

    fi

    if (( ${+commands[nala]} )); then

        zstyle ':fzf-tab:complete:(\\|*/|)nala(|-install):argument-rest' fzf-preview \
            'nala show $word |  bat -f -p'

    fi

    if (( ${+commands[npm]} )); then

        zstyle ':fzf-tab:complete:(\\|*/|)npm:' fzf-preview \
            'npm help -l $word |  bat -f -n -l markdown'

    fi

    if (( ${+commands[pnpm]} )); then

        zstyle ':fzf-tab:complete:pnpm:' fzf-preview \
            'pnpm help $word | bat -f -n -l markdown'

    fi


    if (( ${+commands[fastfetch]} )); then

        zstyle ':fzf-tab:complete:(\\|*/|)fastfetch:argument-rest' fzf-preview \
            'fastfetch $word |  bat -f -p'

    fi


    if (( ${+commands[progress]} )); then

        zstyle ':fzf-tab:complete:(\\|*/|)progress:*' fzf-preview \
            'case $group in
                "external command") progress -c $word
            ;;
                "process ID") progress -p $word
            ;;
            esac'

    fi

    if (( ${+commands[tmux]} )); then

        zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

        zstyle ':fzf-tab:complete:tmux-(show|set)-environment:argument-rest' fzf-preview \
            'tmux show-environment -g $word | bat -f -p -l=sh'

        zstyle ':fzf-tab:complete:tmux-(show-hooks|set-hook):argument-rest' fzf-preview \
            'tmux show-hook -g $word'

        zstyle ':fzf-tab:complete:tmux-(show-options|set-option):argument-rest' fzf-preview \
            'tmux show-options -gq $word | bat -f -p -l=tsv'

        zstyle ':fzf-tab:complete:tmux-(show-window-options|set-window-option):argument-rest' fzf-preview \
            'tmux show-window-options -g $word | bat -f -p -l=tsv'

        zstyle ':fzf-tab:complete:tmux:argument-rest' fzf-preview \
            'case $word in
                    (show|set)(env|-environment)) tmux ${word/set/show} -g | bat -f -p -l=sh
                ;;
                    (show|set)(-hook?|(-window)-option?|w|)) tmux ${word/set/show} -g | bat -f -p -l=tsv
                ;;
                    (show|set)(msgs|-message?)) tmux ${word/set/show} | bat -f -p -l=log
                ;;
                    (show|set)(b|-buffer)) tmux ${word/set/show}
                ;;
                    (ls|list-)*) tmux $word
                ;;
            esac'

    fi


    if (( ${+commands[zi]} )); then

        zstyle ':fzf-tab:complete:(\\|)zi-*' fzf-preview \
            'case $group in
                plugins) bat -f -l=md ~/.local/share/zsh/plugins/$word/README*
            ;;
                snippets) less ~/.local/share/zsh/snippets/$word/$word | grep "^alias" | cut -d" " -f2-
            ;;
                *) zi help $word | bat -f -p
            esac'

    fi

    if (( ${+commands[pacman]} )); then

        zstyle ':fzf-tab:complete:(\\|*/|)(pacman|paru|yay):(argument-(rest|1)|option-l-1)' fzf-preview \
            'case $group in
                "package file") less $realpath
            ;;
                (("installed "|)package|"local packages")) pacman -Qi $word | bat -lyaml
            ;;
                packages)
                    if (($+commands[paru])); then
                        paru -Si $word | bat -lyaml
                    elif (($+commands[yay])); then
                        yay -Si $word | bat -lyaml
                    else
                        pacman -Si $word | bat -lyaml
                    fi
            ;;
        esac'

    fi


    ## ? Docker
    if (( ${+commands[docker]} )); then

        zstyle ':fzf-tab:complete:docker-container:argument-1' fzf-preview \
            'docker container $word --help |  bat -f -p'

        zstyle ':fzf-tab:complete:docker-image:argument-1' fzf-preview \
            'docker image $word --help |  bat -f -p'

        zstyle ':fzf-tab:complete:docker-inspect:' fzf-preview \
            'docker inspect $word |  bat -f -p'

        zstyle ':fzf-tab:complete:docker-(run|images):argument-1' fzf-preview \
            'docker images $word |  bat -f -p'

        zstyle ':fzf-tab:complete:((\\|*/|)docker|docker-help):argument-1' fzf-preview \
            'docker help $word |  bat -f -p'

        # * fzf in hidden files, optional arg: location
        fz() {
            local location="${1}"
            local cmd
            if command -v fd >/dev/null 2>&1; then
                cmd='fd -tf --hidden --exclude ".git"'
            elif command -v rg >/dev/null 2>&1; then
                cmd='rg -S --hidden --files'
            else
                cmd='find -type f -path "*/\.*" -prune -o -print'
            fi

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
