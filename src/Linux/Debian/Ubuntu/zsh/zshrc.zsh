#!/usr/bin/env zsh

### * ${HOME}/.zshrc file for zsh interactive shells.
## ? see /usr/share/doc/zsh/examples/zshrc for examples
[[ -o interactive ]] || return

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh && direnv allow)"
# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # # confirmations, etc.) must go above this block; everything else may go below.
if [[ -r ${XDG_CACHE_DIR:-${HOME}/.cache}/zi/p10k-instant-prompt-${(%):-%n}.zsh ]]; then
    source "${XDG_CACHE_DIR:-${HOME}/.cache}/zi/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## * ###############
## * +-------------+
## * | ZSH OPTIONS |
## * +-------------+
## * ###############

### ? shell emulation options
setopt posix_builtins # ! when set, the command 'builtin' can be used to execute shell builtins
# setopt no_sh_word_split # ! use zsh style word splitting
# unsetopt correct           # ! auto correct mistakes
# setopt sh_word_split   # ! split fields on unquoted parameter expansions (bash compatibility)
### ? prompt / substring options
setopt prompt_subst        # ! enable command substitution in prompt
setopt magic_equal_subst     # ! enable filename expansion for arguments of the form ‘anything=expression’

### ? script & function options
setopt interactive_comments # ! allow comments in interactive mode
# setopt local_options # !shell options are to be restored after returning from a shell function

### ? chdir options
setopt auto_pushd
setopt pushd_ignore_dups   # ! don't push the same dir twice
# setopt pushdminus
# setopt rm_star_wait        # ! wait for 10 seconds confirmation when running rm with *
# unsetopt rm_star_silent # ! notify when rm is running with *

### ? expansion/globbing options
setopt extended_glob
setopt dot_glob
setopt case_glob # ! make globbing case sensitive
setopt null_glob   # ! if glob doesnt return matches, remove glob from arg list instead of reporting an error
setopt case_match # ! make regular expression matches case sensitive
setopt numeric_glob_sort # ! sort filenames numerically when it makes sense


### ? job control options
setopt monitor # ! allow job control
setopt notify      # ! report the status of background jobs immediately
setopt long_list_jobs       # ! display pid when suspending processes as well
setopt auto_resume # ! attempt to resume existing job before creating a new process
setopt no_hup            # ! Don't send SIGHUP to background processes when the shell exits


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

# if [[ -f ${XDG_CONFIG_DIR:-${HOME}/.config/rc.d}/zsh/options/p10k.zsh ]]; then
#     source "${XDG_CONFIG_DIR:-${HOME}/.config/rc.d}/zsh/options/p10k.zsh"
# fi

export WORDCHARS='*?_[]~=&;!#$%^(){}``' # Dont consider certain characters part of the word
export PROMPT_EOL_MARK=" "


