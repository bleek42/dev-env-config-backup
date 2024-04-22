#!/usr/bin/env zsh

# ## ? Should be called before compinit
# zmodload zsh/complist

zstyle ':completion:*' menu select interactive
## ? Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true
zstyle ':completion:*' rehash true
zstyle ':completion:*' keep-prefix true

zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-${HOME}/.cache}/zi/zcompdump"
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:options' auto-description '%d'
## ? Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

## ? Define completers
zle -C alias-expension complete-word _generic
bindkey '^a' alias-expension
zstyle ':completion:alias-expension:*' completer _expand _alias
zstyle ':completion:*' completer _expand _extensions _complete _approximate

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' file-sort modification
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
# bindkey '^Xa' alias-expension

# zstyle ':completion:alias-expension:*' completer _alias _generic
## ? Required for completion to be in good groups (named after the tags)
# zstyle ':completion:*' group-name ''

## ! disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false

zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

## ! Only display some tags for the command cd
zstyle ':completion:*:*:(cd|zd|zi):*' tag-order local-directories directory-stack path-directories

zstyle ':completion:*:*:(ls|exa|eza):*'

## ! disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts \
    'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

zstyle ':completion:*:kill:*' command 'ps -u ${USER} -o pid,%cpu,tty,cputime,cmd -w -w '
# zstyle ':completion:*:*:px:*' command 'px --top '
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

