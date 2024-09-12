#!/usr/bin/env zsh

if [[ -o interactive ]] && [[ $(tty) == /dev/pts/0 ]] && [[ -n $TERM_PROGRAM ]] && [[ $TERM_PROGRAM != vscode ]]; then
    local fetch_cmd
    fetch_cmd="$(command -v fastfetch 2>/dev/null || command -v neofetch 2>/dev/null || return 1)"
    if [[ -z $fetch_cmd ]]; then
        echo 'Unable to display system information: no fetch command found in PATH...'
    else
        case "$fetch_cmd" in
        */fastfetch)
            $fetch_cmd
            ;;
        */neofetch)
            $fetch_cmd
            ;;
        *)
            echo "Unable to display system information: unknown fetch command '$fetch_cmd'..."
            ;;
        esac
    fi

    unset fetch_cmd

fi
