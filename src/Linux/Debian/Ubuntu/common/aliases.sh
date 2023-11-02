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

alias pack='tar --create --gzip --verbose --file'
alias unpack='tar --extract --gunzip --verbose --file'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# ! exa / ls conditional aliases
if command -v exa >/dev/null 2>&1; then
    alias ls='exa -a --color-scale --icons'
    alias la='exa -al --color-scale --icons'
    alias lt='exa -lT --color-scale --icons'
    alias ld='exa -al --links --color-scale --icons'
    alias ll='exa -al --links --color-scale --icons'

    function set-treexa() {
        exa -T -a -x -R -L=3 -H -F --color=always --ignore-glob ".git" "$@" | batcat -f -p
    }

    alias treex='set-treex'

else
    alias ls='ls --color=auto'
    alias ll='ls --color=auto -l'
    alias la='ls --color=auto  -A'
    alias l='ls ---color=auto  -CF'

    set-treed() {
        tree -aC -I '.git' "$@" | batcat -f -p
    }

    alias treed='set-treed'
fi

# ! zoxide / better cd with alias zd, zdi for fuzzy dir history navigation
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --hook prompt --cmd zd)"
fi

if command -v fdfind >/dev/null 2>&1; then
    alias fd='fdfind --no-ignore --exclude ".git" --follow --color always'
    alias fdh='fdfind --hidden --no-ignore --exclude ".git" --follow --color always'
else
    alias fdh='fd --hidden --no-ignore --exclude ".git" --follow --color always'
fi

if command -v ag >/dev/null 2>&1; then
    alias ags='ag -a --hidden --depth 12 -G "!.git"'
fi

if command -v rg >/dev/null 2>&1; then
    alias rgh='rg -i --pretty --hidden --no-ignore-vcs'
fi
