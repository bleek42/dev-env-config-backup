#!/usr/bin/env bash

# alias -g ...='../..'
# alias -g ....='../../..'
# alias -g .....='../../../..'
# alias -g ......='../../../../..'
# # alias -g ..='cd -'
# alias -g 1='cd -1'
# alias -g 2='cd -2'
# alias -g 3='cd -3'
# alias -g 4='cd -4'
# alias -g 5='cd -5'
# alias -g 6='cd -6'
# alias -g 7='cd -7'
# alias -g 8='cd -8'
# alias -g 9='cd -9'
# alias -g mkd='mkdir -p'
# alias -g rmd='rmdir'

if command -v zoxide >/dev/null 2>&1 ; then
    eval "$(zoxide init bash --hook prompt --cmd zd)"
fi

alias -g dir='dir --color=auto'
alias -g vdir='vdir --color=auto'

alias -g grep='grep --color=auto'
alias -g fgrep='fgrep --color=auto'
alias -g egrep='egrep --color=auto'
alias -g diff='diff --color=auto'
alias -g wget='wget --no-check-certificate'
alias -g dmesgf='dmesg --ctime --follow'

alias -g rsyncp='rsync -avz --progress -h'
alias -g rsyncmv='rsync -avz --progress -h --remove-source-files'
alias -g rsyncupd='rsync -avzu --progress -h'
alias -g rsynchrnze='rsync -avzu --delete --progress -h'

alias -g tarz='tar --create --gzip --verbose --file'
alias -g taruz='tar --extract --gunzip --verbose --file'

alias -g ping='ping -c 5'
alias -g clearttyd='clear; echo Currently logged in on $TTY, as $USERNAME in directory $PWD.'
# shellcheck disable=SC2154
alias -g prntpath='print -l $PATH'
alias -g mkdirp='mkdir -pv'
# get top process eating memory
alias -g psmem='ps -e -orss=,args= | sort -b -k1 -nr'
alias -g psmem10='ps -e -orss=,args= | sort -b -k1 -nr | head -n 10'
# get top process eating cpu if not work try execute : export LC_ALL='C'
alias -g pscpu='ps -e -o pcpu,cpu,nice,state,cputime,args | sort -k1,1n -nr'
alias -g pscpu10='ps -e -o pcpu,cpu,nice,state,cputime,args | sort -k1,1n -nr | head -n 10'

alias -g hist='history -50'

# top10 of the history
alias -g hist10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

if command -v ip >/dev/null 2>&1; then
    alias -g iproute='ip route'
    alias -g ipaddr='ip route'
    alias -g iplink='ip link'

else
    alias -g ipconf='ifconfig'

fi

if command -v notify-send >/dev/null 2>&1; then
    alias -g alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

fi

if command -v fdfind >/dev/null 2>&1; then
    alias -g fdh='fdfind --hidden'
    alias -g fdh='fdfind --hidden'
fi

if command -v ag >/dev/null 2>&1; then
    alias -g ags='ag --hidden --smart-case -i -g'
    alias -g agh='ag --hidden --ignore ".git" -i -g'
fi

if command -v rg >/dev/null 2>&1; then
    alias -g rgh='rg -i --pretty --hidden --no-ignore-vcs'
    alias -g rgf='rg -i --pretty --hidden --files'
fi

if command -v cmatrix >/dev/null 2>&1; then
    alias -g redmatrix='cmatrix -C magenta -s -a -b -u 2'
    alias -g bluematrix='cmatrix -C blue -s -a -b -u 2'
    alias -g cyanmatrix='cmatrix -C cyan -s -a -b -u 2'
    alias -g magentamatrix='cmatrix -C cyan -s -a -b -u 2'

fi

# if command -v eza >/dev/null 2>&1; then
#     # alias -g ls='eza $eza_params'
#     # alias -g l='eza --git-ignore $eza_params'
#     # alias -g ll='eza --all --header --long $eza_params'
#     # alias -g llm='eza --all --header --long --sort=modified $eza_params'
#     # alias -g la='eza -lbhHigUmuSa'
#     # alias -g lx='eza -lbhHigUmuSa@'
#     # alias -g lt='eza --tree $eza_params'
#     # alias -g tree='eza --tree $eza_params'

