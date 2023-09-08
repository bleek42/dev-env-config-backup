#!/usr/bin/env zsh

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
export LESS='-R -F -i -J -M -W -x4 -z4'
export PAGER='/usr/bin/less'
export EDITOR='/usr/bin/nvim'
export VISUAL='code.exe'
export LESSOPEN="|~/.lessfilter %s 2>&-"
export BROWSER='pwsh.exe -command start'
export MANROFFOPT=-c
export MANPAGER=$'/bin/sh -c \'col -b | batcat -p -l man\''
