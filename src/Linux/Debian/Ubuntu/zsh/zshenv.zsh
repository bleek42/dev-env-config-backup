#!/usr/bin/env zsh

export ZPLUG_ROOT=/usr/share/zplug
export ZPLUG_HOME="${HOME}/.config/zplug"
export ZPLUG_BIN="${HOME}/.config/zplug/bin"
export ZPLUG_REPOS="${HOME}/.config/zplug/repos"
export ZPLUG_ERROR_LOG="${HOME}/.config/zplug/error_zplug.log"
export ZPLUG_CACHE_DIR="${HOME}/.config/zplug/cache"
export ZPLUG_LOADFILE="${HOME}/.config/zplug/packages.zsh"
export ZPLUG_PROTOCOL=HTTPS
export ZPLUG_FILTER=fzf:fzf-tmux
export ZPLUG_USE_CACHE=true
export ZPLUG_THREADS=16

# export VIRTUAL_ENV_DISABLE_PROMPT=1

export LESS='-R -F -i -J -M -W -x4 -z4'
export PAGER='/usr/bin/less'
export LESSOPEN="|~/.lessfilter %s 2>&-"
# export LESSOPEN="|~/.lessfilter %s 2>&-"

export LESS_ADVANCED_PREPROCESSOR=1
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
export MANPAGER=$'/bin/sh -c \'col -b | batcat -p -l man\''
# export MANPAGER="/bin/sh -c 'col -bx |bat --language=help -n man -p'"
export MANROFFOPT=-c
export BROWSER='/mnt/c/Program Files/Firefox Developer Edition/firefox.exe'
