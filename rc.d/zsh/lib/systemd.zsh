#!/usr/bin/env zsh

typeset -ga user_commands sudo_commands power_commands
user_commands=(
  cat
  get-default
  help
  list-dependencies
  list-jobs
  list-units
  list-unit-files
  list-sockets
  list-timers
  is-active
  is-enable
  is-failed
  is-system-running
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
    alias -g sc-$c="systemctl $c"
done

for c in $sudo_commands; do
    alias -g sc-$c="sudo systemctl $c"
done

for c in $user_commands; do
    alias -g scu-$c="systemctl --user $c"
done

for c in $sudo_commands; do
    alias -g scu-$c="systemctl --user $c"
done

unset c

alias -g sc-enable-now="sc-enable --now"
alias -g sc-disable-now="sc-disable --now"
alias -g sc-mask-now="sc-mask --now"

alias -g scu-enable-now="scu-enable --now"
alias -g scu-disable-now="scu-disable --now"
alias -g scu-mask-now="scu-mask --now"

## * --failed commands
alias -g scu-failed='systemctl --user --failed'
alias -g sc-failed='systemctl --failed'

###?##############################################################################################
## ? systemd_prompt_info: display information about systemd units in the shell prompt.          ##
###?##############################################################################################
## * This function takes a variable number of arguments, each of which should be a
## * systemd unit name. It prints out a string indicating the status of each unit.
## * The string is formatted according to the following variables:
###*##############################################################################################
## !  ZSH_THEME_SYSTEMD_PROMPT_PREFIX
## !  ZSH_THEME_SYSTEMD_PROMPT_SUFFIX
## !  ZSH_THEME_SYSTEMD_PROMPT_ACTIVE
## !  ZSH_THEME_SYSTEMD_PROMPT_NOTACTIVE
###*##############################################################################################
## * If $ZSH_THEME_SYSTEMD_PROMPT_CAPS is non-empty, the unit name is uppercased
## * before being printed. The "%/" pattern is escaped by replacing it with "%%".
function systemd_prompt_info {
  local unit
  for unit in "$@"; do
    echo -n "$ZSH_THEME_SYSTEMD_PROMPT_PREFIX"

    if [[ -n "$ZSH_THEME_SYSTEMD_PROMPT_CAPS" ]]; then
      echo -n "${(U)unit:gs/%/%%}:"
    else
      echo -n "${unit:gs/%/%%}:"
    fi

    if systemctl is-active "$unit" &>/dev/null; then
      echo -n "$ZSH_THEME_SYSTEMD_PROMPT_ACTIVE"
    elif systemctl --user is-active "$unit" &>/dev/null; then
      echo -n "$ZSH_THEME_SYSTEMD_PROMPT_ACTIVE"
    else
      echo -n "$ZSH_THEME_SYSTEMD_PROMPT_NOTACTIVE"
    fi

    echo -n "$ZSH_THEME_SYSTEMD_PROMPT_SUFFIX"
  done
}
