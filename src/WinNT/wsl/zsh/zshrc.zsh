#!/usr/bin/env zsh
# ~/.zshrc file for zsh interactive shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

# ZPLUG
export ZPLUG_HOME="$HOME/.config/zplug"
export ZPLUG_BIN="$ZPLUG_HOME/bin"
export ZPLUG_LOADFILE="$ZPLUG_HOME/packages.zsh"
export ZPLUG_CACHE_DIR="$ZPLUG_HOME/cache"
export ZPLUG_USE_CACHE=true
export ZPLUG_ERROR_LOG="$ZPLUG_HOME/error_zplug.log"
export ZPLUG_REPOS="$ZPLUG_HOME/repos"
export ZPLUG_PROTOCOL=HTTPS
export ZPLUG_FILTER=fzf:fzf-tmux:fzy

if [ -f "/usr/share/zplug/init.zsh" ]; then

    source "/usr/share/zplug/init.zsh"

    # Make sure to use double quotes
    zplug "zplug/zplug", hook-build:'zplug --self-manage'

    zplug "plugins/ubuntu", from:oh-my-zsh, if:"command -v apt >/dev/null 2>&1"

    # Set the priority when loading
    # e.g., zsh-syntax-highlighting must be loaded
    # after executing compinit command and sourcing other plugins
    # (If the defer tag is given 2 or above, run after compinit command)
    # zplug "zsh-users/zsh-syntax-highlighting", defer:2
    # zplug "unixorn/docker-helpers", from:gh-r, use:'docker-helpers.plugin.zsh'

    # zplug "$HOME/.local/share/dragon", from:local, as:theme, use:'dragon.zsh-theme'

    zplug "/usr/share/zsh-autosuggestions", from:local, use:'zsh-autosuggestions.zsh', defer:1

    zplug "Aloxaf/fzf-tab", use:'fzf-tab.plugin.zsh', defer:2

    zplug "/usr/share/zsh-syntax-highlighting", from:local, use:'zsh-syntax-highlighting.zsh', defer:2

    zplug "zsh-users/zsh-history-substring-search", use:'zsh-history-substring-search.zsh', defer:3

    # Install plugins if there are plugins that have not been installed

    if ! zplug check; then
        # printf "Install? [y/N]: "
        # if read -q; then
        #     echo
        zplug install
    fi

    # Then, source plugins and add commands to $PATH
    zplug load
    # enable auto-suggestions based on the history
fi

#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
# setopt SH_WORD_SPLIT       # split fields on unquoted parameter expansions (bash compatibility)
# setopt FLOW_CONTROL        # use Ctrl+S / Ctrl+Q to stop and continue flow
setopt null_glob
setopt extended_glob
# History configurations
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share
HISTFILE="$HOME/.config/shell-scripts/.zhistfile"
HISTSIZE=8000
SAVEHIST=8000
WORDCHARS="//\//~!#$%^&*(){}[] <>?.+-_" # Don't consider certain characters part of the word
PROMPT_EOL_MARK=" "
[[ -d "$HOME/.cache/zcompdump" ]] && ZSH_CACHE_DIR="${HOME}/.cache/zcompdump"
# force zsh to show the complete history
alias history="history -50"

if [ -d "$HOME/.config/shell-scripts/common" ]; then
    for file in "${HOME}"/.config/shell-scripts/common/*(DN); do
        source $file
    done
    unset file
fi

# configure key keybindings
bindkey -e # emacs key bindings
# Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-up

# Keybindings for autosuggestions plugin
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-accept

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

# Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-up

# enable completion features
zmodload zsh/complist
autoload -Uz compinit && compinit -C -d "$ZSH_CACHE_DIR"
autoload -Uz bashcompinit && bashcompinit

zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zcompdump
zstyle ':completion:*:*' sort true
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*' verbose true
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*:descriptions' format '[%d]'

# disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false

# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand _alias

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

# Only display some tags for the command cd
zstyle :completion':*:*:cd:*' tag-order local-directories directory-stack path-directories

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:git-checkout:*' sort false # disable sort when completing `git checkout`
zstyle ':completion:*:kill:*' command "ps -u $USER -o pid,%cpu,tty,cputime,cmd"
zstyle ':completion:*:*:*:*:processes' command "px -u $USER --top --color"
# zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# zstyle ':completion:*:*:kubectl:*' list-grouped false

# if [ -d "${HOME}/.config/shell-scripts/zsh" ]; then
#     for file in "${HOME}"/.config/shell-scripts/zsh/*(DN); do
#         source "$file"
#     done
#     unset file
# fi

if ! command -v zplug >/dev/null 2>&1; then
    [ -f "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    [ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

elif zplug check "Aloxaf/fzf-tab" && [ -f "$HOME"/.config/shell-scrs/fzf-config.sh ]; then

    source "$HOME"/.config/shell-scrs/fzf-config.sh

else
    zstyle ':completion:*:*:*:*:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
    zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
    zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
    zstyle ':completion:*' completer _expand _complete

    # zstyle ':fzf-tab:complete:(-command-:|command:option-(v|V)-rest)' fzf-preview \
    #     'case "${group}" in
    # "external command")
    #     less=$word
    #     ;;
    # "executable file")
    #     less ${realpath#--*=}
    #     ;;
    # "builtin command")
    #     $word --help | batcat --color=always --style=numbers || less
    #     ;;
    #     "*")
    #     echo ${(P)word}
    #     ;;
    # esac'

    # zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'

fi

autoload -U colors && colors

if [ -d "/usr/share/zsh-autosuggestions" ]; then
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    # Gray color for autosuggestions
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
fi

if [ -f "$HOME/.config/zsh-syntax-highlighting.zsh" ]; then
    source "$HOME/.config/zsh-syntax-color-vars.zsh"
fi

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
# [ -x /usr/bin/lesspipe ] && emulate sh -c 'lesspipe'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color | alacritty) color_prompt=yes ;;
esac

configure_prompt() {
    prompt_symbol='[ 󰨡   ]:( " )'
    # Skull emoji for root terminal
    [ "$EUID" -eq 0 ] && prompt_symbol=💀
    case "$PROMPT_ALTERNATIVE" in
    twoline)
        PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$prompt_symbol$'%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
        # Right-side prompt with exit codes and background processes
        RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'
        ;;
    oneline)
        PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{%(#.red.blue)}%n@%m%b%F{reset}:%B%F{%(#.blue.green)}%~%b%F{reset}%(#.#.$) '
        RPROMPT=
        ;;
    backtrack)
        PROMPT=$'${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%B%F{red}%n@%m%b%F{reset}:%B%F{blue}%~%b%F{reset}%(#.#.$) '
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

    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then

        source "$HOME/.config/zsh-syntax-color-vars.zsh"
    fi
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

# some more ls aliases
if command -v zoxide >/dev/null 2>&1; then

    eval "$(zoxide init zsh --hook prompt --cmd zd)"
fi

if command -v exa >/dev/null 2>&1; then
    alias ls='exa -a --color-scale --icons'
    alias ld='exa -al --links --color-scale --icons'
    alias ll='exa -al --links --color-scale --icons'
    alias lt='exa -lT --color-scale --icons'
    # alias l='exa -l --color-scale --icons'
else
    alias ls='ls --color=auto'
    alias ll='ls -l'
    alias la='ls -A'
    alias l='ls -CF'
fi

if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi


[[ $(tty) = "/dev/pts/0" ]] && neofetch

# enable command-not-found if installed
if [ -f /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
fi
