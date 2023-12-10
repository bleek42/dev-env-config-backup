#!/usr/bin/env sh
#
# ~/.xsessiun
#
# ! Executed by x-session-manager (run your session manager from here)
export DESKTOP_SESSION="plasma"
export LIBGL_ALWAYS_INDIRECT=1
export GDK_SCALE=1
export QT_SCALE_FACTOR=1
export KDEHOME="$XDG_CONFIG_HOME"/kde
test -n "$WAYLAND_DISPLAY" && export WAYLAND_DISPLAY=""

userresources="${HOME}/.Xresource"s
usermodmap="${HOME}/.Xmodmap"
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap

# export GTK_THEME=''
# export GTK_IM_MODULE='ibus'

# ? see https://unix.stackexchange.com/a/295652/332452
# source /etc/X11/Xsession

# # ? see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
# eval $(/usr/bin/gnome-keyring-daemon --start)
# export SSH_AUTH_SOCK

# ? see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
# test -d "$HOME/.local/share/keyrings" || mkdir -p "$HOME/.local/share/keyrings"

exec x-session-manager &
