#!/usr/bin/env sh

## ? ~/.Xsession start up file for xfce4 desktop
## ? run with `emulate bash -c "source ~/.Xsession"` from ZSH, drop 'emulate' if using other shells
## ? use with XRDP, XLaunch w/ RDP, tigerVNC, etc...

# ?!fix broken $UID on some system...
if test "x$UID" = "x"; then
    if test -x /usr/xpg4/bin/id; then
        UID=$(/usr/xpg4/bin/id -u)
    else
        UID=$(id -u)
    fi
fi

# ! set $XDG_MENU_PREFIX to "xfce-" so that "xfce-applications.menu" is picked
# ! over "applications.menu" in all Xfce applications.
if test "x$XDG_MENU_PREFIX" = "x"; then
    XDG_MENU_PREFIX="xfce-"
    export XDG_MENU_PREFIX
fi

# ! set DESKTOP_SESSION so that one can detect easily if an Xfce session is running
if test "x$DESKTOP_SESSION" = "x"; then
    DESKTOP_SESSION="xfce"
    export DESKTOP_SESSION
fi

# ! set XDG_CURRENT_DESKTOP so that Qt 5 applications can identify user set Xfce theme
if test "x$XDG_CURRENT_DESKTOP" = "x"; then
    XDG_CURRENT_DESKTOP="XFCE"
    export XDG_CURRENT_DESKTOP
fi

# * $XDG_CONFIG_HOME defines the base directory relative to which user specific
# * configuration files should be stored. If $XDG_CONFIG_HOME is either not set
# * or empty, a default equal to $HOME/.config should be used.
if test "x$XDG_CONFIG_HOME" = "x"; then
    XDG_CONFIG_HOME=$HOME/.config
fi
[ -d "$XDG_CONFIG_HOME" ] || mkdir "$XDG_CONFIG_HOME"

# * $XDG_CACHE_HOME defines the base directory relative to which user specific
# * non-essential data files should be stored. If $XDG_CACHE_HOME is either not
# * set or empty, a default equal to $HOME/.cache should be used.
if test "x$XDG_CACHE_HOME" = "x"; then
    XDG_CACHE_HOME=$HOME/.cache
fi
[ -d "$XDG_CACHE_HOME" ] || mkdir "$XDG_CACHE_HOME"

# ! set up XDG user directores.  see
# http://freedesktop.org/wiki/Software/xdg-user-dirs
if command -v xdg-user-dirs-update >/dev/null 2>&1; then
    xdg-user-dirs-update
fi

# ? For now, start with an empty list
XRESOURCES=""

# ! Has to go prior to merging Xft.xrdb, as its the "Defaults" file
test -r "/etc/xdg/xfce4/Xft.xrdb" && XRESOURCES="$XRESOURCES /etc/xdg/xfce4/Xft.xrdb"
test -r $HOME/.Xdefaults && XRESOURCES="$XRESOURCES $HOME/.Xdefaults"

BASEDIR=$XDG_CONFIG_HOME/xfce4
if test -r "$BASEDIR/Xft.xrdb"; then
    XRESOURCES="$XRESOURCES $BASEDIR/Xft.xrdb"
elif test -r "$XFCE4HOME/Xft.xrdb"; then
    mkdir -p "$BASEDIR"
    cp "$XFCE4HOME/Xft.xrdb" "$BASEDIR"/
    XRESOURCES="$XRESOURCES $BASEDIR/Xft.xrdb"
fi

# ! merge in X cursor settings
test -r "$BASEDIR/Xcursor.xrdb" && XRESOURCES="$XRESOURCES $BASEDIR/Xcursor.xrdb"

# ~/.Xresources contains overrides to the above
test -r "$HOME/.Xresources" && XRESOURCES="$XRESOURCES $HOME/.Xresources"

# ! load all X resources (adds /dev/null to avoid an empty list that would hang the process)
cat /dev/null $XRESOURCES | xrdb -merge -

# ! load local modmap
test -r $HOME/.Xmodmap && xmodmap $HOME/.Xmodmap

# ! if XAUTHLOCALHOSTNAME is not set in systemd user session, starting of xfce4-notifyd, DISPLAY etc. will fail
if command -v systemctl >/dev/null 2>&1 && systemctl --user list-jobs >/dev/null 2>&1; then # ? user session is running
    dbus-update-activation-environment --systemd XAUTHLOCALHOSTNAME=$XAUTHLOCALHOSTNAME
fi

# ! check if in Windows Subsystem for Linux (WSL) by checking if var WSL_ENV array/string exists
if [ -e "$WSL_ENV" ]; then
    export GDK_SCALE=1
    export QT_SCALE_FACTOR=1
# export GTK_THEME=''
fi

# ! check if we start xfce4-session with ck-launch-session. this is only
# ! required for starting from a console, not a login manager
if test "x$XFCE4_SESSION_WITH_CK" = "x1"; then
    if command -v ck-launch-session >/dev/null 2>&1; then
        exec ck-launch-session xfce4-session
    else
        echo
        echo "You have tried to start Xfce with consolekit support, but"
        echo "ck-launch-session is not installed."
        echo "Aborted startup..."
        echo
        exit 1
    fi
else
    # * start xfce4-session normally
    exec xfce4-session
fi
# export LIBGL_ALWAYS_INDIRECT=0

# xrandr --dpi 279 &
# startxfce4 &

# ? if we got here, then exec failed
exit 1
