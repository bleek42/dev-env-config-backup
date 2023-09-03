#!/usr/bin/env bash

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
# ? set a variable using your users default $HOME environment variable to a hidden "dotfolder" .config/ folder with this syntax
HISTSIZE=5000
HISTFILESIZE=5000

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# Don't store lines starting with a space in the history, or lines identical to the one before.
HISTCONTROL='ignoreboth'
# Store timestamps in history file, and display them as 'Mon 2020-06-01 23:42:05'.
HISTTIMEFORMAT='%a %Y-%m-%d %H:%M:%S'

# # If this interactive Bash shell session is connected to a terminal emulator (or a TTY "tele-typewriter"), disable software flow control.
# # In other words, prevent accidentally hitting CTRL+S from freezing the terminal session.
[ -t 0 ] && stty -ixon 2>/dev/null

if [[ -d "$CONFIG_DIR/bash/completions" ]]; then
  for src in "${CONFIG_DIR}"/bash/completions/**/*.sh; do
    source "$src"
  done
  unset src
fi

[[ -d "$CONFIG_DIR/bash/aliases/aliases.sh" ]] && source "$CONFIG_DIR/bash/aliases/aliases.sh"


# if command -v direnv >/dev/null 2>&1; then
#   eval "$(
#     direnv hook bash
#     direnv allow
#   )"
# fi
