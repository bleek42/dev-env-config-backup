#!/usr/bin/env zsh

# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

# ZDOTDIR="/usr/share/zsh:${ZDOTDIR}"
# ZSH=/usr/share/zsh
# ZSH_GIT_PROMPT_ENABLE_SECONDARY=1



[[ -o interactive ]] || return

if [ -f "$ZPLUG_HOME/init.zsh" ]; then
    source "$HOME/.config/zplug/init.zsh"
elif [ -f "$ZPLUG_ROOT/init.zsh" ]; then
    source "$ZPLUG_ROOT/init.zsh"
else
    echo "No ${ZPLUG_HOME} or ${ZPLUG_ROOT}"
fi

if command -v zplug >/dev/null 2>&1; then
    # Make sure to use double quotes


    # Set the priority when loading
    # e.g., zsh-syntax-highlighting must be loaded
    # after executing compinit command and sourcing other plugins
    # (If the defer tag is given 2 or above, run after compinit command)
    # zplug "zsh-users/zsh-syntax-highlighting", defer:2
    # zplug "unixorn/docker-helpers", from:gh-r, use:'docker-helpers.plugin.zsh'
    # zplug "plugins/ubuntu", from:oh-my-zsh, if:"command -v apt >/dev/null 2>&1"C
    # zplug "$HOME/.local/share/dragon", from:local, as:theme, use:'dragon.zsh-theme'
    # zplug "plugins/ubuntu", from:oh-my-zsh, if:"command -v apt >/dev/null 2>&1;"

    zplug "/usr/share/zsh-autosuggestions", \
        from:local, \
        use:'zsh-autosuggestions.zsh', \
        defer:2

    zplug "hlissner/zsh-autopair", \
        use:'autopair.plugin.zsh', \
        defer:2

    zplug "Aloxaf/fzf-tab", \
        use:'fzf-tab.plugin.zsh', \
        defer:2

    zplug "zdharma-continuum/fast-syntax-highlighting", \
        use:'fast-syntax-highlighting.plugin.zsh', \
        defer:2

    zplug "zsh-users/zsh-history-substring-search", \
        use:'zsh-history-substring-search.zsh', \
        defer:3

    zplug "woefe/git-prompt.zsh", \
        use:'git-prompt.plugin.zsh', \
        defer:3

    zplug "plugins/systemadmin", \
        from:oh-my-zsh, \
        use:'systemadmin.plugin.zsh', \
        defer:3

    zplug "plugins/nmap", \
        from:oh-my-zsh, \
        use:'nmap.plugin.zsh', \
        defer:3

    # ! Install plugins if there are plugins that have not been installed
    if ! zplug check; then
        printf "Install? [y/N]: "
        if read -q; then
            zplug install
        fi
    fi

    # Then, source plugins and add commands to $PATH
    zplug load --verbose

fi

setopt autocd # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt prompt_subst        # enable command substitution in prompt
setopt sh_word_split       # split fields on unquoted parameter expansions (bash compatibility)
setopt numeric_glob_sort   # sort filenames numerically when it makes sense
setopt flow_control        # use Ctrl+S / Ctrl+Q to stop and continue flow

setopt null_glob
setopt extended_glob
# History configurations
# enable auto-suggestions based on the history
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share
HISTFILE="$HOME/.cache/zhistory"
HISTSIZE=8000
SAVEHIST=8000
alias history='history -50'

WORDCHARS='*?_[]~=&;!#$%^(){}' # Don't consider certain characters part of the word
PROMPT_EOL_MARK=" "

# configure key keybindings
bindkey -e # emacs key bindings
# typeset -A key

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

# # Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
# Make dot key autoexpand "..." to "../.." and so on
# Initialize colors

_zsh-dot() {
    if [[ ${LBUFFER} = *.. ]]; then
        LBUFFER+=/..
    else
        LBUFFER+=.
    fi
}
zle -N _zsh-dot
bindkey . _zsh-dot

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

# enable completion features
zmodload zsh/complist
# enable completion features
autoload -Uz compinit && compinit

