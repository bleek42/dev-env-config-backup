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
alias fd='fdfind --hidden -exclude ".git" --follow --color always'
alias fdd='fdfind --hidden -exclude ".git" --follow --color always'
alias ag='ag --smart-case --hidden --glob "!.git"'
alias bat='batcat --color=always --style="numbers,grid"'
alias pack='tar --create --gzip --verbose --file'
alias unpack='tar --extract --gunzip --verbose --file'

set-treex-alias() {
    if command -v exa >/dev/null 2>&1; then
        exa --all --long --group --git --links --time-style=long-iso --header --group-directories-first --color-scale --icons --tree --ignore-glob ".git" --color=always "$@" | batcat --plain || cat
    else
        tree -aC -I '.git' --dirsfirst "$@" | batcat --plain || cat
    fi
}

alias treex='set-treex-alias'
