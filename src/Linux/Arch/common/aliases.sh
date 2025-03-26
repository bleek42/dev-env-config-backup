#!/usr/bin/env bash

###?####################
### ? Useful aliases  ##
###?####################

## ? Common use
alias -g cd..="cd .."
alias -g cd..='cd ..'
alias -g cd...='cd ../..'
alias -g cd....='cd ../../..'
alias -g cd.....='cd ../../../..'
alias -g cd......='cd ../../../../..'

alias curl="curl --user-agent 'noleak'"
alias dir="dir --color=auto"
alias vdir="vdir --color=auto"
alias grep="grep --color=auto"
alias wgetc="wget -c --user-agent 'noleak'"
alias dds="dd status=progress"
alias dfh="df -h" ## ? human-readable sizes
alias duh="du -h"
alias free="free -h"

alias -g plz='sudo'
alias -g tarnow='tar -acf '
alias -g untar='tar -zxvf '
alias -g psmem='ps auxf | sort -nr -k 4'
alias -g psmem10='ps auxf | sort -nr -k 4 | head -10'

## ? Replace some more things with better alternatives
if [[ -x $(command -v bat) ]]; then
    alias bcat='bat -f -p --style=snip --style=changes --style=header'
elif [[ -x $(command -v batcat) ]]; then
    alias -g bat='batcat -f -p --style=snip --style=changes --style=header'
fi

if [[ -x $(command -v update-grub) ]]; then
    alias -g updategrub="sudo update-grub"
fi

if [[ -x $(command -v hwinfo)  ]]; then
    alias -g hwinfos='hwinfo --short'                      ## ? Hardware Info
fi

## ? Sort installed packages according to size in MB (expac must be installed)

if [[ -x $(command -v ip) ]]; then
    alias ip='ip -color'
fi

if [[ -x $(command -v nc) ]]; then
    alias -g termbin='nc termbin.com 8999'
fi

if [[ -x $(command -v cht.sh) ]]; then
    alias -g chtsh='cht.sh --shell'
fi

## ? Replace ls with eza
if command -v eza >/dev/null 2>&1; then
    # enable_autocd=0
    declare -ga eza_default_params
    eza_default_params=(
        -F
        --git
        --icons
        --smart-group
        --hyperlink
        --group-directories-first
    )

    eza_default_params+=(
        --color=always
        --color-scale=all
        --color-scale-mode=gradient
        --time-style=relative
        --sort=extension
        # --ignore-glob="!**/.{git,svn}/*"
    )

    alias ls='eza -G -U -l -h -x --modified ${eza_default_params[@]}'

    alias -g la='eza -B -G -H -U -l -aa -h -u --modified ${eza_default_params[@]}'

    alias -g ll='eza -A -@ -G -M -R -L=2 -@ -U -l -h -x -u --total-size ${eza_default_params[@]}'
    alias -g lsdir='eza -B -D -G -H -@ -M -U -aa -l -h -r -x -u ${eza_default_params[@]}'
    alias -g lsfile='eza -A -B -G -H -U -@ -l -h -r -x -f --modified ${eza_default_params[@]}'
    alias -g lsxtd='eza -aa -l -h -i -n -x -G -H -S -U --modified --total-size ${eza_default_params[@]}'
    alias -g lsdot='eza -1 -aa -l -h ${eza_default_params[@]} --no-git --no-filesize' ## ? show only dotfiles
    alias -g lsmod='eza -1 -M -@ -aa -h -l --created --modified --accessed ${eza_default_params[@]} --no-git'
    alias -g lstree='eza --tree -A -L=4 ${eza_default_params[@]} --no-git'

#   if [[ "$enable_autocd" == "1" ]]; then
#     ## *  Function for cd auto list directories
#     →auto-eza() {
#         command eza "${eza_default_params}[@]"
#       }
#     [[ $chpwd_functions[(r)→auto-eza] == →auto-eza ]] || \
#         chpwd_functions=( →auto-eza $chpwd_functions )
#   fi

elif command -v lsd >/dev/null 2>&1; then
    alias ls='lsd --group-dirs first --header --long --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
    alias -g la='lsd -l -a -b -h -i -m -u -H -S -U'
    alias -g ll='lsd -A --header --long --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
    alias -g ldir='lsd -A --git --icons --smart-group -D --time-style=long-iso --color-scale=all'
    alias -g lfile='lsd -l -h -A -x -@ --only-files --created --modified --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
    alias -g lsx='lsd -lbhHigUmuSa@'
    alias -g ldot='lsd -a -l -d --color=always --group-directories-first --icons .*' ## ? show only dotfiles
    alias -g lsmod='lsd --all --header --long --sort=modified --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
    alias -g ltree='lsd --tree --all --no-git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'

