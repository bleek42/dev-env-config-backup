#!/usr/bin/env sh

## ? ~/.profile: executed by the command interpreter for login shells.
## ? This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
## ? exists.
## ? see /usr/share/doc/bash/examples/startup-files for examples.
## ? the files are located in the bash-doc package.

## ! the system-wide default umask is typically set in /etc/profile;
## ! for setting the umask for ssh logins, install and configure the libpam-umask package.
## ! overide it by setting the umask for current users that are in interactive login shells

if tty -s; then
    umask 022
fi

if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

# set PATH so it includes user's private bin if it exists
if [ -d "${HOME}/.local/bin" ] && ! echo "$PATH" | tr : '\n' | grep -q "^/sbin$"; then
    PATH="${HOME}/.local/bin:${PATH}"
fi

export PATH

# if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "${HOME}/.bashrc" ]; then
        . "${HOME}/.bashrc"
    fi
fi
