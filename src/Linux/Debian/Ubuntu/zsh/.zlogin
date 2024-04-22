#!/usr/bin/env zsh

if [[ -o interactive ]]; then
    # ? ensure PATH entries remain unique after shell reload
    # ? typeset -gU PATH FPATH CDPATH MANPATH path fpath cdpath manpath
    typeset -gU PATH path FPATH fpath CDPATH cdpath MANPATH manpath
fi
