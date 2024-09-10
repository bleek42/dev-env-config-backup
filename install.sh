#!/usr/bin/env bash

## ? Define the application name and version
APP_NAME="MyApp"
APP_VERSION="1.0.0"

## ? Define the installation directory
INSTALL_DIR="$HOME/$APP_NAME"

## ? Define the usage message
USAGE="
Usage: install.sh [options]

Options:
  --interactive  Run the installation in interactive mode
  --help         Display this help message

Example:
  ./install.sh --interactive
"

## ? Check for the --help flag
if [ "$1" == "--help" ]; then
  echo "$USAGE"
  exit 0
fi

## ? Check for the --interactive flag
if [ "$1" == "--interactive" ]; then
  echo "Running installation in interactive mode..."
  echo "Please confirm the installation directory: $INSTALL_DIR"
  read -p "Install to $INSTALL_DIR? (y/n) " RESPONSE
  if [ "$RESPONSE" != "y" ]; then
    echo "Installation cancelled."
    exit 0
  fi
fi

## ? This script is meant to be run from the root of the repo to install & bootstrap all the config/dotfiles for the current user based on the OS/environment.
os_long="$(uname -s)"
echo "Operating System/Shell Environment: ${os_long}:(${SHELL})"

case "${os_long}" in
Linux*)
  os_short="Linux"
  ;; ## ? Linux
Darwin*)
  os_short="Darwin"
  ;; ## ? MacOS
MSYS_NT*)
  os_short="MSYS_NT"
  ;; ## ? Windows 10/11, Powershell (v7)
CYGWIN*)
  os_short="CYGWIN"
  ;; ## ? Cygwin, Windows 10/11
MINGW64_NT*)
  os_short="MINGW64_NT" ## ? Windows 10/11, Git-Bash/64-bit (MSYS2/MINGW32)
  ;;
MINGW32_NT*)
  os_short="MINGW32_NT"
  ;;
*) os_short="unknown_os:$(echo "$os_long" | cut -c1-6)" ;;
esac

echo "Operating System/Shell Environment (shortened): ${os_short}:(${SHELL})"
## ? Create the installation directory if it doesn't exist
if [ ! -d "$INSTALL_DIR" ]; then
  mkdir -p "$INSTALL_DIR"
fi

## ? Move the application files to the installation directory
cp -r ./* "$INSTALL_DIR"

echo "Installation complete."
