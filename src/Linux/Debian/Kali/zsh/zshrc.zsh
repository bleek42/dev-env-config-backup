#!/usr/bin/env zsh

# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples
[[ -o interactive ]] || return 1

## * ##################
## * +-------------+ ##
## * | ZSH OPTIONS | ##
## * +-------------+ ##
## * ##################

setopt autocd              # ! change directory just by typing its name
setopt flow_control        # ! use Ctrl+S / Ctrl+Q to stop and continue flow
setopt interactivecomments # ! allow comments in interactive mode
setopt magicequalsubst     # ! enable filename expansion for arguments of the form ‘anything=expression’
setopt prompt_subst        # ! enable command substitution in prompt
# setopt correct            # ! auto correct mistakes
# setopt notify             # ! report the status of background jobs immediately
# setopt sh_word_split      # ! split fields on unquoted parameter expansions (bash compatibility)

## * ############################
## * +-----------------------+ ##
## * | SCRIPTING / FUNCTIONS | ##
## * +-----------------------+ ##
## * ############################

setopt multios              # ! enable redirect to multiple streams: echo >file1 >file2
setopt interactive_comments # ! allow comments in interactive mode
setopt long_list_jobs       # ! show long list format job notifications
# setopt local_options      # ! shell options are to be restored after returning from a shell function

## * ######################################
## * +---------------------------------+ ##
## * | CHAR EXPANSION / GLOB MATCHING |  ##
## * +--------------------------------+  ##
## * ######################################

setopt case_match        # ! make regular expression matches case sensitive
setopt dot_glob          # ! include dotfiles in glob matches
setopt case_glob         # ! make globbing case sensitive
setopt null_glob         # ! if glob doesnt return matches, remove glob from arg list instead of reporting an error
setopt extended_glob     # ! enable extended globbing
setopt numeric_glob_sort # ! sort filenames numerically when it makes sense
# setopt nonomatch       # ! hide error message if there is no match for the pattern

## * ##############
## * +---------+ ##
## * | HISTORY | ##
## * +---------+ ##
## * ##############

# setopt hist_verify     # ! show command with history expansion to user before running it
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

[[ ! -d "${XDG_CACHE_DIR:-${HOME}/.cache}/zsh" ]] && \
    mkdir -p "${XDG_CACHE_DIR:-${HOME}/.cache}/zsh"

[[ ! -f "${ZI[CACHE_DIR]:-${HOME}/.cache/zsh}/zhistfile" ]] && \
    touch "${ZI[CACHE_DIR]:-${HOME}/.cache/zsh}/zhistfile"

HISTFILE="${XDG_CACHE_DIR:-${HOME}/.cache}/zsh/zhistfile"
HISTSIZE=8000
SAVEHIST=8000

alias history='history -50'

autoload -Uz is-at-least
# *-magic is known buggy in some versions; disable if so
if [[ $DISABLE_MAGIC_FUNCTIONS != true ]]; then
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
fi

# ! enable colors
autoload -Uz colors && colors

# ! Enable run-help module
autoload -Uz run-help
alias help='run-help'

# ! enable bracketed paste
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# ! eqnable url-quote-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# # Custom personal functions
# # Don't use -U as we need aliases here
# autoload -z lspath bag fgb fgd fgl fz ineachdir psg vpaste evalcache compdefcache

## ? Enable wrapper, if original command is available
(( ${+commands[man]} )) && autoload -z wrap_man
(( ${+commands[sudo]} )) && autoload -z wrap_sudo


WORDCHARS='*?_[]~=&;!#$%^(){}``' # ! Dont consider certain characters part of the word
PROMPT_EOL_MARK=" "

