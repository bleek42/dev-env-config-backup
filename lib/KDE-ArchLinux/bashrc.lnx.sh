# # If not running interactively, don't do anything
[[ $- != *i* ]] && return

# oh-my-posh prompt
if command -v oh-my-posh >/dev/null 2>&1>; then
  eval "$(oh-my-posh init bash --config ~/.poshthemes/bleek-slim.omp.json)"
fi

# blesh-git
[[ $- == *i* ]] && source /usr/share/blesh/ble.sh --noattach
[[ ${BLE_VERSION-} ]] && ble-attach

source /usr/share/doc/find-the-command/ftc.bash

# source files
[ -r /usr/share/bash-completion/completions ] && source /usr/share/bash-completion/completions/*

# Aliases
alias ls="ls --color"
alias vi="vim"
alias dir='dir --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias grep='grep --color=auto'
alias grubup="sudo update-grub"
alias hw='hwinfo --short'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias psmem='ps auxf | sort -nr -k 4'
alias rmpkg="sudo pacman -Rdd"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias upd='/usr/bin/update'
alias vdir='vdir --color=auto'
alias wget='wget -c '

# Help people new to Arch
alias apt-get='man pacman'
alias apt='man pacman'
alias cht='cht.sh --shell'
alias plz='sudo'
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns `pacman -Qtdq`'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
