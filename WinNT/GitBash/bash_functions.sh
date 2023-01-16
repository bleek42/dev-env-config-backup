#!/usr/bin/bash

# ═══════════════════════════════════════
# COLORS AND FUN
# ═══════════════════════════════════════

# flashes the terminal background, q to exit
function flasher() {
  while true; do
    printf "\\e[?5h"
    sleep 0.1
    printf "\\e[?5l"
    read -r -s -n1 -t1 && break
  done
}

# prints ANSI 16-colors
# function ansicolortest() {
#   T='ABC' # The test text
#   echo -ne "\n\011\011   40m     41m     42m     43m"
#   echo -e "     44m     45m     46m     47m"
#   fff=('    m' '   1m' '  30m' '1;30m' '  31m' '1;31m')
#   fff2=('  32m' '1;32m' '  33m' '1;33m' '  34m' '1;34m')
#   fff3=('  35m' '1;35m' '  36m' '1;36m' '  37m' '1;37m')
#   FGS=("${fff[@]}" "${fff2[@]}" "${fff3[@]}")
#   for FGs in "${FGS[@]}"; do
#     FG=${FGs// /}
#     echo -en " $FGs\011 \033[$FG  $T  "
#     for BG in 40m 41m 42m 43m 44m 45m 46m 47m; do
#       echo -en "$EINS \033[$FG\033[$BG  $T \033[0m\033[$BG \033[0m"
#     done
#     echo ""
#   done
#   echo ""
# }

# # prints xterm 256 colors
# function 256colortest() {
#   echo -en "\n   +  "
#   for i in {0..35}; do
#     printf "%2b " $i
#   done
#   printf "\n\n %3b  " 0
#   for i in {0..15}; do
#     echo -en "\033[48;5;${i}m  \033[m "
#   done
#   #for i in 16 52 88 124 160 196 232; do
#   for i in {0..6}; do
#     let "i = i*36 +16"
#     printf "\n\n %3b  " $i
#     for j in {0..35}; do
#       let "val = i+j"
#       echo -en "\033[48;5;${val}m  \033[m "
#     done
#   done
#   echo -e "\n"
# }

# check top ten commands executed
topten() {
  all=$(history | awk '{print $2}' | awk 'BEGIN {FS="|"}{print $1}')
  echo "$all" | sort | uniq -c | sort -n | tail | sort -nr
}

# ═══════════════════════════════════════
# FILES AND WINDOWS
# ═══════════════════════════════════════

# swap the names/contents of two files
function swap() { # Swap 2 filenames around, if they exist (from Uzi's bashrc).
  local TMPFILE=tmp.$$

  [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
  [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
  [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

  mv "$1" $TMPFILE
  mv "$2" "$1"
  mv $TMPFILE "$2"
}

# compare the md5 of a file to a know sum
md5check() { md5sum "$1" | grep "$2"; }

# Change the title of the terminal window
function settitle() {
  echo -ne "\e]2;$*\a\e]1;$*\a"
}

# ═══════════════════════════════════════
# DIAGNOSTIC INFO
# ═══════════════════════════════════════
# returns a bunch of information about the current host
# useful when jumping around hosts a lot
function ii() {
  echo -e "\nYou are logged on to ${ECHOG}$(hostname)$NC"
  echo -e "\n${ECHOG}Additionnal information:$NC "
  uname -a
  echo -e "\n${ECHOG}Users logged on:$NC "
  w -hs |
    cut -d " " -f1 | sort | uniq
  echo -e "\n${ECHOG}Current date :$NC "
  date
  echo -e "\n${ECHOG}Machine stats :$NC "
  uptime
  echo -e "\n${ECHOG}Memory stats :$NC "
  free
  echo -e "\n${ECHOG}Diskspace :$NC "
  df / $HOME
  echo -e "\n${ECHOG}Local IP Address :$NC"
  ip
  echo ''
}

# print uptime, host name, number of users, and average load
function upinfo() {
  echo -ne "$HOSTNAME uptime is "
  uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
}

# ═══════════════════════════════════════
# EXIT STATUS MANAGEMENT
# ═══════════════════════════════════════
# Gets the exit code of the last command executed.
# Use "printf '%.*s' $? $?" to show only non-zero codes.
# The characters ✓ and ✗ may also be helpful!
function lastexit() {
  EXITSTATUS="$1"
  if [ "$EXITSTATUS" -eq 0 ]; then
    echo -e "${ESG}${EXITSTATUS}"
  else
    echo -e "${RED}${EXITSTATUS}"
  fi
}

# Returns only a red or green color, depending on exit status
function lastexitcolor() {
  EXITSTATUS="$1"
  if [ "$EXITSTATUS" -eq 0 ]; then
    echo -e "${ESG}"
  else
    echo -e "${ESR}"
  fi
}

# ═══════════════════════════════════════
# GIT BRANCH MANAGEMENT
# ═══════════════════════════════════════
# Return a pretty-formatted string of the current git branch, if it exists
function gitbranch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null 1>/dev/null
  if [[ "$?" -eq "0" ]]; then
    str=" $(git rev-parse --abbrev-ref HEAD | tr -d '$' | tr -d '`')"
    echo " ${str}"
  fi
}

# ═══════════════════════════════════════
# BATTERY DIAGNOSTICS FOR PS1
# ═══════════════════════════════════════
# Check if the expected battery files exist
function bat_c() {
  [[ -f /sys/class/power_supply/BAT0/charge_full_design ]] &&
    [[ -f /sys/class/power_supply/BAT0/charge_now ]] &&
    [[ -f /sys/class/power_supply/BAT0/current_now ]] &&
    [[ -f /sys/class/power_supply/BAT0/status ]]
}
# Get current battery percentage, color it red if < 15%
function bat_p() {
  f=$(\cat /sys/class/power_supply/BAT0/charge_full_design 2>/dev/null)
  c=$(\cat /sys/class/power_supply/BAT0/charge_now 2>/dev/null)
  echo "$(bc -l <<<"$c/$f * 100")" | cut -c1-5
  #echo 10
}

# Get projected battery life time remaining
function bat_t() {
  c=$(\cat /sys/class/power_supply/BAT0/charge_now 2>/dev/null)
  i=$(\cat /sys/class/power_supply/BAT0/current_now 2>/dev/null)
  s=$(\cat /sys/class/power_supply/BAT0/status)
  if [[ "$s" == "Full" ]]; then
    echo '🔌'
  else
    echo "$(bc -l <<<"$c/$i")" | cut -c1-5
  fi
}

# Get the current battery status: discharging, charging, or full
function bat_s() {
  s=$(\cat /sys/class/power_supply/BAT0/status)
  if [[ "$s" == "Discharging" ]]; then
    echo -e "${ECHOR2}▾"
  elif [[ "$s" == "Charging" ]]; then
    echo -e "${ECHOG}▴"
  elif [[ "$s" == "Full" ]]; then
    echo -e "${ECHOG}▫"
  fi
}

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
# Ensure this runs before every command.
trap 'preexec' DEBUG