if [[ -f ${ZI[BIN_DIR]}/zi.zsh ]]; then

    source "${ZI[BIN_DIR]}/zi.zsh"

    autoload -Uz _zi
    (( ${+_comps} )) && _comps[zi]=_zi

    zi silent light-mode for \
        id-as='z-a-bin-gem-node' \
        compile='functions/.*bgn*~*.zwc' \
    z-shell/z-a-bin-gem-node \
        id-as='z-a-meta-plugins' \
    z-shell/z-a-meta-plugins \
        id-as='z-a-default-ice' \
    z-shell/z-a-default-ice \
        id-as='z-a-eval' \
        atinit='Z_A_USECOMP=1' \
        compile='functions/.*ev*~*.zwc' \
    z-shell/z-a-eval \
        id-as='z-a-unscope' \
    z-shell/z-a-unscope \
        id-as='z-a-submods' \
        compile='functions/.*submods*~*.zwc' \
    z-shell/z-a-submods \
        id-as='z-a-linkman' \
        compile='functions/.*lman*~*.zwc' \
    z-shell/z-a-linkman \
        id-as='z-a-linkbin' \
        compile='functions/*za-lb*~*.zwc' \
    z-shell/z-a-linkbin \
        id-as='z-a-readurl' \
        compile='functions/.*readurl*~*.zwc' \
    z-shell/z-a-readurl \
        id-as='z-a-patch-dl' \
        compile='functions/.*patch-dl*~*.zwc' \
    z-shell/z-a-patch-dl \
        id-as='z-a-rust' \
        compile='functions/.*rust*~*.zwc' \
    z-shell/z-a-rust \
        id-as='zui' \
    z-shell/zui \
        id-as='zconvey' \
        as='program' \
        lbin='cmds/*' \
    z-shell/zconvey \
        id-as='zflai' \
    z-shell/zflai \
        id-as='ztrace' \
    z-shell/ztrace \
        id-as='zi-console' \
    z-shell/zi-console \
        id-as='zmorpho' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/zmorpho.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/zmorpho.zsh"; \
            ' \
    z-shell/zsh-morpho \
        id-as='zzcomplete' \
    z-shell/zzcomplete

    zi lucid is-snippet for \
        id-as='omz-functions' \
    "${ZI[CONFIG_DIR]}/lib/functions.zsh" \
        id-as='omz-git' \
    "${ZI[CONFIG_DIR]}/lib/git.zsh" \
        id-as='omz-clipboard' \
    "${ZI[CONFIG_DIR]}/lib/clipboard.zsh" \
        id-as='omz-spectrum' \
    "${ZI[CONFIG_DIR]}/lib/spectrum.zsh" \
        id-as='omz-termsupport' \
    "${ZI[CONFIG_DIR]}/lib/termsupport.zsh" \
            id-as='omz-misc' \
    "${ZI[CONFIG_DIR]}/lib/misc.zsh" \
        id-as='prompt_info_functions' \
    "${ZI[CONFIG_DIR]}/lib/prompt_info_functions.zsh" \
        id-as='async' \
    "${ZI[CONFIG_DIR]}/lib/async.zsh" \
        id-as='systemd' \
        has='systemctl' \
        if='[[ $(systemctl is-system-running) != offline ]]' \
    "${ZI[CONFIG_DIR]}/lib/systemd.zsh" \
        id-as='sys-admin' \
        has='ip' \
    "${ZI[CONFIG_DIR]}/lib/sys-admin.zsh" \
        id-as='apt-deb' \
        has='apt' \
    "${ZI[CONFIG_DIR]}/lib/apt-deb.zsh" \
        id-as='bash-aliases' \
        aliases \
        bash \
    "${SHELLRCD:-${HOME}/.config/rc.d}/bash/aliases.sh" \
        id-as='zsh-aliases' \
        aliases \
    "${ZI[CONFIG_DIR]}/lib/aliases.zsh" \
        id-as='kali-prompt' \
        atload='!prompt_precmd' \
        is-snippet \
    "${ZI[CONFIG_DIR]}/lib/kali-prompt.zsh"

        # atint='PROMPT_SYMBOL=┗╸λ'

    zi wait='0a' lucid light-mode for \
        if='test -d "${HOME}/.ssh"' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/ssh-agent.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/ssh-agent.zsh"; \
            ' \
        run-atpull \
    OMZ::plugins/ssh-agent \
        has='tmux' \
    OMZ::plugins/tmux \
        has='python' \
    OMZ::plugins/shell-proxy \
        has='node' \
    OMZ::plugins/node \
        has='npm' \
    OMZ::plugins/npm \
        has='nmap' \
    OMZ::plugins/nmap

    zi wait='0b' lucid for \
        skip='color' \
    @zunit \
    @console-style \
        pack='bgn' \
    @pyenv \
        id-as='tree-sitter' \
        from='gh-r' \
        lbin='tree-sitter* -> tree-sitter' \
        binary \
    tree-sitter/tree-sitter \
        id-as='diff-so-fancy' \
        as='null' \
        lbin='bin/git-dsf \
              bin/diff-so-fancy \
              bin/fancy-diff \
            ' \
    z-shell/zsh-diff-so-fancy \
        id-as='zsh-histdb' \
        atinit='test -f "${ZI[CACHE_DIR]}/histdb/zsh-history.db" && \
                    export HISTDB_FILE="${ZI[CACHE_DIR]}/histdb/zsh-history.db"; \
            ' \
        atload='alias historydb="histdb --desc --details --limit 24"' \
        compile='{*sqlite*~*.zwc,*histdb*~*.zwc}' \
    larkery/zsh-histdb \
        id-as='zsh-autopair' \
        compile='autopair*~*.zwc' \
    hlissner/zsh-autopair \
        id-as='local-completions' \
        eval='!+zi-message "Installing local ZSH completions, functions..." \
                command cp -fuv /usr/share/zsh/functions/Completion/*/_* \
                "${ZI[CONFIG_DIR]}/completions" \
                command cp -fuv /usr/share/zsh/{*-functions,*-completions}/_* \
                "${ZI[CONFIG_DIR]}/completions" \
                zi creinstall "${ZI[CONFIG_DIR]}/completions"; zi cclear
            ' \
        atload='zi-prepend-fpath "${ZI[CONFIG_DIR]}/functions"; zpcompinit; zpcdreplay' \
        run-atpull \
        nocompile \
    z-shell/0

    ## ? call zsh compinit in system-completions at very end of block before loading fzf-tab, syntax hl, etc.
    ## ! DON'T add ANY completions in below plugin block..!
    zi wait='0c' lucid for \
        id-as='fzf-tab' \
        has='fzf' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/comp-opts.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/comp-opts.zsh" \
            ' \
        compile='lib/{-ftb,ftb}*~*.zwc' \
    Aloxaf/fzf-tab \
        id-as='zsh-fast-syntax-highlighting' \
        atload='fast-theme z-shell &>/dev/null' \
        compile='{functions/{.fast,fast}-*~*.zwc,chroma/*~*.zwc}' \
    z-shell/F-Sy-H \
        id-as='zsh-autosuggestions' \
        eval='!test -f "${ZI[CONFIG_DIR]}/options/key-bindings.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/key-bindings.zsh"; \
                test -f "${ZI[CONFIG_DIR]}/options/autosuggest-opts.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/autosuggest-opts.zsh"; \
            ' \
        atload='!_zsh_autosuggest_start' \
        compile='{src/*.zsh*~*.zwc,src/strategies/*~*.zwc}' \
    zsh-users/zsh-autosuggestions \
        id-as='zsh-history-multiword-search' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/history/history-multiword-search.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/history/history-multiword-search.zsh" \
            ' \
        compile='functions/h*~*.zwc' \
    z-shell/H-S-MW

