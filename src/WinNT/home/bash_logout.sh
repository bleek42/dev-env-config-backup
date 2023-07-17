#!/usr/bin/env bash

# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ] && command -v clear >/dev/null 2>&1; then
  clear -q
fi
