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
# show pressed key of the keyboard (code and name)


if command -v zoxide >/dev/null 2>&1; then
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

keypress() {
    printf "code name (ctrl+q to exit)\n"

    xev -event "keyboard" | awk -F'[ )]+' '/^KeyPress/ {a[NR+2]} NR in a {printf "% 4s %s\n", $5, $8}'
}
alias -g keyprss='keypress'

if command -v vcxsrv.exe >/dev/null 2>&1; then
    # echo "command vcxsrv.exe exists on system"
    alias -g vcxlaunch='vcxsrv.exe -lesspointer -wgl -ac -clipboard -winkill -logfile ~/.cache/vcxsrv.log -logverbose debug'
fi

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

if command -v fdfind command -v fd >/dev/null 2>&1 >/dev/null 2>&1; then
    alias -g fdh='fdfind --hidden'
    alias -g fdfile='fdfind -tf -u -s -l -H --show-errors -0'
    alias -g fddir='fdfind -td -u -s -l -H --show-errors -0'
    alias -g fdsym='fdfind -tl -u -s -l -H --show-errors -0'
    alias -g fdsock='fdfind -ts -u -s -l -H --show-errors -0'
    alias -g fdpipe='fdfind -tp -u -s -l -H --show-errors -0'
    alias -g fdexec='fdfind -tx -u -s -l -H --show-errors -0'
fi

if command -v ag >/dev/null 2>&1; then
    alias -g ags='ag --hidden --smart-case -i -g'
    alias -g agh='ag --hidden --ignore ".git" -i -g'
fi

if command -v rg >/dev/null 2>&1; then
    alias -g rgf='rg -i --pretty --hidden --files'
    alias -g rgh='rg -i --pretty --hidden --no-ignore-vcs'
fi

if command -v cmatrix >/dev/null 2>&1; then
    alias -g matrixred='cmatrix -C magenta -s -a -b -u 2'
    alias -g matrixblue='cmatrix -C blue -s -a -b -u 2'
    alias -g matrixcyan='cmatrix -C cyan -s -a -b -u 2'
    alias -g matrixmagenta='cmatrix -C cyan -s -a -b -u 2'
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

if [[  ! -x $(command -v eza) || ! -x $(command -v exa) || ! -x $(command -v lsd) ]]; then

    # echo "command \"command\" exists on system"
    alias ls='ls --color=always -F'
    alias ll='ls -l'
    alias la='ls -a'
    alias ldir='ls -Da'
    alias lfile='ls -CX'

fi

if command -v neovide >/dev/null 2>&1; then

    case "${WSL_INTEROP}" in
    */run/WSL/*)
        alias -g neovide='neovide --wsl --log'
        ;;
    *)
        alias -g neovide='neovide --log'
        ;;
    esac

fi

if command -v docker >/dev/null 2>&1; then

    alias -g dbl='docker build'
    alias -g dcin='docker container inspect'
    alias -g dcls='docker container ls'
    alias -g dclsa='docker container ls -a'
    alias -g dib='docker image build'
    alias -g dii='docker image inspect'
    alias -g dils='docker image ls'
    alias -g dipu='docker image push'
    alias -g dirm='docker image rm'
    alias -g dit='docker image tag'
    alias -g dlo='docker container logs'
    alias -g dnc='docker network create'
    alias -g dncn='docker network connect'
    alias -g dndcn='docker network disconnect'
    alias -g dni='docker network inspect'
    alias -g dnls='docker network ls'
    alias -g dnrm='docker network rm'
    alias -g dpo='docker container port'
    alias -g dps='docker ps'
    alias -g dpsa='docker ps -a'
    alias -g dpu='docker pull'
    alias -g dr='docker container run'
    alias -g drit='docker container run -it'
    alias -g drm='docker container rm'
    alias -g drmf='docker container rm -f'
    alias -g dst='docker container start'
    alias -g drs='docker container restart'
    alias -g dsta='docker stop $(docker ps -q)'
    alias -g dstp='docker container stop'
    alias -g dtop='docker top'
    alias -g dvi='docker volume inspect'
    alias -g dvls='docker volume ls'
    alias -g dvprune='docker volume prune'
    alias -g dxc='docker container exec'
    alias -g dxcit='docker container exec -it'

    # ! support Compose v2 as docker CLI plugin

    if [ -x "$(command -v docker-compose)" ]; then
        # >&2 echo "Warning: docker-compose not found, fallback to docker compose"
        dccmd='docker-compose'
    else
        dccmd='docker compose'
    fi

    alias -g dco="$dccmd"
    alias -g dcb="$dccmd build"
    alias -g dce="$dccmd exec"
    alias -g dcps="$dccmd ps"
    alias -g dcrestart="$dccmd restart"
    alias -g dcrm="$dccmd rm"
    alias -g dcr="$dccmd run"
    alias -g dcstop="$dccmd stop"
    alias -g dcup="$dccmd up"
    alias -g dcupb="$dccmd up --build"
    alias -g dcupd="$dccmd up -d"
    alias -g dcupdb="$dccmd up -d --build"
    alias -g dcdn="$dccmd down"
    alias -g dcl="$dccmd logs"
    alias -g dclf="$dccmd logs -f"
    alias -g dclF="$dccmd logs -f --tail 0"
    alias -g dcpull="$dccmd pull"
    alias -g dcstart="$dccmd start"
    alias -g dck="$dccmd kill"

    unset dccmd

fi
