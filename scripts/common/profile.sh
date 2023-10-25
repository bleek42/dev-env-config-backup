#!/usr/bin/env sh

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# the files are located in the bash-doc package.
# for ssh logins, install and configure the libpam-umask package.

# [[ -f /etc/profile ]] && . /etc/profile
# the default umask is set in /etc/profile; for setting the umask
umask 022

export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permission
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:${PATH}"
fi

export LIBGL_ALWAYS_INDIRECT=1 #GWSL
export GDK_SCALE=1             #GWSL
export QT_SCALE_FACTOR=1

DISPLAY="$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')":0
PULSE_SERVER=tcp:"$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')":1
export DISPLAY PULSE_SERVER

IPV4="$(ip route | awk '/^default/{print $3}')"
test -n "$IPV4" && export IPV4

if [ -f /opt/conda/etc/profile.d/conda.sh ]; then
    source /opt/conda/etc/profile.d/conda.sh
fi