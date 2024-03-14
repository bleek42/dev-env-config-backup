#!/usr/bin/env zsh

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

alias ping='ping -c 5'
alias clr='clear; echo Currently logged in on $TTY, as $USERNAME in directory $PWD.'
# shellcheck disable=SC2154
alias printpath='print -l $path'
alias mkdir='mkdir -pv'
# get top process eating memory
alias psmem='ps -e -orss=,args= | sort -b -k1 -nr'
alias psmem10='ps -e -orss=,args= | sort -b -k1 -nr | head -n 10'
# get top process eating cpu if not work try execute : export LC_ALL='C'
alias pscpu='ps -e -o pcpu,cpu,nice,state,cputime,args | sort -k1,1n -nr'
alias pscpu10='ps -e -o pcpu,cpu,nice,state,cputime,args | sort -k1,1n -nr | head -n 10'
# top10 of the history
alias hist10='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

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

# if command -v fdfind >/dev/null 2>&1; then
# alias fd='fdfind --hidden'
# fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh --hook prompt --cmd zd)"
fi

if command -v ag >/dev/null 2>&1; then
  # alias ag='ag --hidden --ignore ".git" -i -g'
  alias ags='ag --hidden --smart-case -g'
fi

if command -v rg >/dev/null 2>&1; then
  alias rgh='rg -i --pretty --hidden --no-ignore-vcs'
fi

if command -v eza >/dev/null 2>&1; then
  alias ls='eza -r -h -M -x --smart-group --group-directories-first --git-ignore'
  alias la='eza -r -a -h --smart-group --group-directories-first'
  alias ll='eza -r -l -M --smart-group --group-directories-first'
  alias lt='eza -T -a -x -L 6 --git-ignore'
  alias ld='eza -r -a -M -@ --smart-group --group-directories-first'
elif command -v exa >/dev/null 2>&1; then
  alias ls='exa --color-scale --icons'
  alias la='exa -al --color-scale --icons'
  alias ll='exa -al --color-scale --icons'
  alias lt='exa -lT --color-scale --icons'
  alias ld='exa -al --color-scale --icons'
else
  alias ls='ls --color=auto'
  alias ll='ls -l'
  alias la='ls -A'
  alias l='ls -CF'
fi

if command -v neovide.exe >/dev/null 2>&1; then
  alias neovide='neovide.exe --wsl --log'
fi
# make var that checks what os is running script

