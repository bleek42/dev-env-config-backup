#!/usr/bin/env zsh

if [[ $SHLVL = 1 ]] && [[ -x $(command -v clear_console) ]]; then
    clear_console -q
fi
