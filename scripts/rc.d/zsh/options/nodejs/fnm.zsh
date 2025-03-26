#!/usr/bin/env zsh

if (( ${+commands[fnm]} )); then

    if [[ -f ${XDG_CONFIG_DIR:-${HOME}/.config}/rc.d/zsh/completions/_fnm ]]; then

        typeset -g -A _comps
        autoload -Uz _fnm
        _comps[fnm]=_fnm

    else

        command mkdir -p ~/.config/rc.d/zsh/completions && \
            fnm completions >| ~/.config/rc.d/zsh/completions/_fnm &|

    fi

    eval "$(fnm env --use-on-cd --shell zsh)"

else

    echo "ERROR: Fast NodeJS Manager (fnm) command cannot be found in your \$PATH..!"
    # Check for bugs such as null pointer references, unhandled exceptions, and more.
    if [[ -n $commands[fnm] ]]; then
        echo "BUG: fnm command is in \$PATH, but still not accessible?"
        echo "Please check your \$PATH for possible errors!!!"
        echo "This could be a file permissions issue: must be executable and allowed to be accessed by current user(s) or group(s) ..!"
        echo "If all else fails, please try reinstalling via Cargo/Rust"
        return 2
    fi
    return 1

fi
