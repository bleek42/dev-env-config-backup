#!/usr/bin/env sh

export LANG="en_US.UTF-8"
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

# umask 022

export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'
# Make less more friendly
export LESS_ADVANCED_PREPROCESSOR=1
export LESS='-R -F -i -J -M -W -x4 -z4'
export PAGER='less'
export MANPAGER="/bin/sh -c 'col -bx | batcat --language=help -n man -p'"
# export MANPAGER=$'/bin/sh -c \'col -b | batcat -p -l man\''
export EDITOR='/usr/bin/nvim'
export VISUAL='code'
export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permission
export LESSOPEN="| lesspipe |~/.lessfilter %s 2>&-"
# export LESSOPEN="|~/.lessfilter %s 2>&-"
export BROWSER='/mnt/c/Program Files/Mozilla/firefox.exe'

# export NODE_PRESERVE_SYMLINKS=1
export MANROFFOPT=-c

LESS_TERMCAP_md="$(tput setaf 136)"
[ -e "$LESS_TERMCAP_md" ] && export LESS_TERMCAP_md

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

export LIBGL_ALWAYS_INDIRECT=1 #GWSL
export GTK_THEME='Kali-Purple-Dark'
export GDK_SCALE=1 #GWSL
export QT_SCALE_FACTOR=1

DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0
PULSE_SERVER=tcp:$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):1
[ -e "$DISPLAY" ] && export DISPLAY
[ -e "$PULSE_SERVER" ] && export PULSE_SERVER

WSL_IPV4="$(hostname -I | awk '{print $1}' | awk '{printf $0}')"
[ -e "$WSL_IPV4" ] && export WSL_IPV4
export LESS='-F -i -J -M -R -W -x4 -X -z-4'
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# export XDG_DATA_HOME="$HOME/.local/share"
# export XDG_DATA_DIRS="/usr/share:/usr/local/share:$XDG_DATA_HOME"
# export XDG_CONFIG_HOME="$HOME/.config"
# export XDG_CONFIG_DIRS="/etc/xdg:$XDG_CONFIG_HOME"
# export XDG_STATE_HOME="$HOME/.local/state"
# export XDG_CACHE_HOME="$HOME/.cache"
