#!/usr/bin/env zsh

if [[ -x $(command -v clear_console) ]] && [[ $SHLVL = 1 ]]; then
    # echo "logging out, clearing console..."
    clear_console -q
fi
