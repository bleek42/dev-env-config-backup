#!/usr/bin/env zsh

[[ -o interactive ]] || return 1

:   "${ZSH_THEME:=default}"

## * Allow mapping Ctrl+S and Ctrl+Q shortcuts
[[ -r ${TTY:-} && -w ${TTY:-} ]] && \
    (( ${+commands[stty]} == 1 )) && \
        stty -ixon <$TTY >$TTY

if (( ${+commands[alacritty]} || ${+commands[kitty]} )); then
    [[  -n $ALACRITTY_WINDOW_ID ]] && \
        export ZSH_THEME=starship
fi

export LESSOPEN="|~/.lessfilter %s 2>&-"
export LESS_TERMCAP_mb=$'\E[01;31m'    # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'    # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'        # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'        # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m' # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'        # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'    # Begins underline.

[[ -r ${SHELLRCD}/common/lscolors/jellybeans.bash ]] && \
    source "${SHELLRCD}/common/lscolors/jellybeans.bash"

autoload -Uz is-at-least
## * Enable bracketed paste magic; is known buggy in some versions, so disable if so
if [[ -z $DISABLE_MAGIC_FUNCTIONS ]]; then
    for d in $fpath; do
        if [[ -e "$d/url-quote-magic" ]]; then
            if is-at-least 5.1; then
                autoload -Uz bracketed-paste-magic
                zle -N bracketed-paste bracketed-paste-magic
            fi
            autoload -Uz url-quote-magic
            zle -N self-insert url-quote-magic
            break
        fi
    done
    unset d
fi

## ? Options section
setopt rc_quotes	            # ! Allow '' to be used for quoting
setopt rc_expand_param          # ! Array expension with parameters
setopt combining_chars          # ! Combine zero-length punctuation characters (accents) with the base character
setopt extended_glob            # ! Extended globbing. Allows using regular expressions with *
setopt no_case_glob             # ! Case insensitive globbing
setopt numeric_glob_sort        # ! Sort filenames numerically when it makes sense
setopt multios                  # ! Implicit tees or cats when multiple redirections are attempted.
setopt no_beep                  # ! No beep sound when a command fails
# setopt autocd                   # ! if only directory path is entered, cd there.
setopt cdable_vars              # ! Change directory to a path stored in a variable
setopt prompt_subst             # ! Parameter expansion, command substitution, & parameter substitution in prompts
setopt interactive_comments     # ! Allow comments in interactive shells
setopt notify                   # ! Report the status of background jobs immediately
setopt auto_resume              # ! Attempt to resume existing job before creating a new process
setopt check_jobs              # ! Warn about running processes when exiting

## ? Disable options section
setopt no_hup                   # ! Don't kill jobs on logout
setopt no_correct              # ! Disable auto-correction of mistakes
setopt no_bg_nice              # ! Don't run all background jobs at a lower priority

WORDCHARS='*?_[]~=&;!#$%^(){}``' # ! Dont consider certain characters part of the word
PROMPT_EOL_MARK=" "

## * create alt zsh cache directory if it does not exist
[[ -d ${HOME}/.cache/zsh ]] || \
    mkdir -p "${HOME}/.cache/zsh"

## ? ZSH history section
HISTFILE="${HOME}/.cache/zsh/histfile"
HISTSIZE=50000
SAVEHIST=20000
HISTTIMEFORMAT='%F %T '

## * create zsh history file if it does not exist
[[ -f $HISTFILE ]] || \
    touch "$HISTFILE"

setopt extended_history       # ! Show timestamp in history.
setopt append_history         # ! Immediately append history instead of overwriting
setopt hist_ignore_dups       # ! Do not record an event that was just recorded again.
setopt hist_expire_dups_first # ! Expire A duplicate event first when trimming history.
setopt hist_ignore_all_dups   # ! If a new command is a duplicate, remove the older one
setopt hist_ignore_space      # ! Ignore commands that start with space
setopt inc_append_history     # ! Write to the history file immediately, not when the shell exits.
setopt hist_verify            # ! Show command with history expansion to user before running it
setopt share_history          # ! Share history between all sessions
setopt bang_hist              # ! Treat the '!' character specially during expansion
setopt hist_beep              # ! Beep when accessing non-existent history
setopt hist_reduce_blanks     # ! Remove superfluous blanks from history list

