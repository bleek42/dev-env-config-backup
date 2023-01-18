#!/bin/bash

env=~/.ssh/agent.env

agent_load_env() { test -f "$env" && . "$env" >|/dev/null; }

agent_start() {
    (
        umask 077
        ssh-agent >|"$env"
    )
    . "$env" >|/dev/null
}

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(
    ssh-add -l >|/dev/null 2>&1
    echo $?
)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

case $- in
*i*)
    # ? special tty (or teletypewriter) characteristics: setting to single combination for "sane" defaults
    stty sane
    ;;
*) return ;;
esac

# # Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

shopt -s globstar
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# make cd ignore case and small typos
shopt -s cdspell

shopt -s completion_strip_exe
# ═══════════════════════════════════════
# HISTORY MANAGEMENT
# ═══════════════════════════════════════
shopt -s cmdhist
# append to the history file, don't overwrite it
shopt -s histappend
# set length of command history rememebered
# make sure this isn't overrided by the OS (Ubuntu does this)
unset HISTFILESIZE
unset HISTSIZE
HISTSIZE=2000
HISTFILESIZE=4000
# Don't store lines starting with a space in the history, or lines identical to the one before.
HISTCONTROL='ignorespace:ignoredups'
# Store timestamps in history file, and display them as 'Mon 2020-06-01 23:42:05'.
HISTTIMEFORMAT='%a %Y-%m-%d %H:%M:%S'

# If this shell is connected to a tty, disable software flow control.
# In other words, prevent accidentally hitting ^S from freezing the entire terminal.
[ -t 0 ] && stty -ixon 2>/dev/null

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/bash lesspipe)"

# export NODE_PATH="$NODE_PATH"
# export NODE_PATH="$SCOOP"/persist/nvm/nodejs/v16.17.0
# "$NODE_PATH"
# export NODE_EXE="$NODE_PATH"/node.exe
if [[ -n "$NVM_SYMLINK" ]]; then
    export NODE_PRESERVE_SYMLINKS=1
fi

config_dir="$HOME"/.config

if [ -d "$config_dir/bash" ]; then
    for src in "$config_dir"/bash/*.sh; do
        source "$src"
    done
fi
