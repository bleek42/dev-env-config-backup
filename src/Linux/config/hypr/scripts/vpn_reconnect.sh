#!/usr/bin/env bash

## ? Configuration
vpn_name="insert-here-vpn-name"

## ? Last message variable
vpn_last_message=""

## ? Function to log messages with a timestamp, only if the message has changed
log_vpn_message() {
    if [[ "$1" != "$vpn_last_message" ]]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
        vpn_last_message=$1
    fi
}


## ? Main loop
while true; do

    ## * Check if VPN exists
    if ! nmcli con show | grep -q "$vpn_name"; then
        echo "VPN '$vpn_name' does not exist. Please check your VPN name and try again." >&2
        exit 1
    fi

    ## * Check VPN status
    if nmcli con show --active | grep -q "$vpn_name"; then
        log_vpn_message "VPN $vpn_name is connected."
    else
        log_vpn_message "VPN $vpn_name disconnected, attempting to reconnect..."
        if nmcli con up id "$vpn_name"; then
            log_vpn_message "Reconnected to VPN $vpn_name successfully."
        else
            log_vpn_message "Failed to reconnect to VPN $vpn_name."
        fi
    fi

    ## * Wait before checking again
    sleep 1
done

