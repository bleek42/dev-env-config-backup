#!/usr/bin/env zsh

### * ${HOME}/.zshrc file for zsh interactive shells.
## ? see /usr/share/doc/zsh/examples/zshrc for examples
[[ -o interactive ]] || return # ! if not in interactive mode, return to stop the whole script from running and exit with code 1 (universally accepted as a shell error)

### * Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
### * Initialization code that may require console input (password prompts, [y/n]
### * confirmations, etc.) must go above this block; everything else may go below.
typeset -g POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

if [[ -r ${XDG_CACHE_DIR:-${HOME}/.cache}/zi/p10k-instant-prompt-${(%):-%n}.zsh ]]; then
    source "${XDG_CACHE_DIR:-${HOME}/.cache}/zi/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f ${HOME}/.cache/zsh/zhistfile ]]; then
    touch "${HOME}/.cache/zsh/zhistfile"
fi

if [[ -d "${XDG_CONFIG_HOME:-${HOME}/.config}/rc.d/zsh/completions" ]]; then
    fpath=( "${XDG_CONFIG_HOME:-${HOME}/.config}/rc.d/zsh/completions" $fpath )
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
setopt case_match        # ! make regular expression matches case sensitive
setopt dot_glob          # ! include dotfiles in glob matches
setopt case_glob         # ! make globbing case sensitive
setopt null_glob         # ! remove glob from arg list instead of reporting an error if no returned matches
setopt extended_glob     # ! enable extended globbing
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
HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/zsh/zhistfile"

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
    unset d
fi

# ! enable colors
autoload -Uz colors && colors

# ! Enable run-help module
(( ${+aliases[help]} )) && unalias help
autoload -Uz run-help

## ? enable zsh enhanced version of default 'mv' command
## ? use as alternative for moving or copying files & dirs
autoload -Uz zmv

if [[ $(tty) == /dev/pts/0 ]] && [[ $TERM_PROGRAM != vscode ]]; then
    fetch_cmd="$(command -v fastfetch || command -v neofetch || return 1)"
    # echo '${fetch_cmd}'

    case "$fetch_cmd" in
    */fastfetch)
        fastfetch
        ;;
    */neofetch)
        neofetch
        ;;
    *)
        echo 'Unable to display system information: no fetch command found in PATH...'
        ;;
    esac

fi