## ! Enable colors
autoload -Uz colors && colors

function set_win_title(){
    echo -ne "\033]0; $USER@$HOST:${PWD/$HOME/~} \007"
}

precmd_functions+=(set_win_title)

## ! Enable run-help module
autoload -Uz run-help
(( ${+aliases[help]} )) && unalias help
alias help='run-help'

## ? Enable alternative, enhanced for moving and/or copying files/dirs with mv/cp, respectively
autoload -Uz zmv
autoload -Uz async && async

if command -v fzf >/dev/null 2>&1; then
    typeset -g TERMINAL OPENER STARTING_DIR
    TERMINAL="${TERMINAL:-/usr/bin/alacritty}"
    OPENER="${OPENER:-${SHELLRCD}/common/fzf/open.sh}"
    STARTING_DIR="${STARTING_DIR:-$HOME}"
fi

if [[ -r ${ZI[BIN_DIR]}/zi.zsh ]]; then

    source "${ZI[BIN_DIR]}/zi.zsh"

    autoload -Uz _zi
    (( ${+_comps} )) && _comps[zi]=_zi

    if [[ -d ${ZI[ZMODULES_DIR]}/zpmod/Src ]];then
        module_path=( "${ZI[ZMODULES_DIR]}/zpmod/Src" "${module_path[@]}" )
        zmodload zi/zpmod
    fi

    zi silent for \
        id-as='z-a-meta-plugins' \
    z-shell/z-a-meta-plugins \
        id-as='z-a-default-ice' \
    z-shell/z-a-default-ice \
        id-as='z-a-unscope' \
    z-shell/z-a-unscope \
        id-as='z-a-submods' \
        compile='functions/.*submods*~*.zwc' \
    z-shell/z-a-submods \
        id-as='z-a-readurl' \
        compile='functions/.*readurl*~*.zwc' \
    z-shell/z-a-readurl \
        id-as='z-a-linkman' \
        compile='functions/.*lman*~*.zwc' \
    z-shell/z-a-linkman \
        id-as='z-a-linkbin' \
    z-shell/z-a-linkbin \
        id-as='z-a-patch-dl' \
        compile='functions/.*patch-dl*~*.zwc' \
    z-shell/z-a-patch-dl \
        id-as='z-a-eval' \
        atinit='typeset -ix Z_A_USECOMP=1' \
        compile='functions/.*ev*~*.zwc' \
    z-shell/z-a-eval \
        id-as='z-a-bin-gem-node' \
        compile='functions/.*bgn*~*.zwc' \
    z-shell/z-a-bin-gem-node \
        id-as='z-a-rust' \
        if='(( ! ${+commands[rustc]} ))' \
        compile='functions/.*rust*~*.zwc' \
    z-shell/z-a-rust

	zi lucid is-snippet for \
		id-as='functions-sh' \
		if='[[ -f ${SHELLRCD}/common/functions.sh ]]' \
    "${SHELLRCD}/common/functions.sh" \
        id-as='aliases-sh' \
		if='[[ -r ${SHELLRCD}/common/aliases.sh ]]' \
        aliases \
    "${SHELLRCD}/common/aliases.sh" \
        id-as='functions-zsh' \
		if='[[ -r ${ZI[CONFIG_DIR]}/lib/functions.zsh ]]' \
        aliases \
    "${ZI[CONFIG_DIR]}/lib/functions.zsh" \
        id-as='cli-omz' \
        if='[[ -r ${ZI[CONFIG_DIR]}/lib/cli-omz.zsh ]]' \
    "${ZI[CONFIG_DIR]}/lib/cli-omz.zsh" \
        id-as='clipboard-zsh' \
		if='[[ -r ${ZI[CONFIG_DIR]}/lib/clipboard.zsh ]]' \
    "${ZI[CONFIG_DIR]}/lib/clipboard.zsh" \
        id-as='git-zsh' \
		if='[[ -r ${ZI[CONFIG_DIR]}/lib/git.zsh ]]' \
    "${ZI[CONFIG_DIR]}/lib/git.zsh" \
        id-as='spectrum-zsh' \
		if='[[ -r ${ZI[CONFIG_DIR]}/lib/spectrum.zsh ]]' \
    "${ZI[CONFIG_DIR]}/lib/spectrum.zsh" \
        id-as='termsupport-zsh' \
        if='[[ -r ${ZI[CONFIG_DIR]}/lib/termsupport.zsh ]]' \
    "${ZI[CONFIG_DIR]}/lib/termsupport.zsh" \
        id-as='systemd-zsh' \
        has='systemctl' \
        if='[[ $(systemctl is-system-running) != *offline* ]]' \
    "${ZI[CONFIG_DIR]}/lib/systemd.zsh" \
        id-as='sysadmin-zsh' \
        has='ip' \
		if='[[ -r ${ZI[CONFIG_DIR]}/lib/sysadmin.zsh ]]' \
    "${ZI[CONFIG_DIR]}/lib/sysadmin.zsh" \
        id-as='tmux-zsh' \
        has='tmux' \
		if='[[ -r ${ZI[CONFIG_DIR]}/lib/tmux.zsh ]]' \
        eval='ZSH_TMUX_UNICODE=true;' \
    "${ZI[CONFIG_DIR]}/lib/tmux.zsh" \
        id-as='fzf-zsh' \
        has='fzf' \
		if='[[ -r ${ZI[CONFIG_DIR]}/lib/fzf.zsh ]]' \
    "${ZI[CONFIG_DIR]}/lib/fzf.zsh" \
        id-as='diagnostics-zsh' \
        if='[[ -r ${ZI[CONFIG_DIR]}/lib/diagnostics.zsh ]]' \
    "${ZI[CONFIG_DIR]}/lib/diagnostics.zsh" \
        id-as='fnm-zsh' \
        has='fnm' \
        if='[[ -r ${ZI[CONFIG_DIR]}/options/nodejs/fnm.zsh ]]' \
    "${ZI[CONFIG_DIR]}/options/nodejs/fnm.zsh" \
		id-as='vi-mode-zsh' \
		if='[[ -r ${ZI[CONFIG_DIR]}/options/vi/vi-mode.omz.zsh ]]' \
    "${ZI[CONFIG_DIR]}/options/vi/vi-mode.omz.zsh" \
        id-as='fzf-auto-size' \
        has='fzf' \
        if='[[ -r ${SHELLRCD}/common/fzf/auto-size/init.bash ]]' \
    "${SHELLRCD}/common/fzf/auto-size/init.bash" \
        id-as='proxy-zsh' \
		if='[[ -r ${ZI[CONFIG_DIR]}/lib/proxy.zsh ]]' \
    "${ZI[CONFIG_DIR]}/lib/proxy.zsh"

    zi wait='!(( ${+commands[omz_termsupport_cwd]} ))' lucid nocd for \
        id-as='starship-prompt' \
        null \
        has='starship' \
        if='[[ $TERM_PROGRAM != *vsc* ]]' \
        load='[[ $ZSH_THEME == *starship* ]] && [[ -z $TERM_PROGRAM || $TERM_PROGRAM == *alacritty* ]]' \
        unload='[[ -z $ZSH_THEME || $ZSH_THEME != *starship* ]] || [[ $TERM_PROGRAM == *vsc* ]]' \
        eval='!starship init zsh --print-full-init' \
    z-shell/0 \
        id-as='pure-prompt-lambda' \
        if='[[ -n $ASYNC_INIT_DONE ]]' \
        load='[[ $ASYNC_INIT_DONE == 1 ]] && [[ -z $ZSH_THEME ]]' \
        unload='[[ -z $ASYNC_INIT_DONE ]] || [[ -n $ZSH_THEME ]]' \
        multisrc='${ZI[CONFIG_DIR]}/prompts/pure/{lambda,init}.zsh' \
    z-shell/0 \
        id-as='default-prompt' \
        null \
        if='[[ -z $STARSHIP_SESSION_KEY ]]' \
        load='[[ $ZSH_THEME == *default* ]] || [[ $TERM_PROGRAM == *vsc* ]]' \
        unload='[[ -n $STARSHIP_SESSION_KEY ]] || [[ $ZSH_THEME == *starship* || -z $ZSH_THEME ]]' \
        multisrc='${ZI[CONFIG_DIR]}/prompts/default/*' \
    z-shell/0

	## ? use & init fnm if detected in path
	## ? Run system information fetcher if in 1st tty instance and not in vscode

	zi wait='0a' lucid for \
	    id-as='zui' \
        atinit='ZCDR=${ZI[CONFIG_DIR]}/options' \
        atload='command cp -ruv functions/* ${ZI[CONFIG_DIR]}/functions' \
        blockf \
    z-shell/zui \
        id-as='ztrace' \
    z-shell/ztrace \
        id-as='unique-id-zsh' \
        atload='[[ -r ${ZI[CONFIG_DIR]}/options/unique-id.zsh ]] && \
                    source "${ZI[CONFIG_DIR]}/options/unique-id.zsh" \
                ' \
    z-shell/zsh-unique-id \
        id-as='zflai' \
    z-shell/zflai \
        id-as='zmorpho' \
        atload='[[ -r ${ZI[CONFIG_DIR]}/options/zui/zmorpho.zsh ]] && \
                    source "${ZI[CONFIG_DIR]}/options/zui/zmorpho.zsh" \
                ' \
    z-shell/zsh-morpho \
        id-as='zi-console' \
    z-shell/zi-console \
        id-as='zzcomplete' \
    z-shell/zzcomplete \
		id-as='notifications-zsh' \
		null \
		has='notify-send' \
		if='[[ -d ${ZI[CONFIG_DIR]}/lib/notifications ]]' \
		multisrc='${ZI[CONFIG_DIR]}/lib/notifications/*.zsh' \
        compile='*.zsh*~*.zwc' \
	z-shell/0 \
        id-as='local-completions' \
        as='completion' \
        eval='![[ -d ${ZI[CONFIG_DIR]}/completions ]] || mkdir -p "${ZI[CONFIG_DIR]}/completions" \
				command cp -fruv /usr/share/zsh/functions/Completion/*/_* "${ZI[CONFIG_DIR]}/completions" \
				command cp -fruv /usr/share/zsh/*-functions/_* "${ZI[CONFIG_DIR]}/completions" \
				command cp -fruv /usr/share/zsh/*-completions/_* "${ZI[CONFIG_DIR]}/completions" && \
				zi creinstall "${ZI[CONFIG_DIR]}/completions"; zi cclear \
            ' \
        atload='!zpcompinit; zpcdreplay; source "${ZI[CONFIG_DIR]}/options/comp/init.zsh"' \
        run-atpull \
        nocompile \
        nocd \
    z-shell/0

    # ${(u)fpath[@]:#/usr/share/zsh/functions/Completion/*}

    ## ? call zsh compinit in system-completions at very end of block before loading fzf-tab, syntax hl, etc.
    ## ! DON'T add ANY completions in below plugin block..!
    zi wait='0b' lucid for \
        id-as='fzf-tab' \
		has='fzf' \
		atload='!zpcompinit && [[ -f ${ZI[CONFIG_DIR]}/options/comp/fzf-tab-comp.zsh ]] && \
					    source "${ZI[CONFIG_DIR]}/options/comp/fzf-tab-comp.zsh" \
                ' \
		compile='lib/{-ftb,ftb}*~*.zwc' \
		run-atpull \
    Aloxaf/fzf-tab \
        id-as='fast-syntax-highlighting-zsh' \
        atload='!fast-theme zdharma &>/dev/null' \
        compile='{functions/{.fast,fast}-*~*.zwc,chroma/*~*.zwc}' \
    z-shell/F-Sy-H \
        id-as='history-mw-search-zsh' \
        atload='![[ -f ${ZI[CONFIG_DIR]}/options/history/histmw-search.zsh ]] && \
                    source "${ZI[CONFIG_DIR]}/options/history/histmw-search.zsh" \
                ' \
        compile='functions/h*~*.zwc' \
    z-shell/H-S-MW \
		id-as='key-bindings-zsh' \
		if='[[ -f ${ZI[CONFIG_DIR]}/options/key-bindings.zsh ]]' \
		is-snippet \
	"${ZI[CONFIG_DIR]}/options/key-bindings.zsh" \
		id-as='autosuggestions-zsh' \
		eval='![[ -f ${ZI[CONFIG_DIR]}/options/autosuggestions.zsh ]] && \
					source "${ZI[CONFIG_DIR]}/options/autosuggestions.zsh" \
                ' \
        atload='!_zsh_autosuggest_start' \
        compile='{src/strategies/*~*.zwc,src/*.zsh*~*.zwc}' \
    zsh-users/zsh-autosuggestions

    zi wait='0c' lucid for \
        id-as='autopair-zsh' \
        compile='autopair*~*.zwc' \
    hlissner/zsh-autopair \
		id-as='mcfly-cmd-init' \
		if='[[ -f ${SHELLRCD}/common/mcfly/init.sh ]]' \
		atload='!mcfly_init' \
        is-snippet \
	"${SHELLRCD}/common/mcfly/init.sh" \
		id-as='cmd-not-found' \
		if='[[ -f ${SHELLRCD}/common/command-not-found/command-not-found.zsh ]]' \
        is-snippet \
    "${SHELLRCD}/common/command-not-found/command-not-found.zsh" \
		id-as='find-the-cmd' \
		if='[[ -f ${SHELLRCD}/common/find-the-command/find-the-command.zsh ]]' \
	    is-snippet \
    "${SHELLRCD}/common/find-the-command/find-the-command.zsh"

