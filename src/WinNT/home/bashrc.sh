#!/usr/bin/env bash

env=~/.ssh/agent.env

agent_load_env() { test -f "$env" && source "$env" >|/dev/null; }

agent_start() {
  (
    umask 077
    ssh-agent >|"$env"
  )
  source "$env" >|/dev/null
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
*i*) ;;
*) return ;;
esac

# # Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
shopt -s globstar
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize
# removes .exe ending when using tab completions for any commands (example: type 'no' then press tab, normally on windows it would complete to 'node.exe' now it will just be 'node')
shopt -s completion_strip_exe
# check if all background jobs in current shell are finished before allowing to close the shell on first close attempt
shopt -s checkjobs
# fix spelling when trying to tab complet dirs
shopt -s dirspell
# # enable programmable completions
shopt -s progcomp
# # save long commands to one history entry
shopt -s cmdhist
# append to the history file, don't overwrite it
shopt -s histappend

# ═══════════════════════════════════════
# HISTORY MANAGEMENT
# ═══════════════════════════════════════
# set length of command history rememebered
HISTSIZE=5000
HISTFILESIZE=5000

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# Don't store lines starting with a space in the history, or lines identical to the one before.
HISTCONTROL='ignoreboth'
# Store timestamps in history file, and display them as 'Mon 2020-06-01 23:42:05'.
HISTTIMEFORMAT='%a %Y-%m-%d %H:%M:%S'

# # If this shell is connected to a tty, disable software flow control.
# # In other words, prevent accidentally hitting ^S from freezing the entire terminal.
[ -t 0 ] && stty -ixon 2>/dev/null

# if command -v fnm >/dev/null 2>&1; then
#   eval "$(fnm env --use-on-cd)"
#   NODE_PATH="$(which node)"
#   export NODE_PATH
# fi

config_dir="$HOME/.config"

if [ -d "$config_dir/bash" ]; then
  for src in "$config_dir"/bash/**/*.sh; do
    test ! -f "$src" || source "$src"
  done
fi
