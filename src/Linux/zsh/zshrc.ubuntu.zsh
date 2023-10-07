#!/usr/bin/env zsh

# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

# [[ -o interactive ]] || return 0

if [ -f "$ZPLUG_HOME/.config/zplug/init.zsh" ]; then
    source "$ZPLUG_HOME/.config/zplug/init.zsh"
elif [ -f "$ZPLUG_ROOT/init.zsh" ]; then
    source /usr/share/zplug/init.zsh
else
    echo "zplug not found..."
fi

if command -v zplug >/dev/null 2>&1; then
    ### ! ZPLUG
    ## ? Make sure to use double quotes
    ## ? zplug "plugins/ubuntu", from:oh-my-zsh, if:"command -v apt >/dev/null 2>&1;"
    ## ? Set the priority when loading
    ## ? e.g., zsh-syntax-highlighting must be loaded
    ## ? after executing compinit command and sourcing other plugins
    ## ? (If the defer tag is given 2 or above, run after compinit command)
    ## ? zplug "zsh-users/zsh-syntax-highlighting", defer:2
    ## ? zplug "unixorn/docker-helpers", from:gh-r, use:'docker-helpers.plugin.zsh'
    ## ? zplug "plugins/ubuntu", from:oh-my-zsh, if:"command -v apt >/dev/null 2>&1"C


    zplug "Aloxaf/fzf-tab", \
        use:'fzf-tab.plugin.zsh', \
        defer:2

    zplug "/usr/share/zsh-autosuggestions", \
        from:local, \
        use:'zsh-autosuggestions.zsh', \
        defer:2

    zplug "hlissner/zsh-autopair", \
        use:'autopair.plugin.zsh', \
        defer:2

    zplug "zdharma-continuum/fast-syntax-highlighting", \
        use:'fast-syntax-highlighting.plugin.zsh', \
        defer:3

    zplug "zsh-users/zsh-history-substring-search", \
        use:'zsh-history-substring-search.plugin.zsh', \
        defer:3

    zplug "~/.config/rc.d/zsh/themes", \
        from:local, \
        as:theme, \
        use:'strug.zsh-theme', \
        defer:3

    zplug "plugins/systemd", \
        from:oh-my-zsh, \
        defer:3
        
    zplug "plugins/systemadmin", \
        from:oh-my-zsh, \
        defer:3


    # Install plugins if there are plugins that have not been installed
    if ! zplug check; then
        # printf "Install? [y/N]: "
        # if read -q; then
        zplug install
        # fi
    fi

    # Then, source plugins and add commands to $PATH
    zplug load

    # export ZPLUG_ROOT ZPLUG_HOME ZPLUG_BIN ZPLUG_LOADFILE ZPLUG_CACHE_DIR ZPLUG_ERROR_LOG ZPLUG_REPOS ZPLUG_USE_CACHE ZPLUG_PROTOCOL ZPLUG_FILTER
fi

#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
# setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch         # hide error message if there is no match for the pattern
setopt notify            # report the status of background jobs immediately
setopt prompt_subst      # enable command substitution in prompt
setopt sh_word_split     # split fields on unquoted parameter expansions (bash compatibility)
setopt numeric_glob_sort # sort filenames numerically when it makes sense
setopt flow_control      # use Ctrl+S / Ctrl+Q to stop and continue flow
setopt prompt_subst
setopt null_glob
setopt extended_glob

# History configurations
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share

HISTFILE="$HOME/.cache/zhistory"
HISTSIZE=8000
SAVEHIST=8000

alias history='history -50'

WORDCHARS='*?_[]~=&;!#$%^(){}' # Dont consider certain characters part of the word
PROMPT_EOL_MARK=" "

# Fullscreen command line edit
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Enable run-help module
autoload -z run-help
alias help='run-help'

# enable bracketed paste
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# enable url-quote-magic
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Enable functions from archive plugin
# fpath+="$ZDOTDIR/plugins/archive"
autoload -Uz archive lsarchive unarchive

# Custom personal functions
# Don't use -U as we need aliases here
autoload -z lspath bag fgb fgd fgl fz ineachdir psg vpaste evalcache compdefcache

# # Enable wrapper, if original command is available
# (( ${+commands[man]} )) && autoload -z wrap_man
# (( ${+commands[sudo]} )) && autoload -z wrap_sudo

autoload -Uz colors && colors