if command -v fzf >/dev/null 2>&1; then
    # echo "init fzf completion options..."

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
        cd)
            fzf --preview 'tree -C {} | head -200' "$@"
            ;;
        export | unset)
            fzf --preview "eval 'echo \$'{}" "$@"
            ;;
        ssh)
            fzf --preview 'dig {}' "$@"
            ;;
        *) fzf --preview 'bat -n --color=always {}' "$@" ;;
        esac
    }

    # --preview '([[ -f {} ]] && ( bat -f {} || cat {}))
    #             ||
    #         ([[ -d {} ]] && (tree \"\.git\" {} || tree -aCI \"\.git\" {} | less info -n -q)) {}'

    # export FD_DEFAULT_COMMAND='fdfind --hidden -exclude ".git" --follow -f'
    # export AG_DEFAULT_COMMAND=''
    # export RG_DEFAULT_COMMAND='rg -i --pretty --hidden --no-ignore-vcs'

    editor_symbol=

    case "${EDITOR}" in
    *nvim*)
        editor_symbol="\\Ue6ae"
        ;;
    *vim*)
        editor_symbol="\\Ue62b"
        ;;
    *)
        editor_symbol="\\Uf153d"
        ;;
    esac

    visual_symbol=

    case "${VISUAL}" in
    *codium* | *code*)
        visual_symbol="\\Ue62b"
        ;;
    *)
        visual_symbol="\\Uf044"
        ;;
    esac
    # fd -H -i -L -d 3 --color=always -g
    export FZF_DEFAULT_COMMAND='fd -H -i -L -d=4 --follow --stats --color=always -E="*.git" -g'

    __fzf_default_header="[ ^G: 󰱞 | ^W:  | ^Space: 󰒅 | ^A/^U: 󰒆 | ^Y:  | ^O:  | ^?:  | Alt+J/K: 󱗖 ↑/↓ | ^F/^B: PG ↑/↓ | ^E: ${editor_symbol} | ^V: ${visual_symbol} ]"

    fzf_default_colors='fg:#f0f0f0,bg:#252c31,bg+:#005f5f,hl:#87d75f,gutter:#252c31'
    fzf_default_info_colors='query:#ffffff,prompt:#f0f0f0,pointer:#dfaf00,marker:#00d7d7'

    fzf_histfile="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/fzf-histfile"

    # fzf_default_preview="([[ -f {} ]] && (bat -f {})) || \
    #                     ([[ -d {} ]] && (eza -T -a -@ --smart-group --reverse --git-ignore --icons --color-scale {} | bat -f)) || \
    #                 echo {} 2> /dev/null | bat -f"

    # --preview '${fzf_default_preview}' \
    export FZF_DEFAULT_OPTS="\
                -i \
                -e \
                --ansi \
                --cycle \
                --border vertical\
                --reverse \
                --height 50% \
                --min-height 25 \
                --info inline \
                --header-first \
                --header-lines 2 \
                --header '${__fzf_default_header}' \
                --preview-window 'hidden:border-vertical:wrap:~4' \
                --color '${fzf_default_colors}'\
                --history '${fzf_histfile}' \
                --prompt ' ' \
                --pointer '->' \
                --marker * \
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
    # Preview file content using  bat (https://github.com/sharkdp/)bat
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_CTRL_T_OPTS="\
                    --height 60% \
                    --border sharp \
                    --layout reverse \
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
    export FZF_ALT_C_COMMAND=='rg -i --pretty --hidden --no-ignore-vcs'
    export FZF_ALT_C_OPTS="$FZF_CTRL_T_OPTS"

    # if command -v ftb- >/dev/null 2>&1; then

    # fi

    # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
    zstyle ':completion:*' menu no

    # zstyle ':complete:px:*:*:*:processes' command "px --top "

    zstyle ':fzf-tab:*' fzf-command fzf
    zstyle ':fzf-tab:*' prefix ' '
    zstyle ':fzf-tab:*' show-group full
    zstyle ':fzf-tab:*' switch-group '<' '>'
    # zstyle ':fzf-tab:*' accept enter
    zstyle ':fzf-tab:*' continuous-trigger space
    zstyle ':fzf-tab:*' fzf-bindings enter:accept
    # zstyle ':fzf-tab:*'

    zstyle ':fzf-tab:complete:_zlua:*' query-string input
    zstyle ':fzf-tab:complete:*' disabled-on none

    zstyle ':fzf-tab:complete:*' fzf-bindings \
        '~:accept' \
        'ctrl-v:execute-silent(${_FTB_INIT_} $VISUAL $realpath)' \
        'ctrl-e:execute-silent(${_FTB_INIT_} $EDITOR $realpath)'

    # User expand
    # zstyle ':fzf-tab:user-expand:' fzf-preview 'less $word'

    zstyle ':fzf-tab:complete:*' fzf-preview 'less ${realpath#-*=}'

    zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains|strace):argument-1|pudb:option--pre-run-1)' fzf-preview \
        '[[ $group == 'external command' ]] && less =$word'

    # # Command
    zstyle ':fzf-tab:complete:(-command-:|command:option-(v|V)-rest)' fzf-preview \
        'case $group in
            "external command") less $word
            ;;
            "executable file") less ${realpath#--*=}
            ;;
            "builtin command") run-help $word |  bat -f -p
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

    zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color=always -I="*.git" --header -r -A -F $realpath'

    zstyle ':fzf-tab:complete:(_z|_zi|z|zd|zdi|zda|zdh):*' fzf-preview 'lsd --color=always -I="*.git" --header -r -A -F $realpath'

    zstyle ':fzf-tab:complete:(ls|lsd|exa|eza):*' fzf-preview 'lsd --color=always -I="*.git" --header --tree --depth=2 -r -A -F $realpath'

    zstyle ':fzf-tab:complete:(\\|*/|)type:argument-rest' fzf-preview 'type $word'

    zstyle ':fzf-tab:complete:(\\|*/|)uname:options' fzf-preview 'uname $word | bat -plhelp'

    zstyle ':fzf-tab:complete:(\\|)bindkey:option-M-1' fzf-preview \
        'case $group in
		keymap) bindkey -M$word |  bat -f -pltsv
		;;
	esac'

    zstyle ':fzf-tab:complete:(\\|*/|)tar:' fzf-preview 'tar tvaf $word'

    zstyle ':fzf-tab:complete:(\\|*/|)unzip:argument-1' fzf-preview \
        '[[ -f $realpath ]] && unzip -Z $realpath || less $realpath'

    zstyle ':fzf-tab:complete:(\\|*/|)tput:set3-argument-1' fzf-preview 'tput $word'

    # curl completion sources, destinations, protocols
    zstyle ':fzf-tab:complete:(\\|*/|)curl:argument-rest' fzf-preview 'curl -I $word 2>/dev/null |  bat -f -plyaml'

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

    zstyle ':fzf-tab:complete:systemctl-show:*' fzf-preview 'systemctl show $word |  bat -f -plini'

    zstyle ':fzf-tab:complete:systemctl-cat:*' fzf-preview 'systemctl cat $word |  bat -f -plini'

    zstyle ':fzf-tab:complete:systemctl-help:*' fzf-preview 'systemctl help $word 2>/dev/null |  bat -f -plhelp'

    zstyle ':fzf-tab:complete:(\\|*/|)systemctl-list-dependencies:*' fzf-preview \
        'case $group in
        unit) SYSTEMD_COLORS=1 systemctl list-dependencies $word
        ;;
    esac'

    # journalctl logs
    zstyle ':fzf-tab:complete:(\\|*/|)journalctl:*' fzf-preview \
        'case $group in
        'boot '*) journalctl -b $word |  bat -f -pllog
    ;;
        '/dev files') journalctl -b /dev/$word |  bat -f -pllog
    ;;
        commands) journalctl $word | bat -f -pllog
    ;;
        'possible values') journalctl -u $word |  bat -f -pllog
    ;;
