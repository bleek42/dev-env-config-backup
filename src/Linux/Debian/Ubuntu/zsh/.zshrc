#!/usr/bin/env zsh

### * ${HOME}/.zshrc file for zsh interactive shells.
## ? see /usr/share/doc/zsh/examples/zshrc for examples
[[ -o interactive ]] || return 1

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh && direnv allow)"

if [[ -r "${XDG_CACHE_DIR:-${HOME}/.cache}/zi/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_DIR:-${HOME}/.cache}/zi/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## * ###############
## * +-------------+
## * | ZSH OPTIONS |
## * +-------------+
## * ###############

unsetopt correct           # ! auto correct mistakes

setopt auto_resume # ! attempt to resume existing job before creating a new process
setopt notify      # ! report the status of background jobs immediately
# setopt no_hup            # ! Don't send SIGHUP to background processes when the shell exits
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt pushd_ignore_dups   # ! don't push the same dir twice

# unsetopt rm_star_silent # ! notify when rm is running with *

setopt rm_star_wait        # ! wait for 10 seconds confirmation when running rm with *
setopt prompt_subst        # ! enable command substitution in prompt
setopt magic_equal_subst     # ! enable filename expansion for arguments of the form ‘anything=expression’
setopt interactive_comments # ! allow comments in interactive mode

# setopt flow_control      # ! use Ctrl+S / Ctrl+Q to stop and continue flow
setopt menu_complete        # ! enable menu completion
setopt auto_param_slash
setopt list_types           # ! mark type of completion suggestions
setopt no_nomatch           # ! hide error message if there is no match for the pattern
setopt interactive_comments # ! allow use of comments in interactive code
setopt auto_param_slash     # ! complete folders with / at end

setopt hash_list_all        # ! whenever a command completion is attempted, make sure the entire command path is hashed first
setopt complete_in_word     # ! allow completion from within a word/phrase
setopt always_to_end        # ! move cursor to the end of a completed word
setopt long_list_jobs       # ! display pid when suspending processes as well
setopt extended_glob
setopt null_glob
setopt numeric_glob_sort # ! sort filenames numerically when it makes sense

# setopt sh_word_split   # ! split fields on unquoted parameter expansions (bash compatibility)
# setopt no_sh_word_split # ! use zsh style word splitting

## * History configurations
## * +---------+
## * | HISTORY |
## * +---------+

export HISTTIMEFORMAT='[%F %T]'
export HISTFILE="$ZI[CACHE_DIR]/zhistfile"
export HISTSIZE=8000
export SAVEHIST=8000

setopt hist_verify             # ! show command with history expansion to user before running it
setopt extended_history        # ! save time/duration info when exiting shell
setopt inc_append_history_time # ! history appends to existing file as soon as it's written
setopt hist_ignore_dups        # ! do not record an event that was just recorded again.
setopt hist_find_no_dups       # ! do not display a previously found event.
setopt hist_save_no_dups       # ! do not write a duplicate event to the history file.
setopt hist_ignore_all_dups    # ! delete an old recorded event if a new event is a duplicate.
setopt hist_expire_dups_first  # ! delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_space       # ! ignore commands that start with space
setopt hist_reduce_blanks      # ! trim multiple insignificant blanks in history
setopt share_history           # ! share

export WORDCHARS='*?_[]~=&;!#$%^(){}``' # Dont consider certain characters part of the word
export PROMPT_EOL_MARK=" "

autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help='run-help'

if [[ -z ${debian_chroot:-} ]] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# # If this is an xterm set the title to user@host:dir
case "${TERM}" in
xterm* | rxvt* | Eterm | aterm | kterm | gnome* | alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*) ;;
esac

if [[ -f ${ZI[BIN_DIR]}/zi.zsh ]]; then

    source "${ZI[BIN_DIR]}/zi.zsh"

    autoload -Uz _zi
    (( ${+_comps} )) && _comps[zi]=_zi

    zi lucid light-mode for \
    z-shell/z-a-meta-plugins \
        compile='functions/.*readurl*~*.zwc' \
    z-shell/z-a-readurl \
        compile='functions/.*patch-dl*~*.zwc' \
    z-shell/z-a-patch-dl \
        compile='functions/.*ev*~*.zwc' \
    z-shell/z-a-eval

    zi lucid light-mode for \
        OMZ::lib/functions.zsh \
        OMZ::lib/clipboard.zsh \
        OMZ::lib/git.zsh \
        OMZ::lib/vcs_info.zsh \
        OMZ::lib/completion.zsh \
        OMZ::lib/spectrum.zsh \
        OMZ::lib/termsupport.zsh \
        OMZ::lib/theme-and-appearance.zsh \
        OMZ::lib/prompt_info_functions.zsh \
        OMZ::lib/async_prompt.zsh \
        OMZ::lib/misc.zsh \
        if="test -d ${HOME}/.ssh" \
        eval="test -f ${ZI[CONFIG_DIR]}/options/ssh-agent-opts.zsh && \
                source ${ZI[CONFIG_DIR]}/options/ssh-agent-opts.zsh \
            "\
    OMZ::plugins/ssh-agent \
        has=rsync \
    OMZ::plugins/rsync \
        has=tmux \
    OMZ::plugins/tmux \
        has=systemctl \
    OMZ::plugins/systemd \
        has=ip \
    OMZ::plugins/systemadmin \
        has=python3 \
    OMZ::plugins/shell-proxy \
        has=node \
    OMZ::plugins/node \
        has=npm \
    OMZ::plugins/npm \
        has=nmap \
    OMZ::plugins/nmap \
        has=apt \
    OMZ::plugins/ubuntu \
        has=code \
    OMZ::plugins/vscode

    zi light-mode lucid wait"0a" for \
        nocd \
        depth=1 \
        atinit="POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true" \
        atload="test -f "${ZI[CONFIG_DIR]}/options/ssh-agent-opts.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/p10k.zsh" \
            "\
    romkatv/powerlevel10k \
        atload="export ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)" \
    hlissner/zsh-autopair \
        pick=sqlite-history.zsh \
        src=histdb-interactive.zsh \
        atinit="test -f "${ZI[CACHE_DIR]}/histdb/zsh-history.db" && \
                    export HISTDB_FILE="${ZI[CACHE_DIR]}/histdb/zsh-history.db" \
            "\
        atload="test -f "${SHELLRCD:-$HOME/.config/rc.d}/common/aliases.sh" && \
                    source "${SHELLRCD:-$HOME/.config/rc.d}/common/aliases.sh" \
            "\
        compile='{*sqlite*~*.zwc,*histdb*~*.zwc}' \
    larkery/zsh-histdb \
    z-shell/zsh-diff-so-fancy \
        has='eza' \
        pack='no-color-swaps' \
    z-shell/dircolors-material \
    z-shell/zui \
    z-shell/zi-console \
    z-shell/zsh-select \
        atload='test -f "${ZI[CONFIG_DIR]}/options/zmorpho-opts.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/zmorpho-opts.zsh" \
            '\
    z-shell/zsh-morpho \
    z-shell/zzcomplete

    ## ? call zsh compinit in system-completions at very end of block before loading fzf-tab, syntax hl, etc.
    ## ! DON'T add ANY completions in below plugin block..!
    zi wait"0b" for \
        id-as='system-completions' \
        as='completion' \
        atinit='rsync -q -r -L -u -H --chown="${USER}" --specials -p -v /usr/share/zsh/functions/Completion/_*(.) "${ZI[COMPLETIONS_DIR]}" \
                rsync -q -r -L -u -H --chown="${USER}" --specials -p -v /usr/share/zsh/vendor-completions/_*(.) "${ZI[COMPLETIONS_DIR]}" \
                zi creinstall -q /usr/share/zsh/functions/Completion; zi creinstall -q /usr/share/zsh/vendor-completions \
                zi cclear \
            '\
        atload='fpath=( ${(u)fpath[@]:#/usr/share/zsh/functions/Completion/*} ) \
                fpath=( ${(u)fpath[@]:#/usr/share/zsh/vendor-completions/*} ) \
                fpath+=( ${ZI[CONFIG_DIR]}/functions ) \
                fpath+=( ${ZPFX}/share/zsh/${ZSH_VERSION}/completions ) \
            '\
        nocompile \
    z-shell/0 \
        has=fzf \
        atinit='zicompinit_fast; zicdreplay' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/comp-opts.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/comp-opts.zsh" \
            '\
        compile='lib/{-ftb,ftb}*~*.zwc' \
    Aloxaf/fzf-tab \
        atload='fast-theme z-shell &>/dev/null' \
        compile='{functions/{.fast,fast}-*~*.zwc,chroma/*~*.zwc}' \
    z-shell/F-Sy-H \
        atinit='export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=32' \
        atload='!_zsh_autosuggest_start \
                source "${ZI[CONFIG_DIR]}/functions/_zsh_autosuggest_strategy_histdb_dirs" \
            '\
        compile='{src/*.zsh*~*.zwc,src/strategies/*~*.zwc}' \
    zsh-users/zsh-autosuggestions

fi


# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # # confirmations, etc.) must go above this block; everything else may go below.

# ## ? configure key keybindings
# bindkey -e # emacs key bindings
# # bindkey '^I' expand-or-complete-prefix # tab comp
# bindkey '^Xh' _complete_help
# bindkey ' ' magic-space                        # do history expansion on space
# bindkey '^U' backward-kill-line                # ctrl + U
# bindkey '^[[3;5~' kill-word                    # ctrl + Supr
# bindkey '^[[3~' delete-char                    # delete
# bindkey '^[[1;5C' end-of-line                  # ctrl + ->
# bindkey '^[[1;5D' beginning-of-line            # ctrl + <-
# bindkey '^[[5~' beginning-of-buffer-or-history # page up
# bindkey '^[[6~' end-of-buffer-or-history       # page down
# bindkey '^[[H' forward-word                    # home
# bindkey '^[[F' end-of-line                     # end
# bindkey '^Z' undo                              # ctrl + Z undo last action

# # Keybindings for substring search plugin. Maps up and down arrows.
# bindkey -M main '^[OA' history-substring-search-up
# bindkey -M main '^[OB' history-substring-search-down
# set variable identifying the chroot you work in (used in the prompt below)

# precmd_functions+=(precmd precmd_conda_info)

# if [[ $(tty) == /dev/pts/0 ]] && [[ ${TERM_PROGRAM} != vscode ]]; then
# 	fetch_cmd="$(command -v fastfetch || command -v neofetch || null)"
# 	# echo "${fetch_cmd}"

# 	case "${fetch_cmd}" in
# 	*/fastfetch)
# 		fastfetch
# 		;;
# 	*/neofetch)
# 		neofetch
# 		;;
# 	*)
# 		echo "Unable to display system information: no fetch command found in PATH..."
# 		;;
# 	esac

# fi

# export RPROMPT='$(systemd_prompt_info systemd-sysusers.service user.slice)'

if [ -n "$RANGER_LEVEL" ]; then
    export RPROMPT=${[ranger]:+$PS4}
fi

# enable command-not-found if installed
if [ -f etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
fi
