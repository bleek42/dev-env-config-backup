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
export LIBGL_ALWAYS_INDIRECT=1      #GWSL
export DISPLAY="${WSL_IPV4}":0      #GWSL
export PULSE_SERVER="${WSL_IPV4}":1 #GWSL
export GDK_SCALE=1                  #GWSL
export GTK_THEME='Kali-Purple-Dark'
export QT_SCALE_FACTOR=1 #GWSL
export LS_COLORS="${LS_COLORS}:ow=30;44:" # fix ls color for folders with 777 permissions
