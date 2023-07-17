#!/usr/bin/env zsh

# if [ -f "$HOME/.profile" ]; then
#     emulate sh -c '. ~/.profile'
# fi
export LESSOPEN='|~/.lessfilter %s'
PNPM_HOME="$HOME/.local/share/pnpm"

# pnpm
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) PATH="$PNPM_HOME:$PATH" ;;
esac
# export NIX_PROFILES="/nix/var/nix/profiles/default:$HOME/.nix-profile"
# NODE_PATH="$PNPM_HOME/nodejs"
# [ -d "$NODE_PATH" ] &&
export PNPM_HOME PATH
# pnpm end

## /etc/ssh/ssh_host_ed25519_key /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key
# eval "$(keychain -k mine)"
if command -v keychain >/dev/null 2>&1; then
    eval "$(keychain -Q --nogui --inherit any --dir "$HOME/.config/keychain" --absolute --eval id_ed25519_gh --quiet)"
fi