if [[ -f ${ZI[BIN_DIR]}/zi.zsh ]]; then

    source "${ZI[BIN_DIR]}/zi.zsh"

    autoload -Uz _zi
    (( ${+_comps} )) && _comps[zi]=_zi

    zi lucid light-mode for \
    z-shell/z-a-meta-plugins \
    z-shell/z-a-default-ice \
        atinit'Z_A_USECOMP=1' \
        compile='functions/.*ev*~*.zwc' \
    z-shell/z-a-eval \
        compile='functions/.*submods*~*.zwc' \
    z-shell/z-a-submods \
    z-shell/z-a-linkbin \
        compile='functions/.*lman*~*.zwc' \
    z-shell/z-a-linkman \
        compile='functions/.*bgn*~*.zwc' \
    z-shell/z-a-bin-gem-node \
        compile='functions/.*rust*~*.zwc' \
    z-shell/z-a-rust \
        compile='functions/.*readurl*~*.zwc' \
    z-shell/z-a-readurl \
        compile='functions/.*patch-dl*~*.zwc' \
    z-shell/z-a-patch-dl \
    @zunit

    zi lucid light-mode for \
    OMZ::lib/functions.zsh \
    OMZ::lib/clipboard.zsh \
    OMZ::lib/git.zsh \
    OMZ::lib/vcs_info.zsh \
    OMZ::lib/spectrum.zsh \
    OMZ::lib/termsupport.zsh \
    OMZ::lib/misc.zsh

    zi wait"0a" light-mode aliases for \
        if='[[ -d ${HOME}/.ssh ]]' \
        eval='[[ -f ${ZI[CONFIG_DIR]}/options/ssh-agent-opts.zsh ]] && \
                source "${ZI[CONFIG_DIR]}/options/ssh-agent-opts.zsh" \
            '\
    OMZ::plugins/ssh-agent \
        has='rsync' \
    OMZ::plugins/rsync \
        has='tmux' \
    OMZ::plugins/tmux \
        has='systemctl' \
    OMZ::plugins/systemd \
        has='ip' \
    OMZ::plugins/systemadmin \
        has='python3' \
    OMZ::plugins/shell-proxy \
        has='node' \
    OMZ::plugins/node \
        has='npm' \
    OMZ::plugins/npm \
        has='nmap' \
    OMZ::plugins/nmap \
        has='apt' \
    OMZ::plugins/ubuntu \
        has='code' \
    OMZ::plugins/vscode

    zi wait"0b" notify for \
        nocd \
        depth=1 \
        id-as='powerlevel10k' \
        atinit='POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' \
    romkatv/powerlevel10k \
        id-as='p10k.lambda.zsh' \
        if='[[ -f ${ZI[CONFIG_DIR]}/options/p10k.lambda.zsh ]]' \
        is-snippet \
    "${ZI[CONFIG_DIR]}/options/p10k.lambda.zsh" \
        id-as='autopair' \
        atload='ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)' \
    hlissner/zsh-autopair \
        id-as='zsh-histdb' \
        multisrc='{sqlite-history,histdb-interactive}.zsh' \
        atinit='[[ -f ${ZI[CACHE_DIR]}/histdb/zsh-history.db ]] && \
                    export HISTDB_FILE="${ZI[CACHE_DIR]}/histdb/zsh-history.db" \
                '\
        compile='{*sqlite*~*.zwc,*histdb*~*.zwc}' \
    larkery/zsh-histdb \
        id-as='common-aliases' \
        if='[[ -f ${SHELLRCD:-${HOME}/.config/rc.d}/common/aliases.sh ]]' \
        is-snippet \
    "${SHELLRCD:-${HOME}/.config/rc.d}/common/aliases.sh" \
        id-as='zsh-eza' \
        has='eza' \
        atinit='AUTOCD=1' \
    z-shell/zsh-eza \
        pack='minimal' \
    dircolors-material \
        id-as='zsh-uid' \
    z-shell/zsh-unique-id \
        id-as='zsh-fancy-diff' \
        sbin='bin/git-dsf;bin/diff-so-fancy;bin/fancy-diff;' \
    z-shell/zsh-diff-so-fancy \
        id-as='zui' \
    z-shell/zui \
        id-as='zi-console' \
    z-shell/zi-console \
        id-as='zsh-select' \
    z-shell/zsh-select \
        atload='[[ -f ${ZI[CONFIG_DIR]}/options/zmorpho-opts.zsh ]] && \
                    source "${ZI[CONFIG_DIR]}/options/zmorpho-opts.zsh" \
            '\
        id-as='zsh-morpho' \
    z-shell/zsh-morpho \
        id-as='zzcomplete' \
    z-shell/zzcomplete \
        as='completion' \
        id-as='local-completions' \
        atclone='command cp -afu --copy-contents /usr/share/zsh/functions/Completion/*/_*(.) "${ZI[CONFIG_DIR]}/completions"; \
                command cp -afu --copy-contents /usr/share/zsh/vendor-completions/_*(.) "${ZI[CONFIG_DIR]}/completions"; \
                zi creinstall -q "${ZI[CONFIG_DIR]}/completions"; zi cclear -q \
            '\
        atload='fpath=( ${(u)fpath[@]:#/usr/share/zsh/functions/Completion/*} ) && \
                fpath+=( ${ZI[CONFIG_DIR]}/functions ) \
                fpath+=( ${ZI[HOME_DIR]}/completions ) \
                zpcompinit; zpcdreplay \
            '\
        atpull="%atclone" \
        run-atpull \
        nocompile \
    z-shell/0
    ## ? call zsh compinit in system-completions at very end of block before loading fzf-tab, syntax hl, etc.


    ## ! DON'T add ANY completions in below plugin block..!
    zi wait"0c" notify for \
        has='fzf' \
        id-as='fzf-tab' \
        compile='lib/{-ftb,ftb}*~*.zwc' \
    Aloxaf/fzf-tab \
        id-as='zsh-fast-syntax-highlighting' \
        eval='fast-theme z-shell &>/dev/null' \
        compile='{functions/{.fast,fast}-*~*.zwc,chroma/*~*.zwc}' \
    z-shell/F-Sy-H \
        id-as='zsh-autosuggestions' \
        atload='!_zsh_autosuggest_start && \
                    [[ -f ${ZI[CONFIG_DIR]}/options/history/histdb_dirs.zsh ]] && \
                        source "${ZI[CONFIG_DIR]}/options/history/histdb_dirs.zsh" \
            '\
        compile='{src/*.zsh*~*.zwc,src/strategies/*~*.zwc}' \
    zsh-users/zsh-autosuggestions

    zi wait"1a" notify is-snippet for \
        id-as='comp-opts' \
    "${ZI[CONFIG_DIR]}/options/comp-opts.zsh" \
        id-as='custom-keybindings' \
    "${ZI[CONFIG_DIR]}/options/key-bindings.zsh"

fi

if [[ -z ${debian_chroot:-} ]] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

        # atinit='[[ -f ${ZI[CONFIG_DIR]}/options/key-bindings.zsh ]] && \
        #             source "${ZI[CONFIG_DIR]}/options/key-bindings.zsh" \
        #         '\
                # source "${ZI[CONFIG_DIR]}/functions/_zsh_autosuggest_strategy_histdb_dirs" \
# # If this is an xterm set the title to user@host:dir
case "${TERM}" in
xterm* | rxvt* | Eterm | aterm | kterm | gnome* | alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*) ;;
esac


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