zmodload zsh/terminfo
zmodload zsh/zutil
zmodload zsh/complist

# enable completion features
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

zstyle ':completion:*' complete true
zstyle ':completion:*' verbose true
zstyle ':completion:*:*' sort true
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' use-cache on
zstyle ':completion:*:descriptions' format '[%d]'

zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _alias _generic
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' keep-prefix true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
# # Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
zstyle ':completion:complete:*:options' sort false
zstyle ':completion:*:manuals' separate-sections true
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# zstyle ':complete:px:*:*:*:processes' command "px --top "
# disable sort when completing options of any command
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
# Only display some tags for the command cd
zstyle :completion':*:*:cd:*' tag-order local-directories directory-stack path-directories

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

zstyle ':completion:*:kill:*' command 'ps -u ${USER} -o pid,%cpu,tty,cputime,cmd -w -w '

[[ -f "$HOME/.config/rc.d/common/aliases.sh" ]] && source "$HOME/.config/rc.d/common/aliases.sh"

if command -v fzf >/dev/null 2>&1; then
    # [[ -d /usr/share/doc/fzf/examples ]] && source /usr/share/doc/fzf/examples/key-bindings.zsh && source /usr/share/doc/fzf/examples/completions.zsh
    [[ -f "$HOME/.config/rc.d/zsh/fzf-config.zsh" ]] && source "$HOME/.config/rc.d/zsh/fzf-config.zsh"
else
    # Allow you to select in a menu
    zstyle ':completion:*' menu select
    zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
    zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
    [[ -f "usr/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "usr/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
    [[ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "usr/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# typeset -A key
# configure key keybindings
bindkey -e # emacs key bindings
# bindkey '^I' expand-or-complete-prefix # tab comp
bindkey '^Xh' _complete_help
bindkey ' ' magic-space                        # do history expansion on space
bindkey '^U' backward-kill-line                # ctrl + U
bindkey '^[[3;5~' kill-word                    # ctrl + Supr
bindkey '^[[3~' delete-char                    # delete
bindkey '^[[1;5C' end-of-line                  # ctrl + ->
bindkey '^[[1;5D' beginning-of-line            # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history # page up
bindkey '^[[6~' end-of-buffer-or-history       # page down
bindkey '^[[H' forward-word                    # home
bindkey '^[[F' end-of-line                     # end
bindkey '^Z' undo                              # ctrl + Z undo last action
# Make dot key autoexpand "..." to "../.." and so on

_zsh-dot() {
    if [[ ${LBUFFER} = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N _zsh-dot
bindkey . _zsh-dot

# # Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
# set variable identifying the chroot you work in (used in the prompt below)
if [[ -z ${debian_chroot:-} ]] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt* | Eterm | aterm | kterm | gnome* | alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*) ;;
esac

precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi

    # export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $(fzf_sizer_preview_window_settings)"
}

# Determines prompt modifier if and when a conda environment is active
precmd_conda_info() {
    if [[ -n $CONDA_DEFAULT_ENV ]]; then
        CONDA_ENV="($CONDA_DEFAULT_ENV)"
        RPROMPT="%B%F{cyan}$CONDA_ENV%b%f"
    # When no conda environment is active, don't show anything
    else
        CONDA_ENV=""
    fi
}

precmd_functions+=(precmd precmd_conda_info)

if zplug check '/usr/share/zsh-autosuggestions'; then
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
fi

if zplug check 'hlissner/zsh-autopair'; then
    typeset -gA AUTOPAIR_PAIRS
    AUTOPAIR_PAIRS+=("<" ">")
    AUTOPAIR_PAIRS+=("{" "}")
    AUTOPAIR_PAIRS+=("[" "]")
    AUTOPAIR_PAIRS+=("'" "'")
    AUTOPAIR_PAIRS+=("(" ")")
    AUTOPAIR_PAIRS+=('"' '"')
    AUTOPAIR_PAIRS+=('`' '`')
fi

if command -v direnv >/dev/null 2>&1; then
    [[ -f "$HOME/.envrc" ]] && eval "$(direnv hook zsh)"
fi

[[ -x $(command -v neofetch) ]] && [[ $(tty) = "/dev/pts/0" ]] && neofetch

# export RPROMPT='$(systemd_prompt_info systemd-sysusers.service user.slice)'

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
fi

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/conda/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/conda/etc/profile.d/conda.sh" ]; then
#         . "/opt/conda/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/conda/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