else

	# Add user completions to fpath if they exist
	# and weren't already added
	if [[ -d ${SHELLRCD:-${HOME}/.config/rc.d}/zsh/completions && \
        ! ${fpath[(Ie)${SHELLRCD:-${HOME}/.config/rc.d}/zsh/completions]} ]]; then

        fpath=( "${SHELLRCD:-${HOME}/.config/rc.d}/zsh/completions" "${fpath[@]}" )

    fi

	[[ -r ${SHELLRCD:-${HOME}/.config/rc.d}/common/aliases.sh ]] && \
		source "${SHELLRCD:-${HOME}/.config/rc.d}/common/aliases.sh"

	if [[ -d ${SHELLRCD:-${HOME}/.config/rc.d}/zsh/lib ]]; then
		for lib in "${XDG_CONFIG_HOME:-${HOME}/.config}"/rc.d/zsh/lib/*; do
            lib_name="$(basename $lib)"


            [[ $lib_name == "aliases.zsh" ]] \
                && source "$lib"

            [[ $lib_name == "clipboard.zsh" ]] \
                && source "$lib"

            [[ $lib_name == "git.zsh" ]] \
                && source "$lib"

            [[ $lib_name == "grep.zsh" ]] \
                && source "$lib"

            [[ $lib_name == "termsupport.zsh" ]] \
                && source "$lib"

            [[ $lib_name == "spectrum.zsh" ]] \
                && source "$lib"

            [[ $lib_name == "async.zsh" ]] \
                && source "$lib"

            [[ $lib_name == "proxy.zsh" ]] \
                && source "$lib"

            [[ $lib_name == "tmux.zsh" && -x $(command -v tmux) ]] \
                && source "$lib"

            [[ $lib_name == "systemd.zsh" && $(systemctl is-system-running) == "running" ]] && \
                source "$lib"

            [[ $lib_name == "sysadmin.zsh" && -x $(command -v ip) ]] \
                && source "$lib"

    	done

        unset lib lib_name

	fi


	if has_cmd fzf; then

		# ! Use fzf
		[[ -d ${XDG_CONFIG_HOME:-${HOME}/.config}/rc.d/commmon/fzf ]] && \
			source "${XDG_CONFIG_HOME:-${HOME}/.config}/rc.d/common/fzf/completions.zsh" && \
			source "${XDG_CONFIG_HOME:-${HOME}/.config}/rc.d/common/fzf/key-bindings.zsh" || \
		[[ -d /usr/share/fzf ]] && \
			source /usr/share/fzf/completion.zsh && \
			source /usr/share/fzf/key-bindings.zsh

	fi

	# ? Plugins section: Enable fish style features
	# ! Use syntax highlighting
	[[ -d /usr/share/zsh/plugins/zsh-syntax-highlighting ]] && \
		source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    autoload -Uz compinit && \
        compinit -C -d "${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zcompdump-${ZSH_VERSION}"

	[[ -r ${XDG_CONFIG_DIR:-${HOME}/.config}/rc.d/zsh/options/comp/init.zsh ]] && \
		source "${XDG_CONFIG_DIR:-${HOME}/.config}/rc.d/zsh/options/comp/init.zsh"

	if [[ -d ${XDG_CONFIG_HOME:-${HOME}/.config}/rc.d/zsh/options ]]; then
    	for zopt in "${XDG_CONFIG_HOME:-${HOME}/.config}"/rc.d/zsh/options/*; do
        	source "$zopt"
    	done
    	unset zopt
	fi


	# ! Use autosuggestion
	[[ -d /usr/share/zsh/plugins/zsh-autosuggestions ]] && \
		source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh && \
    [[ -r ${SHELLRCD:-${HOME}/.config/rc.d}/zsh/options/autosuggest.zsh ]] && \
			source "${SHELLRCD:-${HOME}/.config/rc.d}/zsh/options/autosuggest.zsh"

		# ! Use history substring search
	[[ -d /usr/share/zsh/plugins/zsh-history-substring-search ]] && \
        source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

	# ? Arch Linux command-not-found support, you must have package pkgfile installed
	# ? https://wiki.archlinux.org/index.php/Pkgfile#.22Command_not_found.22_hook
	[[ -r ${SHELLRCD:-${HOME}/.config/rc.d}/*/*/command-not-found/command-not-found.zsh ]] && \
		source "${SHELLRCD:-${HOME}/.config/rc.d}/*/*/command-not-found/command-not-found.zsh" || \
	[[ -r /usr/share/doc/pkgfile/command-not-found.zsh ]] && \
		source /usr/share/doc/pkgfile/command-not-found.zsh

	# ? Advanced command-not-found hook
	[[ -e ${SHELLRCD:-${HOME}/.config/rc.d}/*/*/find-the-command/ftc.zsh ]] && \
		source "${SHELLRCD:-${HOME}/.config/rc.d}/*/*/find-the-command/ftc.zsh" || \
	[[ -e /usr/share/doc/find-the-command/ftc.zsh ]] && \
		source /usr/share/doc/find-the-command/ftc.zsh

fi

if (( ${+functions[fetch_sysinfo]} )); then
    sleep 0.7
    fetch_sysinfo
fi

sleep 1
typeset -gU path PATH cdpath CDPATH fpath FPATH manpath MANPATH module_path MODULE_PATH
