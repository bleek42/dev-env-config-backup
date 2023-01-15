#!/usr/bin/env bash
## MACOS PPL: change above bash to zsh !!!!

# cd into usr home, sys root dir
alias gohome='cd ~'
alias goroot='cd /'

# ═══════════════════════════════════════
# FILE MANAGEMENT ALIASES
# ═══════════════════════════════════════
# don't clobber files & destroy the OS with intetactive flag added by default now
alias cp='cp -i'
alias mv='mv -i'
alias rm="rm -I --preserve-root"
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Show full paths of files in current directory
alias paths='ls -d $PWD/*'

### Make ls suck less!
# --show-control-chars: help showing Korean or accented characters
alias ls='ls -F --color=$"DIRCOLORS" --show-control-chars'

# shows permissions on files/folders (read,write,xecute) use chown/chmod to chage permission deny errs or add sudo to front of any commnad in MacOS/Linux, install gsudo with winget pkg mgr
alias ll='ls -l'

# Show hidden files, .dotfiles like .git/ in repos or in home folder like .ssh/
alias la='ls -a'

# Show file size, permissions, date, etc.
alias ll='ls -lvhs'
alias lll='ls -alvhs'

# Show only directories
alias l.='ls -d */'

# sort files by size, showing biggest at the bottom
alias lsort="ls -alSr | tr -s ' ' | cut -d ' ' -f 5,9"

# typo corrections
alias l='ls'
alias s='ls'
alias sl='ls'

# make directory and any parent directories needed like mkdir bootcamp/challenge-14/original-reponame-for-dem-ezpoints
alias mkdir='mkdir -p'

# easier directory jumping: just use ... to go back 3 folders
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# typo fix
alias cd..='cd ..'

alias gitadd='git add .' # for yous that forget about that space bar, add all changes in repo
alias gitpush='git push' # add origin + branch/you-are-on NOT main

alias gitpullmain='git pull origin main' # now you can just type that and make sure you all pull content team m8s merge to main so u all on the same page within own branch

