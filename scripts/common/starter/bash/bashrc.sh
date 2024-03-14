#!/usr/bin/env bash

## ! bashrc is loaded/sourced everytime you start an interactive bash session in the terminal by default
## ! add this code at the top if you already have an existing ~/.bashrc file in your users home directory

# ? load any ssh keys that are in $HOME/.ssh so we dont need to enter in our passphrase everytime
agent_load_env() {
  test -f "$env" && source "$env" >|/dev/null
}

agent_start() {
  (umask 077 ssh-agent >|"$env") && source "$env" >|/dev/null
}

agent_load_env

# ? agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(
  ssh-add -l >|/dev/null 2>&1
  echo $?
)

if [ ! "$SSH_AUTH_SOCK" ] || [ "$agent_run_state" = 2 ]; then
  agent_start
  ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ "$agent_run_state" = 1 ]; then
  ssh-add
else
  echo "ssh failed in ~/.profile ..."
fi

unset env

# ? case/switch bash statement that checks if is interactive shell, returns & stops loading script if it is not
# ? special tty (or teletypewriter) characteristics: setting to single combination for more "sane" terminal defaults
case $- in
*i*)
  stty sane
  ;;
*) return ;;
esac

# * ═══════════════════════════════════════
# * BASH OPTIONS
# * ═══════════════════════════════════════
# ? set bash options, change the way input/output works in your terminal using bash shell
shopt -s autocd  # ? cd into directories by just typing the name of the directory
shopt -s cdspell #  ?correct minor spelling errors when using cd
# ? Case-insensitive globbing used in pathname expansion (example: 'cp -r ~/Documents/*.txt ~/OneDrive/Documents/text-files will copy all .txt files in the ~/Documents/ folder to the OneDrive/Documents/text-files folder)
shopt -s nocaseglob
# ? removes .exe ending when using tab completions for any commands (example: type 'no' then press tab, normally on windows it would complete to 'node.exe' now it will just be 'node')
shopt -s completion_strip_exe
# ? check if all background jobs in current shell are finished before allowing to close the shell on first close attempt
shopt -s checkjobs
# ? fix spelling when trying to tab complet dirs
shopt -s dirspell
# # ? enable programmable completions
shopt -s progcomp
# # ? save long commands to one history entry
shopt -s cmdhist
# ? check the window size after each command and, if necessary,
# ? update the values of LINES and COLUMNS.
shopt -s checkwinsize

# * ═══════════════════════════════════════
# * HISTORY MANAGEMENT
# * ═══════════════════════════════════════
# ? append to the history file, don't overwrite it
shopt -s histappend
# ? set length of command history rememebered
unset HISTFILESIZE
unset HISTSIZE
HISTSIZE=5000
HISTFILESIZE=5000
HISTCONTROL='ignorboth'
# ? Store timestamps in history file, and display them as 'Mon 2020-06-01 23:42:05'.
HISTTIMEFORMAT='%a %Y-%m-%d %H:%M:%S'

# # ! If this interactive Bash shell session is connected to a terminal emulator (or a TTY "tele-typewriter"), disable software flow control feature, which is enabled by default
# # ! In plain english: prevent hitting CTRL+S in order to save a file from accidentally freezing up your terminal/shell session.
[ -t 0 ] && stty -ixon 2>/dev/null

# ? cd into usr home, sys root dir
alias gohome='cd ~'
alias goroot='cd /'

# * ═══════════════════════════════════════
# * FILE MANAGEMENT ALIASES
# * ═══════════════════════════════════════
# ! don't clobber files & destroy the OS with intetactive flag added by default now
alias cp='cp -i'                 # ? copy files/folders interactively, ask before overwriting
alias mv='mv -i'                 # ? move files/folders interactively, ask before overwriting
alias rm="rm -I --preserve-root" # ? remove files/folders interactively, ask before overwriting, preserve root dir so you can't delete your whole OS!!! :P

# ! use chown/chmod/chgrp to change permission deny errs or add sudo to front of any commnad in MacOS/Linux, install gsudo with winget pkg mgr
alias chown='chown -c --preserve-root' # ? change ownership of files/folders, preserve root user permissions, -c flag shows verbose output of what changed
alias chmod='chmod -c --preserve-root' # ? change permissions of files/folders, preserve root user permissions, -c flag shows verbose output of what changed
alias chgrp='chgrp -c --preserve-root' # ? change group of files/folders, preserve root user permissions, -c flag shows verbose output of what changed

# ? Show full paths of files in current directory
alias paths='ls -d $PWD/*'

### ! Make ls better
alias ls='ls -F --color=$"DIRCOLORS" --show-control-chars' # ? --show-control-chars: help showing Korean or accented characters
alias ll='ls -l'                                           # ? shows permissions on files/folders (read,write,execute: 'r,w,x')
alias la='ls -a'                                           # ? Show hidden files, or '.dotfiles/folders' like '.git/' that git init creates to denote a folder is a repo being tracked, or in home folder like '.ssh/', not to mention this very file '~/.bashrc''
# ? Show file size, permissions, date, etc.
alias lls='ls -lvhs'
alias lsa='ls -alvhs'
alias lsd='ls -d */'                                   # ? Show only directories
alias lsort="ls -alSr | tr -s ' ' | cut -d ' ' -f 5,9" # ? sort files by size, showing biggest at the bottom
alias mkdir='mkdir -p'                                 # ? make directory and any parent directories needed like mkdir bootcamp/challenge-14/<original-reponame-for-dem-ez-homework-pointz>

# ? easier directory jumping: just use ... to go back 3 folders
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias cd..='cd ..' # ? typo fix

alias gitadd='git add .'        # ? for yous that forget about that space bar, add all changes in repo, '.' is a wildcard in place of -A that means "all files/folders in current directory"
alias gitcommit='git commit -m' # ? add commit message after -m flag use pair of opening/closing quotes with your commit message between them when using this command alias
alias gitpush='git push'        # ? add origin + branch/you-are-on (ex: 'origin main', 'origin feature/feature-name', 'origin branch-name-you-made-up')
