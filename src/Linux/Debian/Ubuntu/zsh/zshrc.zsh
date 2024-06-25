#!/usr/bin/env zsh

### * ${HOME}/.zshrc file for zsh interactive shells.
## ? see /usr/share/doc/zsh/examples/zshrc for examples
[[ -o interactive ]] || exit 1 # ! if not in interactive mode, return to stop the whole script from running and exit with code 1 (universally accepted as a shell error)

if [[ ! -d ${ZI[CACHE_DIR]:-${HOME}/.cache/zsh} ]]; then
    mkdir -p "${ZI[CACHE_DIR]:-${HOME}/.cache/zsh}"
fi

if [[ ! -f ${ZI[CACHE_DIR]:-${HOME}/.cache/zsh}/zhistfile ]]; then
    touch "${ZI[CACHE_DIR]:-${HOME}/.cache/zsh}/zhistfile"
fi

### * Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
### * Initialization code that may require console input (password prompts, [y/n]
### * confirmations, etc.) must go above this block; everything else may go below.
typeset -g POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

if [[ -r ${XDG_CACHE_DIR:-${HOME}/.cache}/zi/p10k-instant-prompt-${(%):-%n}.zsh ]]; then
    source "${XDG_CACHE_DIR:-${HOME}/.cache}/zi/p10k-instant-prompt-${(%):-%n}.zsh"
fi

WORDCHARS='*?_[]~=&;!#$%^(){}``' # Dont consider certain characters part of the word
PROMPT_EOL_MARK=" "

## * ###############
## * +-------------+
## * | ZSH OPTIONS |
## * +-------------+
## * ###############

### ? script & function options
setopt multios              # ! enable redirect to multiple streams: echo >file1 >file2
setopt interactive_comments # ! allow comments in interactive mode
setopt long_list_jobs       # ! show long list format job notifications
# setopt local_options # ! shell options are to be restored after returning from a shell function

### ? expansion/globbing options
setopt case_match # ! make regular expression matches case sensitive
setopt dot_glob # ! include dotfiles in glob matches
setopt case_glob # ! make globbing case sensitive
setopt null_glob   # ! if glob doesnt return matches, remove glob from arg list instead of reporting an error
setopt extended_glob # ! enable extended globbing
setopt numeric_glob_sort # ! sort filenames numerically when it makes sense

## * ##############
## * +---------+ ##
## * | HISTORY | ##
## * +---------+ ##
## * ##############

# setopt hist_verify             # ! show command with history expansion to user before running it
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

HISTSIZE=10000
SAVEHIST=10000
HISTTIMEFORMAT='[%F %a %b %d]'
HISTFILE="${ZI[CACHE_DIR]:-${HOME}/.cache/zsh}/zhistfile"

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

## ? enable zsh enhanced version of default 'mv' command
## ? use as alternative for moving or copying files & dirs
autoload -Uz zmv


