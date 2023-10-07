#!/usr/bin/env bash

## ? This script is meant to be run from the root of the repo to install & bootstrap all the config/dotfiles for the current user based on the OS/environment.
op_sys="$(uname -s)"
echo "Operating System/Shell Environment: ${op_sys}:(${SHELL})"

case "${op_sys}" in
Linux*)
    op_sys_short="Linux"
    ;; # ? Linux
Darwin*)
    op_sys_short="Darwin"
    ;; # ? MacOS
MSYS_NT*)
    op_sys_short="MSYS_NT"
    ;; # ? Windows 10/11, Powershell (v7)
CYGWIN*)
    op_sys_short="CYGWIN"
    ;; # ? Cygwin, Windows 10/11
MINGW64_NT*)
    op_sys_short="MINGW64_NT" # ? Windows 10/11, Git-Bash/64-bit (MSYS2/MINGW32)
    ;;
MINGW32_NT*)
    op_sys_short="MINGW32_NT"
    ;;
*) op_sys_short="UNKNOWN_OP_SYS:${op_sys}" ;;
esac

echo "Operating System/Shell Environment (shortened): ${op_sys_short}:(${SHELL})"