if command -v dpkg >/dev/null 2>&1; then
  # shellcheck disable=SC1091
  # Use aptitude or apt if installed, fallback is apt-get
  # You can just set apt_pref='apt-get' to override it.

  if [[ -z $apt_pref || -z $apt_upgr ]]; then
    if [[ -e $commands[aptitude] ]]; then
      apt_pref='aptitude'
      apt_upgr='safe-upgrade'
    elif [[ -e $commands[apt] ]]; then
      apt_pref='apt'
      apt_upgr='upgrade'
    else
      apt_pref='apt-get'
      apt_upgr='upgrade'
    fi
  fi

  # ! Use sudo by default if it's installed
  if [[ -e $commands[sudo] ]]; then
    use_sudo=1
  fi

  if command -v apt >/dev/null 2>&1; then
    # * Aliases ###################################################################
    # * These are for more obscure uses of apt-get and aptitude that aren't covered
    # * below.
    alias age='apt-get'
    alias api='aptitude'

    # * Some self-explanatory aliases
    alias acs="apt-cache search"
    alias aps='aptitude search'
    alias as="aptitude -F '* %p -> %d \n(%v/%V)' --no-gui --disable-columns search"

    # ? apt-file
    alias afs='apt-file search --regexp'

    # ! These are apt-get only
    alias asrc='apt-get source'
    alias app='apt-cache policy'

    # superuser operations ######################################################
    if [[ $use_sudo -eq 1 ]]; then
      # commands using sudo #######
      alias aac="sudo $apt_pref autoclean"
      alias abd="sudo $apt_pref build-dep"
      alias ac="sudo $apt_pref clean"
      alias ad="sudo $apt_pref update"
      alias adg="sudo $apt_pref update && sudo $apt_pref $apt_upgr"
      alias adu="sudo $apt_pref update && sudo $apt_pref dist-upgrade"
      alias afu="sudo apt-file update"
      alias au="sudo $apt_pref $apt_upgr"
      alias ai="sudo $apt_pref install"
      # Install all packages given on the command line while using only the first word of each line:
      # acse ... | ail

      alias ail="sed -e 's/  */ /g' -e 's/ *//' | cut -s -d ' ' -f 1 | xargs sudo $apt_pref install"
      alias ap="sudo $apt_pref purge"
      alias aar="sudo $apt_pref autoremove"

      # apt-get only
      alias ads="sudo apt-get dselect-upgrade"

      # apt only
      alias alu="sudo apt update && apt list -u && sudo apt upgrade"

      # Install all .deb files in the current directory.
      # Warning: you will need to put the glob in single quotes if you use:
      # glob_subst
      alias dia="sudo dpkg -i ./*.deb"
      alias di="sudo dpkg -i"

      # Remove ALL kernel images and headers EXCEPT the one in use
      alias kclean='sudo aptitude remove -P "?and(~i~nlinux-(ima|hea) ?not(~n$(uname -r)))"'

    # commands using su #########
    else
      alias aac="su -ls '$apt_pref autoclean' root"
      function abd() {
        cmd="su -lc '$apt_pref build-dep $@' root"
        print "$cmd"
        eval "$cmd"
      }
      alias ac="su -ls '$apt_pref clean' root"
      alias ad="su -lc '$apt_pref update' root"
      alias adg="su -lc '$apt_pref update && aptitude $apt_upgr' root"
      alias adu="su -lc '$apt_pref update && aptitude dist-upgrade' root"
      alias afu="su -lc '$apt-file update'"
      alias au="su -lc '$apt_pref $apt_upgr' root"
      function ai() {
        cmd="su -lc '$apt_pref install $@' root"
        print "$cmd"
        eval "$cmd"
      }
      function ap() {
        cmd="su -lc '$apt_pref purge $@' root"
        print "$cmd"
        eval "$cmd"
      }
      function aar() {
        cmd="su -lc '$apt_pref autoremove $@' root"
        print "$cmd"
        eval "$cmd"
      }
      # Install all .deb files in the current directory
      # Assumes glob_subst is off
      alias dia='su -lc "dpkg -i ./*.deb" root'
      alias di='su -lc "dpkg -i" root'

      # Remove ALL kernel images and headers EXCEPT the one in use
      alias kclean='su -lc "aptitude remove -P \"?and(~i~nlinux-(ima|hea) ?not(~n$(uname -r)))\"" root'
    fi
    # * Completion ################################################################

    ### ? Registers a compdef for $1 that calls $apt_pref with the commands $2
    ### ? To do that it creates a new completion function called _apt_pref_$2

    function apt_pref_compdef() {
      local f fb
      f="_apt_pref_${2}"

      eval "function ${f}() {
          shift words;
          service=\"\$apt_pref\";
          words=(\"\$apt_pref\" '$2' \$words);
          ((CURRENT++))
          test \"\${apt_pref}\" = 'aptitude' && _aptitude || _apt
      }"

      compdef "$f" "$1"
    }

    apt_pref_compdef aac "autoclean"
    apt_pref_compdef abd "build-dep"
    apt_pref_compdef ac "clean"
    apt_pref_compdef ad "update"
    apt_pref_compdef afu "update"
    apt_pref_compdef au "$apt_upgr"
    apt_pref_compdef ai "install"
    apt_pref_compdef ail "install"
    apt_pref_compdef ap "purge"
    apt_pref_compdef aar "autoremove"
    apt_pref_compdef ads "dselect-upgrade"

    if command -v aptitude >/dev/null 2>&1; then
      ### * Misc, aptitude #####################################################################

      # ? print all installed packages
      alias allpkgs='aptitude search -F "%p" --disable-columns ~i'

      # Create a basic .deb package
      alias mydeb='time dpkg-buildpackage -rfakeroot -us -uc'

      # Functions #################################################################
      # create a simple script that can be used to 'duplicate' a system
      function apt-copy() {
        print '#!/bin/sh'"\n" >apt-copy.sh

        cmd='$apt_pref install'

        for p in '${(f)"$(aptitude search -F "%p" --disable-columns \~i)"}'; do
          cmd="${cmd} ${p}"
        done

        print $cmd "\n" >>apt-copy.sh

        chmod +x apt-copy.sh
      }

      # Prints apt history
      # Usage:
      #   apt-history install
      #   apt-history upgrade
      #   apt-history remove
      #   apt-history rollback
      #   apt-history list
      # Based On: https://linuxcommando.blogspot.com/2008/08/how-to-show-apt-log-history.html
      function apt-history() {
        case "$1" in
        install)
          zgrep --no-filename 'install ' $(ls -rt /var/log/dpkg*)
          ;;
        upgrade | remove)
          zgrep --no-filename $1 $(ls -rt /var/log/dpkg*)
          ;;
        rollback)
          zgrep --no-filename upgrade $(ls -rt /var/log/dpkg*) |
            grep "$2" -A10000000 |
            grep "$3" -B10000000 |
            awk '{print $4"="$5}'
          ;;
        list)
          zgrep --no-filename '' $(ls -rt /var/log/dpkg*)
          ;;
        *)
          echo "Parameters:"
          echo " install - Lists all packages that have been installed."
          echo " upgrade - Lists all packages that have been upgraded."
          echo " remove - Lists all packages that have been removed."
          echo " rollback - Lists rollback information."
          echo " list - Lists all contains of dpkg logs."
          ;;
        esac
      }

      # Kernel-package building shortcut
      function kerndeb() {
        # temporarily unset MAKEFLAGS ( '-j3' will fail )
        MAKEFLAGS=$(print - $MAKEFLAGS | perl -pe 's/-j\s*[\d]+//g')
        print '$MAKEFLAGS set to '"'$MAKEFLAGS'"
        appendage='-custom'        # this shows up in $(uname -r )
        revision=$(date +"%Y%m%d") # this shows up in the .deb file name

        make-kpkg clean

        time fakeroot make-kpkg --append-to-version "$appendage" --revision \
          "$revision" kernel_image kernel_headers
      }

      # List packages by size
      function apt-list-packages() {
        dpkg-query -W --showformat='${Installed-Size} ${Package} ${Status}\n' |
          grep -v deinstall |
          sort -n |
          awk '{print $1" "$2}'
      }

    fi
  fi

fi