elif command -v exa >/dev/null 2>&1; then
    alias ls='exa --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
    alias -g la='exa -l -a -b -h -i -m -u -H -S -U'
    alias -g ll='exa -A --header --long --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
    alias -g ldir='exa -A --git --icons --smart-group -D --time-style=long-iso --color-scale=all'
    alias -g lfile='exa -l -h -A -x -@ --only-files --created --modified --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
    alias -g lsx='exa -lbhHigUmuSa@'
    alias -g ldot='exa -a -l -d --color=always --group-directories-first --icons .*' ## ? show only dotfiles
    alias -g lsmod='exa --all --header --long --sort=modified --git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'
    alias -g ltree='exa --tree --all --no-git --icons --smart-group --group-directories-first --time-style=long-iso --color-scale=all'

else
    alias ls='command ls --color=auto --group-directories-first -F -X'
    alias -g la='command ls --color=auto --group-directories-first -F -X -A -Z -1'
    alias -g ll='command ls--color=auto --group-directories-first -F -X -C -a -l'
    alias -g ldir='command ls --color=auto --group-directories-first -F -d -A -Z */'
    alias -g lfile='command ls --color=auto -F -A -1 -Z -'
    alias -g ldor='command ls --color=auto --group-directories-first -F -X -A -1 '

fi

# VS Code (stable / insiders) / VSCodium zsh plugin
# Authors:
#   https://github.com/MarsiBarsi (original author)
#   https://github.com/babakks
#   https://github.com/SteelShot
#   https://github.com/AliSajid


if command -v codium >/dev/null 2>&1; then
    VSCODE=codium
elif command -v codium-insiders >/dev/null 2>&1; then
    VSCODE=codium-insiders
elif command -v code-insiders >/dev/null 2>&1; then
    VSCODE=code-insiders
elif command -v code-insiders >/dev/null 2>&1; then
    VSCODE=code-insiders
elif command -v code >/dev/null 2>&1; then
    VSCODE=code
else
    VSCODE=0
fi


