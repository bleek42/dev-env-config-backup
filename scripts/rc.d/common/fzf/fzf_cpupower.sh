#!/usr/bin/env sh

# speed up script and avoid language problems by using standard c
LC_ALL=C
LANG=C

# auth can be something like sudo -A, doas -- or nothing,
# depending on configuration requirements
auth="${EXEC_AS_USER:-sudo}"
config="/etc/default/cpupower"
service="cpupower.service"
edit="$EDITOR"

# sysfs policy control files
policies_path="/sys/devices/system/cpu/cpufreq"
governor_path="$policies_path/policy0/scaling_governor"
epp_available_path="$policies_path/policy0/energy_performance_available_preferences"
epp_path="$policies_path/policy0/energy_performance_preference"

# help
script=$(basename "$0")
help="$script [-h/--help] -- script to manage cpupower
  Usage:
    $script

  Examples:
    $script

  Config:
    config  = $config
    service = $service
    edit    = $edit"

[ -n "$1" ] \
    && printf "%s\n" "$help" \
    && exit 0

# helper functions
highlight_string() {
    [ -z "$NO_COLOR" ] \
        && color="\033[0;94m" \
        && reset="\033[0m"

    printf "[%b%s%b]" "$color" "$1" "$reset"
}

cpupower_wrapper() {
    info=$("$auth" cpupower frequency-info "$@")

    [ "$(printf "%s" "$info" | wc -l)" -lt 1 ] \
        && printf "Cannot determine or is not supported." \
        && return

    case "$1" in
        --stats)
            printf "%s" "$info" \
                | cut -d'(' -f1 \
                | tr ',' '\n' \
                | sed 's/:/: /g' \
                | awk 'NR>1 {$1=$1;print}'
            ;;
        --boost)
            printf "%s" "$info" \
                | awk 'NR>2 {$1=$1;print}'
            ;;
        --perf)
            printf "%s" "$info" \
                | awk 'NR>1 {$1=$1;print}' \
                | sed 's/AMD PSTATE //g'
            ;;
        *)
            printf "%s" "$info" \
                | cut -d':' -f2- \
                | awk 'NR>1 {$1=$1;print}'
            ;;
    esac
}

get_governor_info() {
    governor=$(cat "$governor_path")

    printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n\n" \
        "» generic scaling governors" \
        "conservative   = current load (more gradually than ondemand)" \
        "ondemand       = scales cpu frequency according to current load" \
        "userspace      = user specified cpu frequency (scaling_setspeed)" \
        "powersave      = minimum cpu frequency (scaling_min_freq)" \
        "performance    = maximum cpu frequency (scaling_max_freq)" \
        "schedutil      = scheduler-driven cpu frequency" \
            | sed "s/\b$governor\b  /$(highlight_string "$governor")/"

    printf "» available governors\n%s\n\n" \
        "$(cpupower_wrapper --governors)" \
            | sed "s/\b$governor\b/$(highlight_string "$governor")/"

    printf "» currently used cpufreq policy\n%s\n\n" \
        "$(cpupower_wrapper --policy)" \
            | sed "s/\"\b$governor\b\"/$(highlight_string "$governor")/"
}

get_epp_info() {
    [ -s "$epp_path" ] \
        && epp=$(cat "$epp_path")

    printf "%s\n%s\n%s\n%s\n%s\n%s\n\n" \
        "» generic energy performance preferences" \
        "default                = performance and power are balanced" \
        "performance            = maximum performance" \
        "balance_performance    = high priority on performance" \
        "balance_power          = power and performance are balanced" \
        "power                  = maximum energy efficiency" \
            | sed "s/\b$epp\b  /$(highlight_string "$epp")/"

    printf "» available energy performance preferences\n%s\n\n" \
        "$(printf "%s" "$epp_available")" \
            | sed "s/\b$epp\b/$(highlight_string "$epp")/"
}

