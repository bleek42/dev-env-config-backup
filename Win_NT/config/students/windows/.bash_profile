#!/usr/bin/env bash

test -f "$HOME"/.profile && source "$HOME"/.profile
test -f "$HOME"/.bashrc && source "$HOME"/.bashrc

# # Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# Don't store lines starting with a space in the history, or lines identical to the one before.
# ═══════════════════════════════════════
# HISTORY MANAGEMENT
# ═══════════════════════════════════════
# append to the history file, don't overwrite it
shopt -s histappend
# set length of command history rememebered
# make sure this isn't overrided by the OS (Ubuntu does this)
# make cd ignore case and small typos
shopt -s cdspell
unset HISTFILESIZE
unset HISTSIZE
HISTSIZE=2000
HISTFILESIZE=4000
HISTCONTROL='ignorespace:ignoredups'
# Store timestamps in history file, and display them as 'Mon 2020-06-01 23:42:05'.
HISTTIMEFORMAT='%a %Y-%m-%d %H:%M:%S'