if [ "$VSCODE" != "0" ]; then
    # export VSCODE
    function vscode_open {
        if (( $# )); then
            $VSCODE "$@"
        else
            $VSCODE .
        fi
    }

    [[ -n $WAYLAND_DISPLAY ]] && \
        VSCODE="$VSCODE --wait --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland"

    alias code='$VSCODE'
    alias -g codeadd='$VSCODE --add'
    alias -g codediff='$VSCODE --diff'
    alias -g codegoto='$VSCODE --goto'
    alias -g codenw='$VSCODE --new-window'
    alias -g coderw='$VSCODE --reuse-window'
    alias -g codewt='$VSCODE --wait'
    alias -g codeusr='$VSCODE --user-data-dir'
    alias -g codeprf='$VSCODE --profile'
    alias -g codextdir='$VSCODE --extensions-dir'
    alias -g codeinsext='$VSCODE --install-extension'
    alias -g codeuninsext='$VSCODE --uninstall-extension'
    alias -g codedisext='$VSCODE --disable-extensions'
    alias -g codevb='$VSCODE --verbose'
    alias -g codelog='$VSCODE --log'
fi

## ? Get the error messages from journalctl
if command -v journalctl >/dev/null 2>&1; then
    alias -g jctl="journalctl -p 3 -xb"
    alias -g jctlb="journalctl -p 3 -xb --no-pager"
    alias -g jctls="journalctl -p 3 -xs"
    alias -g jctld="journalctl -p 3 -xd"
    alias -g jctlf="journalctl -p 3 -xf"
    alias -g jctlg="journalctl -p 3 -xg"
    alias -g jctlh="journalctl -p 3 -xh"
    alias -g jctlk="journalctl -p 3 -xk"
    alias -g jctlm="journalctl -p 3 -xm"
    alias -g jctlo="journalctl -p 3 -xo"
    alias -g jctlr="journalctl -p 3 -xr"
    alias -g jctlu="journalctl -p 3 -xu"
    alias -g jctlz="journalctl -p 3 -xz"

fi

## ? Get fastest mirrors
if command -v reflector >/dev/null 2>&1; then

    alias -g mirrors="reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
    alias -g mirrorn="reflector -f 30 -l 30 --number 20 --verbose --save /etc/pacman.d/mirrorlist"
    alias -g mirrord="reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
    alias -g mirrora="reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

fi

if command -v rsync >/dev/null 2>&1; then

    alias -g rsync-copy="command rsync -avz --progress -h"
    alias -g rsync-move="command rsync -avz --progress -h --remove-source-files"
    alias -g rsync-update="command rsync -avzu --progress -h"
    alias -g rsync-synchronize="command rsync -avzu --delete --progress -h"

fi

if command -v nix-shell >/dev/null 2>&1; then

    alias -g nixsh='nix-shell -p'
    alias -g nixshinfo='nix-shell -p nix-info --run "nix-info -m"'

fi

if command -v nmap >/dev/null 2>&1; then
    alias -g nmap_open_ports="nmap --open"
    alias -g nmap_list_interfaces="nmap --iflist"
    alias -g nmap_slow="sudo nmap -sS -v -T1"
    alias -g nmap_fin="sudo nmap -sF -v"
    alias -g nmap_full="sudo nmap -sS -T4 -PE -PP -PS80,443 -PY -g 53 -A -p1-65535 -v"
    alias -g nmap_check_for_firewall="sudo nmap -sA -p1-65535 -v -T4"
    alias -g nmap_ping_through_firewall="nmap -PS -PA"
    alias -g nmap_fast="nmap -F -T5 --version-light --top-ports 300"
    alias -g nmap_detect_versions="sudo nmap -sV -p1-65535 -O --osscan-guess -T4 -Pn"
    alias -g nmap_check_for_vulns="nmap --script=vuln"
    alias -g nmap_full_udp="sudo nmap -sS -sU -T4 -A -v -PE -PS22,25,80 -PA21,23,80,443,3389 "
    alias -g nmap_traceroute="sudo nmap -sP -PE -PS22,25,80 -PA21,23,80,3389 -PU -PO --traceroute "
    alias -g nmap_full_with_scripts="sudo nmap -sS -sU -T4 -A -v -PE -PP -PS21,22,23,25,80,113,31339 -PA80,113,443,10042 -PO --script all "
    alias -g nmap_web_safe_osscan="sudo nmap -p 80,443 -O -v --osscan-guess --fuzzy "
    alias -g nmap_ping_scan="nmap -n -sP"
fi


if command -v pacman >/dev/null 2>&1; then
    alias pacmanrm="sudo pacman -Rdd"
    ## ? Cleanup orphaned packages
    alias -g pacmanclean='pacman -Rns $(pacman -Qtdq)'
    ## ? Recent installed packages
    alias pacmandbrm="command rm -fv /var/lib/pacman/db.lck"
    alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' ## ? List amount of -git packages
    alias manpac='man pacman'

    if command -v expac >/dev/null 2>&1; then
        alias pacrip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
        alias pacbig="expac -H M '%m\t%n' | sort -h | nl"
    fi

    if command -v paru >/dev/null 2>&1; then
        alias -g manparu='man paru'
        alias -g paruh='paru --help'
        alias -g parupd='paru -Syy'
        alias -g parus='paru -S'
        alias -g parurdd='paru -Rdd'
        alias -g parurns='paru -Rns'
    fi

    if command -v pacdiff >/dev/null 2>&1; then
        [[ -x $(command -v meld) ]] && \
            alias pacdiff='sudo -H DIFFPROG=meld pacdiff' || \
            alias pacdiff='sudo -H pacdiff'
    fi

    if command -v garuda-update >/dev/null 2>&1; then
        alias garudaupd='/usr/bin/garuda-update'
        alias garudaupda='/usr/bin/garuda-update -a'
    fi

fi

if command -v zoxide >/dev/null 2>&1; then

    if [[ -n $ZSH_VERSION ]]; then
        eval "$(zoxide init zsh --hook prompt --cmd zd)"
    else
        eval "$(zoxide init bash --hook prompt --cmd zd)"
    fi

fi

if command -v terraform >/dev/null 2>&1; then

    alias -g terraf='terraform'
    alias -g terrafa='terraform apply'
    alias -g terrafaa='terraform apply -auto-approve'
    alias -g terrafc='terraform console'
    alias -g terrafd='terraform destroy'
    alias -g terrafds='terraform destroy -auto-approve'
    alias -g terraff='terraform fmt'
    alias -g terraffr='terraform fmt -recursive'
    alias -g terrafi='terraform init'
    alias -g terrafiu='terraform init -upgrade'
    alias -g terrafo='terraform output'
    alias -g terrafp='terraform plan'
    alias -g terrafv='terraform validate'
    alias -g terrafs='terraform state'
    alias -g terraft='terraform test'
    alias -g terrafsh='terraform show'

fi

if command -v conda >/dev/null 2>&1; then

    alias -g condactv='conda activate'
    alias -g condactvb='conda activate base'
    alias -g condaconf='conda config'
    alias -g condaenvcf='conda env create -f'
    alias -g condacyn='conda create -y -n'
    alias -g condacyp='conda create -y -p'
    alias -g condacn='conda create -n'
    alias -g condaconfs='conda config --show-source'
    alias -g condadeactv='conda deactivate'
    alias -g condaenvls='conda env list'
    alias -g condainstl='conda install'
    alias -g condainstly='conda install -y'
    alias -g condals='conda list'
    alias -g condalsexp='conda list --export'
    alias -g condalstxt='conda list --explicit > spec-file.txt'
    alias -g condarm='conda remove'
    alias -g condarmy='conda remove -y'
    alias -g condarmyan='conda remove -y -all -n'
    alias -g condarmyap='conda remove -y -all -p'
    alias -g condasrch='conda search'
    alias -g condaupd='conda update'
    alias -g condaupda='conda update --all'
    alias -g condaupdc='conda update conda'

fi
