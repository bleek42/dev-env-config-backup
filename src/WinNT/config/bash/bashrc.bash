#!/usr/bin/env bash

[[ $- == *i* ]] || return

# Ctrl+Right / Ctrl+Left to move by whole words
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'

# Ctrl+Delete / Ctrl+Backarrow to delete whole words
bind '"\e[3;5~": kill-word'
bind '"\C-_": backward-kill-word' # with mintty setting KeyFunctions=C+Back:"^_"

# Ctrl+Shift+Delete to delete to end of the line
bind '"\e[3;6~": kill-line'

# Ctrl+Shift+Backarrow to delete to start of the line
bind '"\e[72;6~": backward-kill-line' # with mintty setting KeyFunctions=CS+Back:72

# Alt-Backarrow for undo
bind '"\e\d": undo' # would be disabled by DECSET 67 sequence

# Set keybindings for menu completion and history search
bind '"\C-":menu-complete'
bind '"\e[1;5A": history-search-backward'
bind '"\e[1;5B": history-search-forward'

# Enable case-insensitive globbing and other globbing options
shopt -s nocaseglob extglob globstar nullglob

# Check the window size after each command
shopt -s checkwinsize

# Remove ".exe" ending for tab completions
shopt -s completion_strip_exe

# Check if all background jobs are finished before closing the shell
shopt -s checkjobs

# Fix spelling when trying to tab complete directories
shopt -s dirspell

# Enable programmable completions
shopt -s progcomp

# Save long commands as a single history entry
shopt -s cmdhist

# Set the control options for the history, ignoring duplicates and erasing duplicates
# Append to the history file instead of overwriting it
shopt -s histappend

HISTCONTROL=ignoreboth:erasedups
# Set the size of command history to be remembered
HISTSIZE=8000
HISTFILESIZE=8000
SAVEHIST=8000

# Set the format for displaying timestamps in the history
HISTTIMEFORMAT='%a %Y-%m-%d %H:%M:%S'

# Disable software flow control if connected to a terminal emulator
test -t 0 && stty -ixon 2>/dev/null

# Check if a directory for user completions exists and add it to the completion path
if test -d "${XDG_CONFIG_HOME}"/bash/completions; then
    USER_COMPLETIONS="${XDG_CONFIG_HOME}"/bash/completions
    COMPLETION_PATH="${COMPLETION_PATH}:${USER_COMPLETIONS}"

    # Source all shell scripts in the user completions directory
    for cmp in "${USER_COMPLETIONS}"/**/*.sh; do
        # shellcheck disable=SC1090
        source "$cmp"
    done
    unset cmp
fi

# Source additional scripts for aliases and fzf configuration
test -f "${XDG_CONFIG_HOME}"/bash/aliases/aliases.sh && source "${XDG_CONFIG_HOME}"/bash/aliases/aliases.sh
test -f "${XDG_CONFIG_HOME}"/bash/fzf-config.sh && source "${XDG_CONFIG_HOME}"/bash/fzf-config.sh
