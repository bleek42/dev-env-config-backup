#!/usr/bin/env zsh

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
export LESS='-R -F -i -J -M -W -x4 -z4'
export EDITOR='/usr/bin/nvim'
export VISUAL='code.exe'
export LESSOPEN="|~/.lessfilter %s 2>&-"
export BROWSER='powershell.exe -command start'
export MANROFFOPT=-c
export MANPAGER=$'/bin/sh -c \'col -b | batcat -p -l man\''
export WSL_IPV4="$(hostname -I | awk '{print $1}' | awk '{printf $0}')"
export EDITOR='/usr/bin/nvim'
export VISUAL='code.exe'
export LESSOPEN="|~/.lessfilter %s 2>&-"
export BROWSER='powershell.exe -command start'
export MANROFFOPT=-c
export MANPAGER=$'/bin/sh -c \'col -b | batcat -p -l man\''
# export NODE_PRESERVE_SYMLINKS=1
