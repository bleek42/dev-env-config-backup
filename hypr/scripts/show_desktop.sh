#!/usr/bin/env bash

function show_hyprland_desktop() {

    local HYPR_DESKTOP_STATE CURRENT_WORKSPACE HYPR_CMDS

    HYPR_DESKTOP_STATE="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/hypr/desktop-state"

    CURRENT_WORKSPACE=$(hyprctl monitors -j | jq '.[] | .activeWorkspace | .name' | sed 's/"//g')

    if [ -s "$HYPR_DESKTOP_STATE-$CURRENT_WORKSPACE" ]; then
        readarray -d $'\n' -t ADDRESS_ARRAY <<< "$(< "${HYPR_DESKTOP_STATE}-${CURRENT_WORKSPACE}")"

        for address in "${ADDRESS_ARRAY[@]}"; do
            CMDS+="dispatch movetoworkspacesilent name:$CURRENT_WORKSPACE,address:$address;"
        done

        hyprctl --batch "$CMDS"

        rm "${HYPR_DESKTOP_STATE}-${CURRENT_WORKSPACE}"
    else
        HIDDEN_WINDOWS=$(hyprctl clients -j | jq --arg CW "$CURRENT_WORKSPACE" '.[] | select (.workspace .name == $CW) | .address')

        readarray -d $'\n' -t ADDRESS_ARRAY <<< "$HIDDEN_WINDOWS"

        for address in "${ADDRESS_ARRAY[@]}"; do
            address=$(sed 's/"//g' <<< "$address")

            if [ -n "$address" ]; then
                PREV_ADDRESS+="$address\n"
            fi

            HYPR_CMDS+="dispatch movetoworkspacesilent special:desktop,address:$address;"
        done

        hyprctl --batch "$CMDS"

        echo -e "$PREV_ADDRESS" | sed -e '/^$/d' > "$HYPR_DESKTOP_STATE-$CURRENT_WORKSPACE"
    fi

}

show_hyprland_desktop "$@"