if [[ -f ${ZI[BIN_DIR]}/zi.zsh ]]; then

    source "${ZI[BIN_DIR]}/zi.zsh"

    module_path+=( "/home/bleek42/.local/share/zsh/zmodules/zpmod/Src" )
    zmodload zi/zpmod

    autoload -Uz _zi
    (( ${+_comps} )) && _comps[zi]=_zi

    zi silent light-mode for \
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
        id-as='z-a-bin-gem-node' \
        compile='functions/.*bgn*~*.zwc' \
    z-a-bin-gem-node \
        id-as='z-a-rust' \
        compile='functions/.*rust*~*.zwc' \
    z-shell/z-a-rust

    zi silent is-snippet for \
        id-as='clipboard' \
    "${ZI[CONFIG_DIR]}/lib/clipboard.zsh" \
        id-as='zsh-git' \
    "${ZI[CONFIG_DIR]}/lib/git.zsh" \
        id-as='termsupport' \
    "${ZI[CONFIG_DIR]}/lib/termsupport.zsh" \
        id-as='spectrum' \
    "${ZI[CONFIG_DIR]}/lib/spectrum.zsh" \
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
        id-as='common-aliases' \
        aliases \
        bash \
    "${SHELLRCD}/common/aliases.sh" \
        id-as='zsh-aliases' \
        aliases \
    "${ZI[CONFIG_DIR]}/lib/aliases.zsh"

    zi wait='0a' lucid light-mode for \
        if='test -d "${HOME}/.ssh"' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/ssh-agent.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/ssh-agent.zsh"; \
            '\
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
    OMZ::plugins/nmap \
        id-as='tree-sitter' \
        from='gh-r' \
        null \
        lbin='tree-sitter-* -> tree-sitter' \
        binary \
        nocompile \
    tree-sitter/tree-sitter \
        id-as='superfile' \
        from='gh-r' \
        null \
        bpick='*linux-*-amd64.tar.gz' \
        lbin='!dist/**/*spf* -> spf' \
        binary \
        extract \
    yorukot/superfile \
        id-as='zunit' \
        null \
        eval='./build.zsh;' \
        lbin='!zunit' \
    zdharma/zunit \
        id-as='revolver' \
        null \
        lbin='!revolver' \
    zdharma/revolver \
        id-as='pyenv' \
        pack='bgn' \
    z-shell/pyenv \
        id-as='diff-so-fancy' \
        lbin='!bin/**' \
        null \
    z-shell/zsh-diff-so-fancy \
        id-as='vivid' \
        from='gh-r' \
        null \
        bpick='*x86_64-unknown-linux-gnu.tar.gz' \
        lbin='!**/* -> vivid' \
        binary \
        extract \
    @sharkdp/vivid

    zi wait='0b' lucid light-mode for \
        id-as='zsh-autopair' \
        compile='autopair*~*.zwc' \
    hlissner/zsh-autopair \
        id-as='zui' \
    z-shell/zui \
        id-as='zflai' \
    z-shell/zflai \
        id-as='ztrace' \
    z-shell/ztrace \
        id-as='zsh-unique-id' \
    z-shell/zsh-unique-id \
        id-as='zi-console' \
    z-shell/zi-console \
        id-as='zmorpho' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/zmorpho.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/zmorpho.zsh"; \
            '\
    z-shell/zsh-morpho \
        id-as='zzcomplete' \
    z-shell/zzcomplete \
        id-as='zsh-histdb' \
        atinit='test -f "${ZI[CACHE_DIR]}/histdb/zsh-history.db" && \
                    export HISTDB_FILE="${ZI[CACHE_DIR]}/histdb/zsh-history.db"; \
            '\
        atload='alias histdbd="histdb --desc --details --limit 24"' \
        compile='{*sqlite*~*.zwc,*histdb*~*.zwc}' \
    larkery/zsh-histdb \
        id-as='local-completions' \
        as='completion' \
        eval='!cp -uf /usr/share/zsh/functions/Completion/{Base,Zsh,Unix,Linux,Debian,AIX,X}/_* "${ZI[CONFIG_DIR]}/completions"; \
                cp -uf /usr/share/zsh/vendor-completions/_* "${ZI[CONFIG_DIR]}/completions"; \
                zi creinstall -q "${ZI[CONFIG_DIR]}/completions"; zi cclear \
            '\
        atload='ziprependfpath "${ZI[CONFIG_DIR]}/completions"; \
                ziprependfpath "${ZI[CONFIG_DIR]}/functions"; \
                zpcompinit; zpcdreplay \
            '\
        run-atpull \
        nocompile \
    z-shell/0

    ## ? call zsh compinit in system-completions at very end of block before loading fzf-tab, syntax hl, etc.
    ## ! DON'T add ANY completions in below plugin block..!

    zi wait='0c' lucid for \
        id-as='fzf-tab' \
        has='fzf' \
        atload='source "${ZI[CONFIG_DIR]}/options/comp-opts.zsh"' \
        compile='lib/{-ftb,ftb}*~*.zwc' \
    Aloxaf/fzf-tab \
        id-as='zsh-fast-syntax-highlighting' \
        atload='fast-theme z-shell &>/dev/null' \
        compile='{functions/{.fast,fast}-*~*.zwc,chroma/*~*.zwc}' \
    z-shell/F-Sy-H \
        id-as='zsh-history-multiword-search' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/history/history-multiword-search.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/history/history-multiword-search.zsh"; \
            '\
        compile='functions/h*~*.zwc' \
    z-shell/H-S-MW \
        id-as='zsh-autosuggestions' \
        eval='!test -f "${ZI[CONFIG_DIR]}/options/key-bindings.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/key-bindings.zsh"; \
                test -f "${ZI[CONFIG_DIR]}/options/autosuggest-opts.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/autosuggest-opts.zsh"; \
            '\
        atload='!_zsh_autosuggest_start' \
        compile='{src/*.zsh*~*.zwc,src/strategies/*~*.zwc}' \
    zsh-users/zsh-autosuggestions

    zi wait='!0' for \
        id-as='powerlevel10k' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/p10k-lambda.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/p10k-lambda.zsh" \
            '\
        depth=1 \
        nocd \
    romkatv/powerlevel10k

fi

# RPROMPT="$(systemd_prompt_info systemd-sysusers.service user.slice)"
# if [[ -n $RANGER_LEVEL ]] && [[ -n $RPROMPT ]]; then
#     RPROMPT=${RPROMPT:+${[ranger]:+$PS4}}

# elif [[ -n $RANGER_LEVEL ]] && [[ -z $RPROMPT ]]; then
#     RPROMPT=${[ranger]:+$PS4}
# fi


# Expand variables and commands in PROMPT variables
# setopt prompt_subst
# Prompt function theming defaults
# ZSH_THEME_GIT_PROMPT_PREFIX="git:("   # Beginning of the git prompt, before the branch name
# ZSH_THEME_GIT_PROMPT_SUFFIX=")"       # End of the git prompt
# ZSH_THEME_GIT_PROMPT_DIRTY="*"        # Text to display if the branch is dirty
# ZSH_THEME_GIT_PROMPT_CLEAN=""         # Text to display if the branch is clean
# ZSH_THEME_RUBY_PROMPT_PREFIX="("
# ZSH_THEME_RUBY_PROMPT_SUFFIX=")"

# if [[ $(tty) == /dev/pts/0 ]] && [[ ${TERM_PROGRAM} != vscode ]]; then
# 	fetch_cmd='$(command -v fastfetch || command -v neofetch || null)'
# 	# echo '${fetch_cmd}'

# 	case '${fetch_cmd}' in
# 	*/fastfetch)
# 		fastfetch
# 		;;
# 	*/neofetch)
# 		neofetch
# 		;;
# 	*)
# 		echo 'Unable to display system information: no fetch command found in PATH...'
# 		;;
# 	esac

# fi

# # enable command-not-found if installed
# if [ -f /etc/zsh_command_not_found ]; then
#     source /etc/zsh_command_not_found
# fi