zstyle ':completion:*' menu yes select search
zstyle ':completion:*' complete true
zstyle ':completion:*' verbose true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path '${HOME}/.cache/zcompdump'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' completer _expand _complete

zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _alias _generic
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
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
zstyle ':completion:*:*:px:*' command 'px --top '
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

[[ -f "$HOME/.config/rc.d/common/aliases.sh" ]] && source "$HOME/.config/rc.d/common/aliases.sh"

if command -v fzf >/dev/null 2>&1; then

    [[ -f "usr/share/doc/fzf/examples/key-bindings.zsh" ]] && source "/usr/share/doc/fzf/examples/key-bindings.zsh"
    [[ -f "/usr/share/doc/fzf/examples/completion.zsh" ]] && source "/usr/share/doc/fzf/examples/completion.zsh"
    [[ -f "$HOME/.config/rc.d/zsh/fzf-config.zsh" ]] && source "$HOME/.config/rc.d/zsh/fzf-config.zsh"

else
    # Allow you to select in a menu
    zstyle ':completion:*' menu select
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' keep-prefix true
    zstyle ':completion:*' select-prompt %Scurrent selection @ %p%s
    zstyle ':completion:*' format 'Completing %d'
    zstyle ':completion:*' auto-description 'specify: %d'
    zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
    [[ -f "usr/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "usr/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
    [[ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "usr/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

fi

autoload -Uz bashcompinit
bashcompinit
# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

configure_prompt() {
    prompt_symbol='[ 󰨡  ]:(  )'
    # Skull emoji for root terminal
    [ "$EUID" -eq 0 ] && prompt_symbol='[ 󰨡   ]:{  󰚌 }'
    case "$PROMPT_ALTERNATIVE" in
    twoline)
        PROMPT=$'%{$fg_bold[green]%}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]$reset_color$(gitprompt)\n%{$fg_bold[green]%}└─%B%(#.%F{green}#.%F{blue}λ)%b%F{reset} '
        # Right-side prompt with exit codes and background processes
        RPROMPT='%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
        ;;
    oneline)
        PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{%(#.red.blue)}%n@%m%b%F{reset}:%B%F{%(#.blue.green)}%~%b%F{reset}%(#.#.$(gitprompt)) '
        RPROMPT=
        # $(__git_ps1 " %%F{cyan}%%f %s")
        ;;
    backtrack)
        PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{red}%n@%m%b%F{reset}:%B%F{blue}%~%b%F{reset}%(#.#.$(gitprompt)) '
        RPROMPT=
        ;;
    esac
    unset prompt_symbol
}

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    configure_prompt

else

    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) '
fi
unset color_prompt force_color_prompt

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
}

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

if zplug check 'hlissner/zsh-autopair'; then
    # source "$ZSH_CUSTOM/plugins/zsh-autopair/autopair.zsh"
    # bindkey '^I' expand-or-complete-prefix
    autopair-init
    typeset -gA AUTOPAIR_PAIRS
    AUTOPAIR_PAIRS+=("<" ">")
    AUTOPAIR_PAIRS+=("{" "}")
    AUTOPAIR_PAIRS+=("[" "]")
    AUTOPAIR_PAIRS+=("'" "'")
    AUTOPAIR_PAIRS+=("(" ")")
    AUTOPAIR_PAIRS+=('"' '"')
    AUTOPAIR_PAIRS+=('`' '`')
fi

[[ -n $(command -v direnv) ]] && [[ -f "$HOME/.envrc" ]] && eval "$(direnv hook zsh)"

<<<<<<<< HEAD:src/Linux/zsh/zshrc.kali.zsh
[[ $(command -v neofetch) ]] && [[ $(tty) = "/dev/pts/0" ]] && neofetch
========
[[ -n $(command -v neofetch) ]] && [[ $(tty) = "/dev/pts/0" ]] && [[ $TERM_PROGRAM != 'vscode' ]] && neofetch
>>>>>>>> eeb0c53b83d2413dd0ef6bd0ecfb776c4876651a:src/Linux/zsh/zsh/zshrc.zsh

# enable command-not-found if installed
[[ -f /etc/zsh_command_not_found ]] && source /etc/zsh_command_not_found
