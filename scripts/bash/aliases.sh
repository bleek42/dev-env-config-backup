#!/usr/bin/env bash

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias wget='wget --no-check-certificate'
alias dmesgf='dmesg --ctime --follow'
alias rsynccp="rsync -avz --progress -h"
alias rsyncmv="rsync -avz --progress -h --remove-source-files"
alias rsyncupd="rsync -avzu --progress -h"
alias rsyncnize="rsync -avzu --delete --progress -h"

alias pack='tar --create --gzip --verbose --file'
alias unpack='tar --extract --gunzip --verbose --file'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init zsh --hook prompt --cmd zd)"
fi

if command -v fdfind >/dev/null 2>&1; then
	alias fd='fdfind --hidden --no-ignore --exclude ".git" --follow --color always'
	alias fdh='fdfind --hidden --follow --color always'
fi

if command -v batcat >/dev/null 2>&1; then
	alias bat='batcat --plain --color=always'
fi

if command -v ag >/dev/null 2>&1; then
	alias ag='ag --hidden --ignore ".git" -i -g'
	alias ags='ag --hidden --smart-case -g'
fi

if command -v rg >/dev/null 2>&1; then
	alias rg='rg -i --pretty --hidden --no-ignore-vcs'
fi

if command -v exa >/dev/null 2>&1; then
	alias ls='exa -a --color-scale --icons'
	alias la='exa -al --color-scale --icons'
	alias lt='exa -lT --color-scale --icons'
	alias ld='exa -al --links --color-scale --icons'
	alias ll='exa -al --links --color-scale --icons'
else
	alias ls='ls --color=auto'
	alias ll='ls -l'
	alias la='ls -A'
	alias l='ls -CF'
fi
