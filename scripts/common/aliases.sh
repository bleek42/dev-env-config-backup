#!/usr/bin/env bash

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias wget='wget --no-check-certificate'
alias dmesgf='dmesg --ctime --follow'

alias rsyncp='rsync -avz --progress -h'
alias rsyncmv='rsync -avz --progress -h --remove-source-files'
alias rsyncupd='rsync -avzu --progress -h'
alias rsynchrnize='rsync -avzu --delete --progress -h'

alias tarz='tar --create --gzip --verbose --file'
alias taruz='tar --extract --gunzip --verbose --file'

alias ping='ping -c 5'
# alias clr='clear; echo Currently logged in on $TTY, as $USERNAME in directory $PWD.'
# shellcheck disable=SC2154
alias printpath='print -l $path'
alias mkdir='mkdir -pv'
# get top process eating memory
alias psmem='ps -e -orss=,args= | sort -b -k1 -nr'
alias psmem10='ps -e -orss=,args= | sort -b -k1 -nr | head -n 10'
# get top process eating cpu if not work try execute : export LC_ALL='C'
alias pscpu='ps -e -o pcpu,cpu,nice,state,cputime,args | sort -k1,1n -nr'
alias pscpu10='ps -e -o pcpu,cpu,nice,state,cputime,args | sort -k1,1n -nr | head -n 10'

if command -v histdb >/dev/null 2>&1; then
    alias history='histdb --desc --details --limit 16'
else
    alias history='history -24'
fi

# top10 of the history
alias hist10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

if command -v ip >/dev/null 2>&1; then
    alias iproute='ip route --color=auto'
    alias ipaddr='ip route --color=auto'
    alias iplink='ip link --color=auto'

else
    alias ipconf='ifconfig --color=auto'

fi

if command -v notify-send >/dev/null 2>&1; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

if command -v fdfind >/dev/null 2>&1; then
    alias fdh='fdfind --hidden'
fi

if command -v ag >/dev/null 2>&1; then
    # alias ag='ag --hidden --ignore ".git" -i -g'
    alias ags='ag --hidden --smart-case -i -g'
fi

if command -v rg >/dev/null 2>&1; then
    alias rgh='rg -i --pretty --hidden --no-ignore-vcs'
fi

if command -v cmatrix >/dev/null 2>&1; then
    alias cyanmatrix='cmatrix -C cyan -s -a -b -u 2'
fi

# if command -v eza >/dev/null 2>&1; then
#     alias ls='eza -x -M --smart-group --group-directories-first --reverse --git-ignore --icons --color-scale'
#     alias la='eza -G -a --smart-group --group-directories-first --reverse --git-ignore --icons --color-scale'
#     alias ll='eza -l -a -F -G -@ -s=changed --smart-group --group-directories-first --git-ignore --icons --color-scale'
#     alias ld='eza -l -a -D -h -H -F -M -@ --smart-group --group-directories-first --git-ignore --icons --color-scale'
#     alias lf='eza -f -a -h -H -H -@ --smart-group --reverse --git-ignore --icons --color-scale'
#     alias lt='eza -T -a -L 4 --smart-group --reverse --git-ignore --icons --color-scale'
#     alias ldot='eza -a -l -F -s=changed -G -@ --smart-group --group-directories-first --git-ignore --icons --color-scale .*'
# elif command -v exa >/dev/null 2>&1; then
#     alias ls='exa --color-scale --icons'
#     alias la='exa -al --color-scale --icons'
#     alias ll='exa -al --color-scale --icons'
#     alias lt='exa -lT --color-scale --icons'
#     alias ld='exa -al --color-scale --icons'
# else
#     alias ls='ls --color=auto'
#     alias ll='ls -l'
#     alias la='ls -A'
#     alias l='ls -CF'
# fi

if command -v neovide >/dev/null 2>&1; then

    if test -n "$WSL_INTEROP"; then
        alias neovide='neovide --wsl --log'
    else
        alias neovide='neovide --log'
    fi
fi

if [[ ${SHELL} =~ zsh ]]; then
    autoload -Uz run-help
    (( ${+aliases[run-help]} )) && unalias run-help
    alias help='run-help'

    if command -v zoxide >/dev/null 2>&1; then
        eval "$(zoxide init bash --hook prompt --cmd zd)"
    fi

else
    eval "$(zoxide init zsh --hook prompt --cmd zd)"

fi
