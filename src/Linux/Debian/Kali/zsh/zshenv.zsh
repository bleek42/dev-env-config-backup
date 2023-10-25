#!/usr/bin/env zsh

# configure `time` format
export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
export PAGER='/usr/bin/less'
export LESS='-R -F -i -J -M -W -x4 -z4'
export LESSOPEN="| lesspipe |~/.lessfilter %s 2>&-"
export LIBGL_ALWAYS_INDIRECT=1 #GWSL  # reset underline
export EDITOR='/usr/bin/vim'
export VISUAL='code.exe'
export MANROFFOPT=-c
export ZCOMPDUMP="$HOME/.cache/zcompdump"

# # ZPLUG
export ZPLUG_ROOT=/usr/share/zplug
export ZPLUG_HOME="$HOME/.config/zplug"
export ZPLUG_BIN="$ZPLUG_HOME/bin"
export ZPLUG_LOADFILE="$ZPLUG_HOME/packages.zsh"
export ZPLUG_CACHE_DIR="$ZPLUG_HOME/cache"
export ZPLUG_USE_CACHE=true
export ZPLUG_ERROR_LOG="$ZPLUG_HOME/error_zplug.log"
export ZPLUG_REPOS="$ZPLUG_HOME/repos"
export ZPLUG_PROTOCOL=HTTPS
export ZPLUG_FILTER=fzf:fzf-tmux
