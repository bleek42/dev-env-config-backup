#!/usr/bin/env zsh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# echo "$HOME/.profile"

if [[ -f ${HOME}/.profile ]] then
    emulate sh -c '. "${HOME}/.profile"'
fi

## ! ensure PATH entries remain unique after shell reload
typeset -xU path PATH fpath FPATH cdpath CDPATH

# if [[ -z ${debian_chroot:-} ]] && [[ -f /etc/debian_chroot ]]; then
#     debian_chroot="$(cat /etc/debian_chroot)"
# fi

if [[ -n ${RANGER_LEVEL} ]] && [[ -n ${RPROMPT} ]]; then
    RPROMPT="${RPROMPT}[ranger]}"
fi

if [[ -n ${RANGER_LEVEL} ]] && [[ -z ${RPROMPT} ]]; then
    RPROMPT="[ranger]"
fi

# if [[ -n ${WSL_INTEROP:?} ]]; then
#     export BROWSER='firefox.exe'
# fi
