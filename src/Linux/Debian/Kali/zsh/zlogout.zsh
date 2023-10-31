#!/usr/bin/env zsh

if command -v keychain >/dev/null 2>&1; then
  ssh_agents=$(keychain -l)
fi

