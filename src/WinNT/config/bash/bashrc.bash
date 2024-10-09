#!/usr/bin/env bash

# [[ $- == *i* ]] || return

## * Enable case-insensitive globbing and other globbing options

shopt -s nocaseglob extglob globstar nullglob

## * Check the window size after each command

shopt -s checkwinsize

## * Remove ".exe" ending for tab completions

shopt -s completion_strip_exe

## * Check if all background jobs are finished before closing the shell

shopt -s checkjobs

## * Fix spelling when trying to tab complete directories

shopt -s dirspell

## * Enable programmable completions

shopt -s progcomp

## * Save long commands as a single history entry

shopt -s cmdhist

## * Set the control options for the history, ignoring duplicates and erasing duplicates
## * Append to the history file instead of overwriting it

shopt -s histappend
shopt -s histreedit
shopt -s histverify

export PROMPT_COMMAND='history -a'
export HISTCONTROL="ignoreboth"
export HISTIGNORE="clear:history:[bf]g:exit:date:* --help"
export HISTTIMEFORMAT='%a %Y-%m-%d %H:%M:%S'

## * Set the size of command history to be remembered
export HISTSIZE=3000
export HISTFILESIZE=6000
export SAVEHIST=8000

## ? check if user home "~/" doesn't have dir called ".config", make it if so
## ? * env vars are a universal specification for Unix/Linux operating systems: Windows usually has own sort of spec to do this with $APPDATA, $LOCALAPPDATA, used for setting things like users for standard inital user folders like
## ? "MyDocuments" & other user specific start up stuff. We can imitate $XDG_CONFIG_HOME here because why not? Often, ~/.config/ may already have been created for you via some other software you have.
test -d "${HOME}/.config" || mkdir -p "${HOME}/.config"

export DISPLAY=:0
export COLORTERM='truecolor'
export LESS='-R -F -i -J -M -W -x4 -X -z-4'
export PAGER='/usr/bin/less'
export XDG_CONFIG_HOME="${HOME}/.config"
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[5m'        # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export EDITOR="${PROGRAMFILES}/Neovim/bin/nvim"
export VISUAL="${PROGRAMFILES}/Microsoft VS Code/bin/code"
export BROWSER="${PROGRAMFILES}/Firefox Developer Edition/firefox"
# export NODE_PRESERVE_SYMLINKS=1
# export NODE_PATH='/c/ProgramData/scoop/apps/nodejs-np/current/node_modules:/c/Users/brand/AppData/Roaming/Roaming/npm/node_modules'

extract() {
    # Usage: extract file "opening marker" "closing marker"
    while IFS=$'\n' read -r line; do
        [[ $extract && $line != "$3" ]] &&
            printf '%s\n' "$line"

        [[ $line == "$2" ]] && extract=1
        [[ $line == "$3" ]] && extract=
    done <"$1"
}

## * Set the format for displaying timestamps in the history

## * Disable software flow control if connected to a terminal emulator
test -t 0 && stty -ixon 2>/dev/null

## * Check if a directory for user completions exists and add it to the completion path
if test -d "${XDG_CONFIG_HOME}"/bash/completions; then
    USER_COMPLETIONS="${XDG_CONFIG_HOME}"/bash/completions
    ## * COMPLETION_PATH="${COMPLETION_PATH:+$USER_COMPLETIONS}"

    ## * Source all shell scripts in the user completions directory
    for cmp in "${USER_COMPLETIONS}"/**/*.sh; do
        # shellcheck disable=SC1090
        source "$cmp"
    done
    unset cmp
fi

## * Source additional scripts for aliases and fzf configuration
test -f "${XDG_CONFIG_HOME}"/bash/aliases/aliases.sh && source "${XDG_CONFIG_HOME}"/bash/aliases/aliases.sh
test -f "${XDG_CONFIG_HOME}"/bash/fzf-config.sh && source "${XDG_CONFIG_HOME}"/bash/fzf-config.sh

## * Ctrl+Right / Ctrl+Left to move by whole words

bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'

## * Ctrl+Delete / Ctrl+Backarrow to delete whole words

bind '"\e[3;5~": kill-word'
bind '"\C-_": backward-kill-word' # ? with mintty setting KeyFunctions=C+Back:"^_"

## * Ctrl+Shift+Delete to delete to end of the line

bind '"\e[3;6~": kill-line'

## * Ctrl+Shift+Backarrow to delete to start of the line

bind '"\e[72;6~": backward-kill-line' # ? with mintty setting KeyFunctions=CS+Back:72

## * Alt-Backarrow for undo

bind '"\e\d": undo' # ? would be disabled by DECSET 67 sequence

## * Set keybindings for menu completion and history search

bind '"\C-":menu-complete'
bind '"\e[1;5A": history-search-backward'
bind '"\e[1;5B": history-search-forward'
