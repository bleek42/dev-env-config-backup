#!/usr/bin/env zsh

# ensure PATH entries remain unique after shell reload
typeset -gU PATH path FPATH fpath CDPATH cdpath MANPATH manpath

# is_system_running="$(systemctl is-system-running)"
# echo "$is_system_running"

# if [[ -z "$is_system_running}" ]]; then
#     eval "$(service start ssh)"
# fi

# if command -v keychain >/dev/null 2>&1; then

#     [[ -d "${HOME}"/.config/keychain ]] && print "${HOME}"/.config/keychain || mkdir -p "${HOME}"/.config/keychain

#     if [[ "$is_system_running" =~ "running" ]]; then
#         keychain --systemd --absolute --dir "~/.config/keychain" --env "${HOME}/.config/keychain/${HOST}-sh" --inherit any --confhost
#     else
#         keychain --nogui --absolute --dir "${HOME}"/.config/keychain --env "${HOME}"/.config/keychain/"${HOST}"-sh --inherit any --confhost

#     fi
# fi
