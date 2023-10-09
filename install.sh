#!/usr/bin/env bash

## ? This script is meant to be run from the root of the repo to install & bootstrap all the config/dotfiles for the current user based on the OS/environment.
os_long="$(uname -s)"

echo "Operating System/Shell Environment: ${os_long}:(${SHELL})"

case "${os_long}" in
Linux*)
	os_short="Linux"
	;; # ? Linux
Darwin*)
	os_short="Darwin"
	;; # ? MacOS
MSYS_NT*)
	os_short="MSYS_NT"
	;; # ? Windows 10/11, Powershell (v7)
CYGWIN*)
	os_short="CYGWIN"
	;; # ? Cygwin, Windows 10/11
MINGW64_NT*)
	os_short="MINGW64_NT" # ? Windows 10/11, Git-Bash/64-bit (MSYS2/MINGW32)
	;;
MINGW32_NT*)
	os_short="MINGW32_NT"
	;;
*) os_short="unknown_os:$(echo "$os_long" | cut -c1-6)" ;;
esac

echo "Operating System/Shell Environment (shortened): ${os_short}:(${SHELL})"
