#!/usr/bin/env bash

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias -- -='cd -'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias mkd='mkdir -p'
alias rmd='rmdir'

if [[ -x $(command -v zoxide) ]]; then
    eval "$(zoxide init bash --hook prompt --cmd zd)"
fi

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
alias clearttyd='clear; echo Currently logged in on $TTY, as $USERNAME in directory $PWD.'
# shellcheck disable=SC2154
alias printpath='print -l $PATH'
alias mkdir='mkdir -pv'
# get top process eating memory
alias psmem='ps -e -orss=,args= | sort -b -k1 -nr'
alias psmem10='ps -e -orss=,args= | sort -b -k1 -nr | head -n 10'
# get top process eating cpu if not work try execute : export LC_ALL='C'
alias pscpu='ps -e -o pcpu,cpu,nice,state,cputime,args | sort -k1,1n -nr'
alias pscpu10='ps -e -o pcpu,cpu,nice,state,cputime,args | sort -k1,1n -nr | head -n 10'

alias history='history 40'

# top10 of the history
alias hist10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

if command -v ip >/dev/null 2>&1; then
    alias iproute='ip route'
    alias ipaddr='ip route'
    alias iplink='ip link'

else
    alias ipconf='ifconfig'

fi

if command -v notify-send >/dev/null 2>&1; then
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

if [ -x "$(command -v fd)" ]; then
    alias fdh='fdfind --hidden'
elif [ -x "$(command -v fdfind)" ]; then
    alias fdh='fd --hidden'
fi

if command -v ag >/dev/null 2>&1; then
    alias agh='ag --hidden --ignore ".git" -i -g'
    alias ags='ag --hidden --smart-case -i -g'
fi

if command -v rg >/dev/null 2>&1; then
    alias rgh='rg -i --pretty --hidden --no-ignore-vcs'
    alias rgf='rg -i --pretty --hidden --files'
fi

if command -v cmatrix >/dev/null 2>&1; then
    alias cyanmatrix='cmatrix -C cyan -s -a -b -u 2'
fi

if command -v eza >/dev/null 2>&1; then
    # alias ls='eza $eza_params'
    # alias l='eza --git-ignore $eza_params'
    # alias ll='eza --all --header --long $eza_params'
    # alias llm='eza --all --header --long --sort=modified $eza_params'
    # alias la='eza -lbhHigUmuSa'
    # alias lx='eza -lbhHigUmuSa@'
    # alias lt='eza --tree $eza_params'
    # alias tree='eza --tree $eza_params'

    # declare -a eza_params=(
    #     '--icons=always' '--color=always' '--colour-scale=all' '--colour-scale-mode=gradient'
    #     '--smart-group' '--group-directories-first' '--git-ignore' '-I="*.git"'
    # )

    alias ls='eza --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -G'
    alias la='eza --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -aa -1'
    # alias la='eza --smart-group --group-directories-first --reverse --git-ignore --icons --color-scale=all'
    alias ll='eza -a --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -l -F -G -@ -s=changed'
    alias ld='eza -a --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -l -D -h -H -F -M -@'
    alias lf='eza -a --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -f -h -H  -@'
    alias lt='eza -a --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -T -L 4'
    alias lg='eza -a --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -l -F -G -@ .*'

elif command -v exa >/dev/null 2>&1; then
    alias -g ls='exa --color-scale --icons'
    alias -g la='exa -al --color-scale --icons'
    alias -g ll='exa -al --color-scale --icons'
    alias -g lt='exa -lT --color-scale --icons'
    alias -g ld='exa -al --color-scale --icons'
else

    alias -g ls='ls --color=always -F'
    alias -g ll='ls -l'
    alias -g la='ls -a'
    alias -g ld='ls -Da'
    alias -g lf='ls -CX'

fi

if command -v neovide >/dev/null 2>&1; then

    if test -n "$WSL_INTEROP"; then
        alias neovide='neovide --wsl --log'
    else
        alias neovide='neovide --log'
    fi
fi
