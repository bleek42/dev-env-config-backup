#!/usr/bin/env zsh

user_commands=(
    cat
    get-default
    help
    is-active
    is-enabled
    is-failed
    is-system-running
    list-dependencies
    list-jobs
    list-sockets
    list-timers
    list-unit-files
    list-units
    show
    show-environment
    status
)

sudo_commands=(
    add-requires
    add-wants
    cancel
    daemon-reexec
    daemon-reload
    default
    disable
    edit
    emergency
    enable
    halt
    import-environment
    isolate
    kexec
    kill
    link
    list-machines
    load
    mask
    preset
    preset-all
    reenable
    reload
    reload-or-restart
    reset-failed
    rescue
    restart
    revert
    set-default
    set-environment
    set-property
    start
    stop
    switch-root
    try-reload-or-restart
    try-restart
    unmask
    unset-environment
)

power_commands=(
    hibernate
    hybrid-sleep
    poweroff
    reboot
    suspend
)

for c in $user_commands; do
    alias "sc-$c"="systemctl $c"
    alias "scu-$c"="systemctl --user $c"
done

for c in $sudo_commands; do
    alias "sc-$c"="sudo systemctl $c"
    alias "scu-$c"="systemctl --user $c"
done

for c in $power_commands; do
    alias "sc-$c"="systemctl $c"
done

unset c user_commands sudo_commands power_commands

# --now commands
alias sc-enable-now="sc-enable --now"
alias sc-disable-now="sc-disable --now"
alias sc-mask-now="sc-mask --now"

alias scu-enable-now="scu-enable --now"
alias scu-disable-now="scu-disable --now"
alias scu-mask-now="scu-mask --now"

# --failed commands
alias scu-failed='systemctl --user --failed'
alias sc-failed='systemctl --failed'