#     # declare -a eza_params=(
#     #     '--icons=always' '--color=always' '--colour-scale=all' '--colour-scale-mode=gradient'
#     #     '--smart-group' '--group-directories-first' '--git-ignore' '-I="*.git"'
#     # )

#     alias -g ls='eza --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -G'
#     alias -g la='eza --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -aa -1'
#     # alias -g la='eza --smart-group --group-directories-first --reverse --git-ignore --icons --color-scale=all'
#     alias -g ll='eza -a --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -l -F -G -@ -s=changed'
#     alias -g ld='eza -a --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -l -D -h -H -F -M -@'
#     alias -g lf='eza -a --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -f -h -H  -@'
#     alias -g lt='eza -a --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -T -L 4'
#     alias -g lg='eza -a --icons=always --color=always --colour-scale=all --colour-scale-mode=gradient --smart-group --group-directories-first --git-ignore -l -F -G -@ .*'

# if [[  ! -x $(command -v eza) || ! -x $(command -v exa) ]]; then

#     # echo "command \"command\" exists on system"
#     alias ls='ls --color=always -F'
#     alias ll='ls -l'
#     alias la='ls -a'
#     alias ld='ls -Da'
#     alias lf='ls -CX'

# fi

if command -v neovide >/dev/null 2>&1; then

    if test -n "$WSL_INTEROP"; then
        alias -g neovide='neovide --wsl --log'
    else
        alias -g neovide='neovide --log'
    fi
fi

if command -v docker >/dev/null 2>&1; then

    alias dbl='docker build'
    alias dcin='docker container inspect'
    alias dcls='docker container ls'
    alias dclsa='docker container ls -a'
    alias dib='docker image build'
    alias dii='docker image inspect'
    alias dils='docker image ls'
    alias dipu='docker image push'
    alias dirm='docker image rm'
    alias dit='docker image tag'
    alias dlo='docker container logs'
    alias dnc='docker network create'
    alias dncn='docker network connect'
    alias dndcn='docker network disconnect'
    alias dni='docker network inspect'
    alias dnls='docker network ls'
    alias dnrm='docker network rm'
    alias dpo='docker container port'
    alias dps='docker ps'
    alias dpsa='docker ps -a'
    alias dpu='docker pull'
    alias dr='docker container run'
    alias drit='docker container run -it'
    alias drm='docker container rm'
    alias drmf='docker container rm -f'
    alias dst='docker container start'
    alias drs='docker container restart'
    alias dsta='docker stop $(docker ps -q)'
    alias dstp='docker container stop'
    alias dtop='docker top'
    alias dvi='docker volume inspect'
    alias dvls='docker volume ls'
    alias dvprune='docker volume prune'
    alias dxc='docker container exec'
    alias dxcit='docker container exec -it'

    # ! support Compose v2 as docker CLI plugin
    (( ${+commands[docker-compose]} )) && dccmd='docker-compose' || dccmd='docker compose'

    alias dco="$dccmd"
    alias dcb="$dccmd build"
    alias dce="$dccmd exec"
    alias dcps="$dccmd ps"
    alias dcrestart="$dccmd restart"
    alias dcrm="$dccmd rm"
    alias dcr="$dccmd run"
    alias dcstop="$dccmd stop"
    alias dcup="$dccmd up"
    alias dcupb="$dccmd up --build"
    alias dcupd="$dccmd up -d"
    alias dcupdb="$dccmd up -d --build"
    alias dcdn="$dccmd down"
    alias dcl="$dccmd logs"
    alias dclf="$dccmd logs -f"
    alias dclF="$dccmd logs -f --tail 0"
    alias dcpull="$dccmd pull"
    alias dcstart="$dccmd start"
    alias dck="$dccmd kill"

    unset dccmd

fi
