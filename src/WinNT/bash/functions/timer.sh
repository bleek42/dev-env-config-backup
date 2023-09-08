#!/usr/bin/env bash

# ═══════════════════════════════════════
# COMMAND EXECUTION TIMER
# ═══════════════════════════════════════
# Returns epoch nanosecond time
function timer_now() {
    date +%s%N
}

# Start a timer for the next command, or leave it at its current
# value if it exists
function timer_start() {
    start_time="${start_time:-$(timer_now)}"
}

# Stop a timer if running, and set the timer_show variable to
# the final value in a human-readable format.
function timer_stop() {
    # If no command was run, ignore any elapsed time.
    if [[ $NUM_CALLS -lt 2 ]]; then
        timer_show="␣"
        NUM_CALLS=0
        unset start_time
        return
    fi
    # Unit conversion
    local delta_us=$((($(timer_now) - start_time) / 1000))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    # Goal: always show around 3 digits of accuracy
    if ((h > 0)); then
        timer_show=${h}h${m}m
    elif ((m > 0)); then
        timer_show=${m}m${s}s
    elif ((s >= 10)); then
        timer_show=${s}.$((ms / 100))s
    elif ((s > 0)); then
        timer_show=${s}.$(printf %03d $ms)s
    elif ((ms >= 100)); then
        timer_show=${ms}ms
    elif ((ms > 0)); then
        timer_show=${ms}.$((us / 100))ms
    else
        timer_show=${us}us
    fi
    unset start_time
    NUM_CALLS=0
}

# ═══════════════════════════════════════
# PRE-COMMAND EXECUTION HOOK
# ═══════════════════════════════════════
function preexec() {
    # Character for showing commands executed this cycle
    ac='↣'
    # Before anything, print out a color code to make output default color
    echo -ne "\e[0m"
    # Concatenate expanded function calls into $this variable
    # So we can display it in PS1
    if [[ -z "$this" ]] && [[ "$BASH_COMMAND" != 'setprompt' ]] &&
        [[ "$BASH_COMMAND" != 'PROMPT_COMMAND=setprompt' ]]; then
        this=$BASH_COMMAND
        this="$(echo "$this" | sed 's/this=//g')"
    elif [[ "$BASH_COMMAND" != 'setprompt' ]] &&
        [[ "$BASH_COMMAND" != 'PROMPT_COMMAND=setprompt' ]]; then
        this+=" ${ac} "$BASH_COMMAND
        this="$(echo "$this" | sed 's/this+=" ${ac} "//g')"
    fi
    # Increment our counter for the number of simple commands executed
    # in this prompt cycle
    NUM_CALLS=$((NUM_CALLS + 1))
    # Begin a timer
    timer_start
}

# # Ensure this runs before every command.
# trap 'preexec' DEBUG
