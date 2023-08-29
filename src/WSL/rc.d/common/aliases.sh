#!/usr/bin/env bash

# some more ls aliases
if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init zsh --hook prompt --cmd zd)"
fi

if command -v fdfind >/dev/null 2>&1; then
	alias fd='fdfind --hidden --no-ignore --exclude ".git" --follow --color always'
	alias fdh='fdfind --hidden --follow --color always'
fi

if command -v batcat >/dev/null 2>&1; then
	alias bat='batcat --color always'
fi

if command -v ag >/dev/null 2>&1; then
	alias ag='--hidden --ignore ".git" -i -g'
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
alias ags='ag --smart-case --hidden --glob "!.git"'

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias wget='wget --no-check-certificate'
alias dmesgf='dmesg --ctime --follow'

alias pack='tar --create --gzip --verbose --file'
alias unpack='tar --extract --gunzip --verbose --file'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

function set-treex() {
	if command -v exa >/dev/null 2>&1; then
		exa --all --long --group --git --links --time-style=long-iso --header --group-directories-first --color-scale --icons --tree --ignore-glob ".git" --color=always "$@" | batcat --plain -n || cat
	else
		tree -aC -I '.git' --dirsfirst "$@" | batcat --plain || cat
	fi
}

alias treex='set-treex'
