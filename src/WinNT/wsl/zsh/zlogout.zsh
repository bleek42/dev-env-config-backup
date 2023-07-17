#!/usr/bin/env zsh

if command -v keychain >/dev/null 2>&1; then
    eval "$(keychain -Q -k mine)"
fi

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
