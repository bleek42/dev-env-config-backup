#!/usr/bin/env zsh

# ensure PATH entries remain unique after shell reload
typeset -gU PATH path FPATH fpath CDPATH cdpath MANPATH manpath

[[ -f "$HOME/.config/rc.d/zsh/run-ssh-agent.zsh" ]] && source "$HOME/.config/rc.d/zsh/run-ssh-agent.zsh"

zstyle ':omz:plugins:ssh-agent' agent-forwarding yes
zstyle :omz:plugins:ssh-agent lazy yes
# zstyle :omz:plugins:ssh-agent helper ksshaskpass
