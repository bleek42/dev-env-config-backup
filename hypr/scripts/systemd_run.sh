#!/usr/bin/env sh

function systemd_run_create_unit () {
    # * arguments are accessible through $1, $2,...
    systemd-run -q -r --no-block --user --unit="$1-run" --slice="$2.slice"
}

systemd_run_create_unit "$@"
