#!/usr/bin/env zsh

# ensure PATH entries remain unique after shell reload
typeset -gU PATH path FPATH fpath CDPATH cdpath MANPATH manpath

if command -v keychain >/dev/null 2>&1; then
    # ssh_keychain="$HOME/.config/keychain"
    is_system_running="$(systemctl is-system-running)"
    # echo $is_system_running
    # --nogui --gpg2
    [[ -d "$HOME/.config/keychain" ]] || mkdir "$HOME/.config/keychain"

    [[ "$is_system_running" =~ "running" ]] &&
        eval "$(keychain --confhost --nogui --systemd --inherit any --dir ~/.config/keychain --eval id_ed25519_gh id_ed25519_work)" ||
        eval "$(keychain --confhost --nogui --inherit any --dir ~/.config/keychain --absolute --eval id_ed25519_gh id_ed25519_work)"
fi
