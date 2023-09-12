#!/usr/bin/env zsh

# ZDOTDIR="/usr/share/zsh:${ZDOTDIR}"
# ZDOTDIR="${ZDOTDIR:-$HOME}/.config/rc.d/zsh"
# ZSH=/usr/share/zsh

export LESS='-R -F -i -J -M -W -x4 -z4'
export PAGER='/usr/bin/less'
export LESSOPEN="| lesspipe |~/.lessfilter %s 2>&-"
# export LESSOPEN="|~/.lessfilter %s 2>&-"
export LESS_ADVANCED_PREPROCESSOR=1
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
export MANPAGER="sh -c 'col -bx | bat -p -l man'"
export MANROFFOPT=-c
export EDITOR='nvim'
export VISUAL='code'
export BROWSER='firefox-developer-edition'

export ZPLUG_ROOT=/usr/share/zplug
export ZPLUG_HOME="$HOME/.config/zplug"
export ZPLUG_BIN="$HOME/.config/zplug/bin"
export ZPLUG_REPOS="$HOME/.config/zplug/repos"
export ZPLUG_ERROR_LOG="$HOME/.config/zplug/error_zplug.log"
export ZPLUG_CACHE_DIR="$HOME/.config/zplug/cache"
export ZPLUG_LOADFILE="$HOME/.config/zplug/packages.zsh"
export ZPLUG_PROTOCOL=HTTPS
export ZPLUG_FILTER=fzf:fzf-tmux
export ZPLUG_USE_CACHE=true
export ZPLUG_THREADS=16
