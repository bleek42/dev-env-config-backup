#!/usr/bin/env sh

## ? ~/.profile: executed by the command interpreter for login shells.
## ? This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login exists.
## ? see /usr/share/doc/bash/examples/startup-files for examples.
## ? the files are located in the bash-doc package.
## ! the system-wide default umask is typically set in /etc/profile;
## ! for setting the umask for ssh logins, install and configure the libpam-umask package.
## ! overide it by setting the umask for current users that are in interactive login shells

if tty -s; then
    umask 022
fi

## ? default display
if [ -z "$DISPLAY" ]; then
    export DISPLAY=:0
fi

## ? set PATH so it includes user's private bin if it exists
# if [ -d "${HOME}/.local/bin" ] && ! echo "$PATH" | tr : '\n' | grep -q "^/sbin$"; then
#     PATH="${HOME}/.local/bin:${PATH}"
# fi

# pnpm
# if command -v pnpm >/dev/null 2>&1; then
#     PNPM_HOME="${HOME}/.local/share/pnpm"

#     if [ -d "${PNPM_HOME}" ]; then
#         export PNPM_HOME

#         case ":$PATH:" in
#         *":$PNPM_HOME:"*)
#             export PATH
#             ;;
#         *)
#             export PATH="${PNPM_HOME}:${PATH}"
#             ;;
#         esac
#     fi
# fi
# pnpm end

## ? ~/.profile stuff to run only when sourced from particular shell types
## ! ZSH only stuff
if [ -n "$ZSH_VERSION" ]; then
    if [ -n "$LF_LEVEL" ]; then
        test -z "$RPROMPT" &&
            RPROMPT="(LF:${LF_LEVEL})" ||
            RPROMPT="${RPROMPT}-(LF:${LF_LEVEL})"

        export RPROMPT
    fi
fi

## ! Bash only stuff
if [ -n "$BASH_VERSION" ]; then
    # shellcheck disable=SC1091
    . "${HOME}/.bashrc"

    if [ -n "$LF_LEVEL" ]; then
        test -n "$PS4" &&
            PS4="${PS4}(LF_lvl:${LF_LEVEL})" ||
            PS4="(LF_lvl:${LF_LEVEL})"

        export PS4

    fi
fi
