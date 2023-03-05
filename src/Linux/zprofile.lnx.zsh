#!/usr/bin/env zsh

[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

setopt GLOB_DOTS

# if [ -f "$ZSH/oh-my-zsh.sh" ]; then
#   source "$ZSH/oh-my-zsh.sh"
# fi

# User configuration

export MANPATH="/usr/local/man:$MANPATH"

[[ $(tty) = "/dev/pts/0" ]] && neofetch 