fi

# _zsh-dot() {
# 	if [[ ${LBUFFER} = *.. ]]; then
# 		LBUFFER+=/..
# 	else
# 		LBUFFER+=.
# 	fi
# }
# zle -N _zsh-dot
# bindkey . _zsh-dot

# # Fullscreen command line edit
# autoload -Uz edit-command-line
# zle -N edit-command-line
# bindkey "^X^E" edit-command-line

# # enable completion features
# autoload -Uz compinit && compinit

# zstyle ':completion:*' menu yes select search
# zstyle ':completion:*' complete true
# zstyle ':completion:*' verbose true
# zstyle ':completion:*' use-cache on
# # zstyle ':completion:*' cache-path '~/.cache/zcompdump'
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' completer _expand _complete

# zle -C alias-expension complete-word _generic
# bindkey '^Xa' alias-expension
# zstyle ':completion:alias-expension:*' completer _alias _generic
# zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
# # # Required for completion to be in good groups (named after the tags)
# zstyle ':completion:*' group-name ''
# zstyle ':completion:complete:*:options' sort false
# zstyle ':completion:*:manuals' separate-sections true
# # disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false
# # zstyle ':complete:px:*:*:*:processes' command "px --top "
# # disable sort when completing options of any command
# zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
# # Only display some tags for the command cd
# zstyle :completion':*:*:cd:*' tag-order local-directories directory-stack path-directories

# zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# zstyle ':completion:*:kill:*' command 'ps -u ${USER} -o pid,%cpu,tty,cputime,cmd -w -w '
# zstyle ':completion:*:*:px:*' command 'px --top '
# # zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# if [[ $(tty) = "/dev/pts/0" ]] && [[ $TERM_PROGRAM != 'vscode' ]]; then
#     fetch_cmd=$(command -v fastfetch || command -v neofetch)

#     case "${fetch_cmd}" in
#     *fastfetch*)
#         fastfetch
#         ;;
#     *neofetch*)
#         neofetch
#         ;;
#     *)
#         echo "No system info fetcher command found..."
#         ;;
#     esac

# fi

# ? enable command-not-found if installed
if [[ -f /etc/zsh_command_not_found ]]; then
    source /etc/zsh_command_not_found
fi
