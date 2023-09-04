#!/usr/bin/env bash
## ? This script is meant to be run from the root of the repo to install & bootstrap all the config/dotfiles for the current user based on the OS/environment.

operating_system="$(uname -s)"
case "${operating_system}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${operating_system}"
esac