esac'

    zstyle ':fzf-tab:complete:(-equal-:|(\\|*/|)(sudo|proxychains|strace):argument-1|pudb:option--pre-run-1)' fzf-preview \
        '[[ $group == 'external command' ]] &&  bat -f -p $word'

    # give a preview of commandline arguments when completing `kill` or 'ps'
    zstyle ':fzf-tab:complete:(\\|*/|)(kill|killall|ps|px|htop):argument-rest' fzf-preview \
        '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd,pid,user,comm -w -w'

    zstyle ':fzf-tab:complete:(\\|*/|)jq:argument-rest' fzf-preview \
        '[[ -f $realpath ]] && jq -Cr . $realpath 2>/dev/null || less $realpath'

    zstyle ':fzf-tab:complete:(\\|*/|)nmap:argument-rest' fzf-preview 'nmap $word'

    zstyle ':fzf-tab:complete:(\\|*/|)ip:' fzf-preview \
        'case $group in
        'ip command') ip $word help 2>&1 |  bat -f -plhelp
        ;;
    esac'

    zstyle ':fzf-tab:complete:(\\|*/|)xdg-settings:' fzf-preview \
        'file=$(xdg-settings get $word)
    [[ -n $file ]] && less {/usr,~/.local,~/.local/state/nix/profile,/run/current-system/sw}/share/applications/$file(N)'

    zstyle ':fzf-tab:complete:git-(diff|restore):*' fzf-preview 'git diff $word |  bat -f -n -r :10'

    zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log $word |  bat -f -n -r :10'

    zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word |  bat -f -n -r :10'

    zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
        'case $group in
	        "commit tag") git show  $word |  bat -f -n -r :10
            ;;
	        *) git show $word |  bat -f -n -r :10
            ;;
	    esac'

    zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
        'case $group in
	        "modified file") git diff $word |  bat -f -n -r :10
            ;;
	        "recent commit object name") git show -f $word |  bat -f -n -r :10
            ;;
	        *) git log -f $word |  bat -f -n -r :10
            ;;
	    esac'

    zstyle ':fzf-tab:complete:gh:' fzf-preview 'gh help $word |  bat -f -n -plhelp'

    zstyle ':fzf-tab:complete:(\\|*/|)apt(|-cache):argument-rest' fzf-preview 'apt-cache show $word |  bat -f -p'

    zstyle ':fzf-tab:complete:(\\|*/|)nala(|-install):argument-rest' fzf-preview 'nala show $word |  bat -f -p'

    zstyle ':fzf-tab:complete:(\\|*/|)npm:' fzf-preview 'npm help -l $word |  bat -f -n -l markdown'

    zstyle ':fzf-tab:complete:pnpm:' fzf-preview 'pnpm help $word |  bat -f -n -l markdown'

    zstyle ':fzf-tab:complete:(\\|*/|)neofetch:argument-rest' fzf-preview 'neofetch $word |  bat -f -p'

    zstyle ':fzf-tab:complete:(\\|*/|)progress:*' fzf-preview \
        'case $group in
        'external command') progress -c $word
        ;;
        'process ID') progress -p $word
        ;;
    esac'

    zstyle ':fzf-tab:complete:tmux:argument-rest' fzf-preview \
        'case $word in
        (show|set)(env|-environment)) tmux ${word/set/show} -g | bat -f -plsh
        ;;
        (show|set)(-hook?|(-window)-option?|w|)) tmux ${word/set/show} -g | bat -f -pltsv
        ;;
        (show|set)(msgs|-message?)) tmux ${word/set/show} | bat -f -pllog
        ;;
        (show|set)(b|-buffer)) tmux ${word/set/show}
        ;;
        (ls|list-)*) tmux $word
        ;;
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
                --bind "enter:execute([[ -f {} ]] && LESS='--RAW-CONTROL-CHARS'  bat --color=auto --paging=always {})" \
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
else
    zstyle ':completions:*' menu select search interactive
fi
