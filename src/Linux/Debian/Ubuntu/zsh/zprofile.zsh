#!/usr/bin/env zsh

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# echo "$HOME/.profile"
test -f "$HOME/.profile" && emulate sh -c '. "$HOME/.profile"'

PNPM_HOME="$HOME/.local/share/pnpm"

case ":$path:" in
*":$PNPM_HOME:"*) ;;
*) path=($PNPM_HOME $path) ;;
esac

NODE_PATH="${NODE_PATH:-$PNPM_HOME}/node"

export PNPM_HOME NODE_PATH

# pnpm end
