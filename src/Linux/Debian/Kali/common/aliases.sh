#!/usr/bin/env bash

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'

alias ip='ip --color=auto'
alias wget='wget --no-check-certificate'
alias dmesgf='dmesg --ctime --follow'

alias rsynccp='rsync -avz --progress -h'
alias rsyncmv='rsync -avz --progress -h --remove-source-files'
alias rsyncupd='rsync -avzu --progress -h'
alias rsyncnize='rsync -avzu --delete --progress -h'

alias tarz='tar --create --gzip --verbose --file'
alias taruz='tar --extract --gunzip --verbose --file'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

function retlog() {
    if [[ -z $1 ]];then
        echo '/var/log/nginx/access.log'
    else
        echo $1
  fi
}

alias ping='ping -c 5'
alias clr='clear; echo Currently logged in on $TTY, as $USERNAME in directory $PWD.'
alias path='print -l $path'
alias mkdir='mkdir -pv'
# get top process eating memory
alias psmem='ps -e -orss=,args= | sort -b -k1 -nr'
alias psmem10='ps -e -orss=,args= | sort -b -k1 -nr | head -n 10'
# get top process eating cpu if not work try execute : export LC_ALL='C'
alias pscpu='ps -e -o pcpu,cpu,nice,state,cputime,args | sort -k1,1n -nr'
alias pscpu10='ps -e -o pcpu,cpu,nice,state,cputime,args | sort -k1,1n -nr | head -n 10'
# top10 of the history
alias hist10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

function ip() {
  if [ -t 1 ]; then
    command ip -color "$@"
  else
    command ip "$@"
  fi
}

# directory LS
function dls() {
  print -l *(/)
}
function psgrep() {
  ps aux | grep "${1:-.}" | grep -v grep
}
# Kills any process that matches a regexp passed to it
function killit() {
  ps aux | grep -v "grep" | grep "$@" | awk '{print $2}' | xargs sudo kill
}

# list contents of directories in a tree-like format
if ! (( $+commands[tree] )); then
  function tree() {
    find $@ -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
  }
fi

# Sort connection state
function sortcons() {
  {
    LANG= ss -nat | awk 'NR > 1 {print $1}' \
    || LANG= netstat -nat | awk 'NR > 2 {print $6}'
  } | sort | uniq -c | sort -rn
}

# View all 80 Port Connections
function con80() {
  {
    LANG= ss -nat || LANG= netstat -nat
  } | grep -E ":80[^0-9]" | wc -l
}

# On the connected IP sorted by the number of connections
function sortconip() {
  {
    LANG= ss -ntu | awk 'NR > 1 {print $6}' \
    || LANG= netstat -ntu | awk 'NR > 2 {print $5}'
  } | cut -d: -f1 | sort | uniq -c | sort -n
}

# top20 of Find the number of requests on 80 port
function req20() {
  {
    LANG= ss -tn | awk '$4 ~ /:80$/ {print $5}' \
    || LANG= netstat -tn | awk '$4 ~ /:80$/ {print $5}'
  } | awk -F: '{print $1}' | sort | uniq -c | sort -nr | head -n 20
}

# top20 of Using tcpdump port 80 access to view
function http20() {
  sudo tcpdump -i eth0 -tnn dst port 80 -c 1000 | awk -F"." '{print $1"."$2"."$3"."$4}' | sort | uniq -c | sort -nr | head -n 20
}

# top20 of Find time_wait connection
function timewait20() {
  {
    LANG= ss -nat | awk 'NR > 1 && /TIME-WAIT/ {print $5}' \
    || LANG= netstat -nat | awk 'NR > 2 && /TIME_WAIT/ {print $5}'
  } | sort | uniq -c | sort -rn | head -n 20
}

# top20 of Find SYN connection
function syn20() {
  {
    LANG= ss -an | awk '/SYN/ {print $5}' \
    || LANG= netstat -an | awk '/SYN/ {print $5}'
  } | awk -F: '{print $1}' | sort | uniq -c | sort -nr | head -n20
}

# Printing process according to the port number
function port_pro() {
  LANG= ss -ntlp | awk "NR > 1 && /:${1:-}/ {print \$6}" | sed 's/.*pid=\([^,]*\).*/\1/' \
  || LANG= netstat -ntlp | awk "NR > 2 && /:${1:-}/ {print \$7}" | cut -d/ -f1
}

# top10 of gain access to the ip address
function accessip10() {
  awk '{counts[$(11)]+=1}; END {for(url in counts) print counts[url], url}' "$(retlog)"
}

# top20 of Most Visited file or page
function visitpage20() {
  awk '{print $11}' "$(retlog)" | sort | uniq -c | sort -nr | head -n 20
}

# top100 of Page lists the most time-consuming (more than 60 seconds) as well as the corresponding page number of occurrences
function consume100() {
  awk '($NF > 60 && $7~/\.php/){print $7}' "$(retlog)" | sort -n | uniq -c | sort -nr | head -n 100
  # if django website or other website make by no suffix language
  # awk '{print $7}' "$(retlog)" | sort -n | uniq -c | sort -nr | head -n 100
}

# Website traffic statistics (G)
function webtraffic() {
  awk "{sum+=$10} END {print sum/1024/1024/1024}" "$(retlog)"
}

# Statistical connections 404
function c404() {
  awk '($9 ~ /404/)' "$(retlog)" | awk '{print $9,$7}' | sort
}

# Statistical http status.
function httpstatus() {
  awk '{counts[$(9)]+=1}; END {for(code in counts) print code, counts[code]}' "$(retlog)"
}

# Delete 0 byte file
function d0() {
  find "${1:-.}" -type f -size 0 -exec rm -rf {} \;
}

# gather external ip address
function geteip() {
  curl -s -S -4 https://icanhazip.com

  # handle case when there is no IPv6 external IP, which shows error
  # curl: (7) Couldn't connect to server
  curl -s -S -6 https://icanhazip.com 2>/dev/null
  local ret=$?
  (( ret == 7 )) && print -P -u2 "%F{red}error: no IPv6 route to host%f"
  return $ret
}

# determine local IP address(es)
function getip() {
  if (( ${+commands[ip]} )); then
    ip addr | awk '/inet /{print $2}' | command grep -v 127.0.0.1
  else
    ifconfig | awk '/inet /{print $2}' | command grep -v 127.0.0.1
  fi
}

# Clear zombie processes
function clrz() {
  ps -eal | awk '{ if ($2 == "Z") {print $4}}' | kill -9
}

# Second concurrent
function conssec() {
  awk '{if($9~/200|30|404/)COUNT[$4]++}END{for( a in COUNT) print a,COUNT[a]}' "$(retlog)" | sort -k 2 -nr | head -n10
}

# systemctl aliases
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


if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --hook prompt --cmd zd)"
fi

if command -v ag >/dev/null 2>&1; then
    alias ag='ag --hidden --ignore ".git" -i -g'
    alias ags='ag --hidden --smart-case -g'
fi

if command -v rg >/dev/null 2>&1; then
    alias rg='rg -i --pretty --hidden --no-ignore-vcs'
fi

if command -v exa >/dev/null 2>&1; then
    alias ls='exa -a --color-scale --icons'
    alias la='exa -al --color-scale --icons'
    alias lt='exa -lT --color-scale --icons'
    alias ld='exa -al --links --color-scale --icons'
    alias ll='exa -al --links --color-scale --icons'
else
    alias ls='ls --color=auto'
    alias ll='ls -l'
    alias la='ls -A'
    alias l='ls -CF'
fi
