#!/usr/bin/env bash

export DISPLAY=:0

if [ "$TERM_PROGRAM" = "vscode" ]; then
    unset WT_SESSION
    unset WT_PROFILE_ID
fi

if [ -n "$WT_SESSION" ]; then
    export COLORTERM="truecolor"
    export INIT_WT_SESSION="$WT_SESSION"
    if tty -s && [[ "$INIT_WT_SESSION" = "$WT_SESSION" ]] && command -v neofetch >/dev/null 2>&1; then
        neofetch --w3m --size 60%
    fi

    if command -v oh-my-posh >/dev/null 2>&1; then
        alias omp='oh-my-posh'

        case "$WT_PROFILE_ID" in
        "{22cf8483-2f1e-4eb2-b9d2-1459fdfc8b94}")
            eval "$(oh-my-posh prompt init bash --config "${HOME}"/.custom-lambda-gen.omp.json)"
            ;;
        "{46ca431a-3a87-5fb3-83cd-11ececc031d2}")
            eval "$(oh-my-posh prompt init bash --config "${POSH_THEMES_PATH}"/kali.omp.json)"
            ;;
        *)
            eval "$(oh-my-posh prompt init bash --config "${POSH_THEMES_PATH}"/tokyo.omp.json)"
            ;;
        esac
    fi
fi
