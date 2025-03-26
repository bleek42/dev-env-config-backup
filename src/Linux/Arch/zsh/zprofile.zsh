#!/usr/bin/env zsh


# emulate bash -c 'source /etc/profile'

test -f "${HOME}/.profile" && \
    source "${HOME}/.profile"

typeset -gU path PATH fpath FPATH cdpath CDPATH manpath MANPATH module_path MODULE_PATH