get_frequency_info() {
    printf "» current cpu frequency\n%s\n\n" \
        "$(cpupower_wrapper --freq --human)"

    printf "» maximum cpu frequency\n%s\n\n" \
        "$(cpupower_wrapper --hwlimits --human)"

    printf "» boost state support\n%s\n\n" \
        "$(cpupower_wrapper --boost)"

    printf "» cpu frequency statistics\n%s\n\n" \
        "$(cpupower_wrapper --stats --human)"

    printf "» cpus run at the same hardware frequency\n%s\n\n" \
        "$(cpupower_wrapper --related-cpus)"

    printf "» cpus need to have their frequency coordinated by software\n%s\n\n" \
        "$(cpupower_wrapper --affected-cpus)"

    printf "» maximum latency on cpu frequency changes\n%s\n\n" \
        "$(cpupower_wrapper --latency --human)"

    printf "» performances and frequencies capabilities of cppc\n%s\n\n" \
        "$(cpupower_wrapper --perf)"

    printf "» used cpu kernel driver\n%s\n\n" \
        "$(cpupower_wrapper --driver)"
}

set_governor() {
    [ -n "$1" ] \
        && "$auth" cpupower frequency-set --governor \
            "$(printf "%s" "$1" | cut -d' ' -f3)"
}

set_epp() {
    [ -n "$1" ] \
        && for policy in $(find "$policies_path" -maxdepth 1 -type d | sed 1d); do
            printf "Setting epp: "
            printf "%s\n" "$1" \
                | cut -d' ' -f3 \
                | "$auth" tee "$policy/energy_performance_preference"
        done
}

set_frequency() {
    printf "Frequencies can be passed in Hz, kHz, MHz, GHz, or THz.\n"
    printf "e.g. 1400MHz, leave blank to return to the menu without changes.\n"
    printf "\n\r%s to: " "$1" \
        && read -r frequency
    [ -n "$frequency" ] \
        && "$auth" cpupower frequency-set "$2" "$frequency"
}

exit_status() {
    printf "%s" \
        "The command exited with status $?. " \
        "Press ENTER to continue."
    read -r select
}

toggle_cpupower_service() {
    if "$auth" systemctl -q is-active "$service"; then
        "$auth" systemctl -q disable "$service" --now
    else
        "$auth" systemctl -q enable "$service" --now
    fi
}

get_menu_entries() {
    printf "%s\n" \
            "set frequency" \
            "set frequency min" \
            "set frequency max" \
            "$(for value in $(cpupower_wrapper --governors); do
                printf "set governor %s\n" "$value"
            done)" \
            "$(for value in $epp_available; do
                printf "set epp %s\n" "$value"
            done)" \
            "toggle service" \
            "edit config" \
        | sed '/^$/d'
}

while true; do
    [ -s "$epp_available_path" ] \
        && epp_available=$(cat "$epp_available_path")

    # menu
    select=$(get_menu_entries \
        | fzf --cycle \
            --bind 'focus:transform-preview-label:echo [ {} ]' \
            --preview-window "right:75%,wrap" \
            --preview "case {} in
                \"set frequency\"*)
                    printf \"%s\" \"$(get_frequency_info)\"
                    ;;
                \"set governor\"*)
                    printf \"%s\" \"$(get_governor_info)\"
                    ;;
                \"set epp\"*)
                    printf \"%s\" \"$(get_epp_info)\"
                    ;;
                \"toggle service\")
                    printf \"%s\" \"$($auth systemctl status $service)\"
                    ;;
                \"edit config\")
                    cat \"$config\"
                    ;;
                esac" \
    )

    # select executable
    case "$select" in
        "set frequency")
            set_frequency "$select" "-f" \
                || exit_status
            ;;
        "set frequency min")
            set_frequency "$select" "-d" \
                || exit_status
            ;;
        "set frequency max")
            set_frequency "$select" "-u" \
                || exit_status
            ;;
        "set governor"*)
            set_governor "$select" \
                || exit_status
            ;;
        "set epp"*)
            set_epp "$select" \
                || exit_status
            ;;
        "toggle service")
            toggle_cpupower_service
            ;;
        "edit config")
            "$auth" "$edit" "$config"
            ;;
        *)
            break
            ;;
    esac
done