if [[ -f ${ZI[BIN_DIR]}/zi.zsh ]]; then

    source "${ZI[BIN_DIR]}/zi.zsh"

    autoload -Uz _zi
    (( ${+_comps} )) && _comps[zi]=_zi

    if [[ -d ${ZI[ZMODULES_DIR]}/zpmod/Src ]]; then
        module_path+=( "${ZI[ZMODULES_DIR]}/zpmod/Src" )
        zmodload zi/zpmod
    fi

    zi lucid silent for \
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

    zi lucid is-snippet compile for \
        id-as='clipboard-zsh' \
    "${ZI[CONFIG_DIR]}/lib/clipboard.zsh" \
        id-as='git-zsh' \
    "${ZI[CONFIG_DIR]}/lib/git.zsh" \
        id-as='termsupport-zsh' \
    "${ZI[CONFIG_DIR]}/lib/termsupport.zsh" \
            id-as='funcs-zsh' \
    "${ZI[CONFIG_DIR]}/lib/funcs.zsh" \
        id-as='spectrum-zsh' \
    "${ZI[CONFIG_DIR]}/lib/spectrum.zsh" \
        id-as='proxy-zsh' \
    "${ZI[CONFIG_DIR]}/lib/proxy.zsh" \
        id-as='systemd-zsh' \
        has='systemctl' \
        if='[[ $(systemctl is-system-running) != offline ]]' \
    "${ZI[CONFIG_DIR]}/lib/systemd.zsh" \
        id-as='sysadmin-zsh' \
        has='ip' \
    "${ZI[CONFIG_DIR]}/lib/sys-admin.zsh" \
        id-as='dpkg-apt-zsh' \
        has='dpkg' \
    "${ZI[CONFIG_DIR]}/lib/dpkg-apt.zsh" \
        id-as='tmux-zsh' \
        has='tmux' \
    "${ZI[CONFIG_DIR]}/lib/tmux.zsh" \
        id-as='fzf-zsh' \
        has='fzf' \
    "${ZI[CONFIG_DIR]}/lib/fzf.zsh" \
        id-as='async-zsh' \
    "${ZI[CONFIG_DIR]}/lib/async.zsh" \
        id-as='pure-lambda' \
    "${ZI[CONFIG_DIR]}/options/prompt/pure-lambda.zsh" \
        id-as='pure-prompt' \
    "${ZI[CONFIG_DIR]}/options/prompt/pure-prompt.zsh"

    zi lucid light-mode for \
        if='test -d "${HOME}/.ssh"' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/ssh-agent.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/ssh-agent.zsh" \
                ' \
    OMZ::plugins/ssh-agent \
        has='nmap' \
    OMZ::plugins/nmap \
        id-as='firewalld-zsh' \
        has='firewalld' \
    OMZ::plugins/firewalld \
        id-as='nodedocs-zsh' \
        has='node' \
    OMZ::plugins/node \
        id-as='npm-zsh' \
        has='npm' \
    OMZ::plugins/npm \
        id-as='terraform-zsh' \
        has='terraform' \
        atload='RPROMPT+=$(tf_prompt_info)' \
    OMZ::plugins/terraform

    # !GEOMETRY_SYMBOL_PROMPT=󰘧 GEOMETRY_SYMBOL_PROMPT_COLOR=green; GEOMETRY_COLOR_DIR=63; GEOMETRY_PATH_COLOR=63; geometry::prompt

    zi wait='0a' lucid for \
    @rust-utils \
        id-as='autopair-zsh' \
        compile='autopair*~*.zwc' \
    hlissner/zsh-autopair \
        id-as='zui' \
    z-shell/zui \
        id-as='zflai' \
    z-shell/zflai \
        id-as='ztrace' \
    z-shell/ztrace \
        id-as='zmorpho' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/zmorpho.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/zmorpho.zsh" \
                ' \
        nocompile \
    z-shell/zsh-morpho \
        id-as='unique-id-zsh' \
    z-shell/zsh-unique-id \
        id-as='zi-console' \
    z-shell/zi-console \
        id-as='zzcomplete' \
    z-shell/zzcomplete \
        id-as='diff-so-fancy' \
        null \
        lbin='!bin/*' \
    z-shell/zsh-diff-so-fancy \
        id-as='revolver' \
        null \
        lbin='!revolver' \
    zdharma/revolver

    zi wait='0b' lucid for \
        id-as='zunit' \
        has='revolver' \
        eval='!./build.zsh 2>/dev/null' \
        lbin='!zunit' \
        binary \
        run-atpull \
    zdharma/zunit \
        id-as='eza-rust' \
        cargo='!eza' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/eza-ls.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/eza-ls.zsh" \
                ' \
        rustup \
        binary \
        run-atpull \
    z-shell/0 \
        id-as='fnm-rust' \
        cargo='!fnm' \
        atload='!eval "$(fnm env --use-on-cd --corepack-enabled --shell zsh)";' \
        rustup \
        binary \
        run-atpull \
    z-shell/0 \
        id-as='tree-sitter' \
        null \
        from='gh-r' \
        lbin='!tree-sitter-* -> tree-sitter' \
        bpick='*-linux-x64.gz' \
        binary \
        run-atpull \
    tree-sitter/tree-sitter \
        id-as='pyenv' \
        pack='bgn' \
    z-shell/pyenv \
        id-as='aliases-common' \
        is-snippet \
        aliases \
        bash \
    "${SHELLRCD}/common/aliases.sh" \
        id-as='aliases-zsh' \
        is-snippet \
        aliases \
    "${ZI[CONFIG_DIR]}/lib/aliases.zsh" \
        id-as='histdb-zsh' \
        atinit='test -f "${ZI[CACHE_DIR]}/histdb/zsh-history.db" && \
                export HISTDB_FILE="${ZI[CACHE_DIR]}/histdb/zsh-history.db"; \
            ' \
        atload='alias histdbd="histdb --desc --details --limit 24"' \
        compile='{*sqlite*~*.zwc,*histdb*~*.zwc}' \
    larkery/zsh-histdb \
        id-as='local-completions' \
        as='completion' \
        eval='!command cp -ru /usr/share/zsh/functions/Completion/*/_*  "${ZI[CONFIG_DIR]}/completions"; \
                command cp -ru /usr/share/zsh/*-functions*/_* "${ZI[CONFIG_DIR]}/completions"; \
                command cp -ru /usr/share/zsh/*-completions*/_* "${ZI[CONFIG_DIR]}/completions"; \
                zi creinstall "${ZI[CONFIG_DIR]}/completions"; \
                zi cclear \
            ' \
        atload='zpcompinit; zpcdreplay' \
        nocompile \
        run-atpull \
    z-shell/0

    ## ? call zsh compinit in system-completions at very end of block before loading fzf-tab, syntax hl, etc.
    ## ! DON'T add ANY completions in below plugin block..!

    zi wait='0c' lucid for \
        id-as='fzf-tab' \
        has='fzf' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/comp-opts.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/comp-opts.zsh"' \
        compile='lib/{-ftb,ftb}*~*.zwc' \
    Aloxaf/fzf-tab \
        id-as='fast-syntax-highlighting-zsh' \
        atload='fast-theme zdharma &>/dev/null' \
        compile='{functions/{.fast,fast}-*~*.zwc,chroma/*~*.zwc}' \
    z-shell/F-Sy-H \
        id-as='history-mw-search-zsh' \
        atload='test -f "${ZI[CONFIG_DIR]}/options/history/history-multiword-search.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/history/history-multiword-search.zsh"; \
                test -f "${ZI[CONFIG_DIR]}/options/key-bindings.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/key-bindings.zsh"; \
                ' \
        compile='functions/h*~*.zwc' \
    z-shell/H-S-MW \
        id-as='autosuggestions-zsh' \
        atinit='!test -f "${ZI[CONFIG_DIR]}/options/autosuggest-opts.zsh" && \
                    source "${ZI[CONFIG_DIR]}/options/autosuggest-opts.zsh" \
                ' \
        atload='!_zsh_autosuggest_start' \
        compile='{src/strategies/*~*.zwc,src/*.zsh*~*.zwc}' \
    zsh-users/zsh-autosuggestions \
        id-as='command_not_found' \
        is-snippet \
        bash \
    "${SHELLRCD}/common/command_not_found.sh"

else

    for src in "${XDG_CONFIG_HOME:-${HOME}/.config}"/rc.d/zsh/lib/*; do
        echo "sourcing $src from ~/.config/rc.d/zsh/lib ..."
        source "$src"
    done
    unset src

    for src in "${XDG_CONFIG_HOME:-${HOME}/.config}"/rc.d/zsh/options/*; do
        echo "sourcing ${src} from ~/.config/rc.d/zsh/options ..."
        source "$src"
    done
    unset src

fi

# RPROMPT="$(systemd_prompt_info systemd-sysusers.service user.slice)"
