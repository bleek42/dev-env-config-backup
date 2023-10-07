export WAYLAND_DISPLAY=
export LIBGL_ALWAYS_INDIRECT=1
export GDK_SCALE=1
export QT_SCALE_FACTOR=1
# export GTK_IM_MODULE='ibus'
# export
# export
# export GTK_THEME=''

if command -v keychain >/dev/null 2>&1; then
    # ssh_keychain="$HOME/.config/keychain"
    is_system_running="$(systemctl is-system-running)"
    # echo $is_system_running
    # --nogui --gpg2
    [[ "$is_system_running" =~ "running" ]] &&
        eval "$(keychain --confhost --systemd --inherit any --dir ~/.config/keychain --absolute --env ~/.config/keychain/$HOST-sh --eval id_ed25519_gh id_ed25519_work)" ||
        eval "$(keychain --confhost --inherit any --dir ~/.config/keychain --absolute --env ~/.config/keychain/$HOST-sh --eval id_ed25519_gh id_ed25519_work)"
fi


exec startxfce4
