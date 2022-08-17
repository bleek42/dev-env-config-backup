#!/bin/bash

# if not running in interactive mode, load nothing & return
case $- in
*i*) ;;

*) return ;;
esac

# # Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# Don't store lines starting with a space in the history, or lines identical to the one before.
# ═══════════════════════════════════════
# HISTORY MANAGEMENT
# ═══════════════════════════════════════
# append to the history file, don't overwrite it
shopt -s histappend
# set length of command history rememebered
# make sure this isn't overrided by the OS (Ubuntu does this)
unset HISTFILESIZE
unset HISTSIZE
HISTSIZE=1000
HISTFILESIZE=1000
HISTCONTROL='ignorespace:ignoredups'
# Store timestamps in history file, and display them as 'Mon 2020-06-01 23:42:05'.
HISTTIMEFORMAT='%a %Y-%m-%d %H:%M:%S'

# If this shell is connected to a tty, disable software flow control.
# In other words, prevent accidentally hitting ^S from freezing the entire terminal.
[ -t 0 ] && stty -ixon 2>/dev/null

if command -v bat >/dev/null 2>&1; then
  alias cat=bat
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/bash lesspipe)"

# Modify path here:
export MASTERPATH=PATH

# Editor for git and other commands
export VISUAL=micro
export EDITOR=code

# make cd ignore case and small typos
shopt -s cdspell

# ═══════════════════════════════════════
# COLORS FOR COMMON COMMANDS
# ═══════════════════════════════════════

export force_color_prompt=yes

alias diff="colordiff"

# Give less options to man
export MANPAGER='less -s -M +Gg'

# ═══════════════════════════════════════
# LS ALIASES
# ═══════════════════════════════════════
# Show full paths of files in current directory
alias paths='ls -d $PWD/*'
# Show hidden files too
alias la='ls -A'
# Show file size, permissions, date, etc.
alias ll='ls -lvhs'
alias lll='ls -alvhs'
# Show only directories
alias l.='ls -d */'
# sort files by size, showing biggest at the bottom
alias sizesort="ls -alSr | tr -s ' ' | cut -d ' ' -f 5,9"
# typo correction
alias l='ls'
alias sl='ls'
alias l='ls'
alias s='ls'

# For fun: the ls ligature
alias ʪ='ls'

# Custom colors for ls
LS_COLORS=$LS_COLORS:'di=0;95:ln=0;35:ex=0;93'

# ═══════════════════════════════════════
# FILE MANAGEMENT ALIASES
# ═══════════════════════════════════════
# don't clobber files or ruin the OS
alias cp='cp -i'
alias mv='mv -i'
alias rm="rm -I --preserve-root"
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias mntwin='sudo mount -t ntfs /dev/nvme0n1p3 /mnt/'

# make directory and any parent directories needed
alias mkdir='mkdir -p'

# easier directory jumping
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# typo fix
alias cd..='cd ..'

# ═══════════════════════════════════════
# RELOAD .BASHRC
# ═══════════════════════════════════════
alias sb='source ~/.bashrc'

# # ═══════════════════════════════════════
# # PACKAGE MANAGEMENT
# # ═══════════════════════════════════════
# # stop typing so much when package managing
# alias install='sudo dnf install'
# alias remove='sudo dnf remove'
# alias update='sudo dnf update'
# alias upgrade='sudo dnf update && sudo apt-get upgrade'

# ═══════════════════════════════════════
# OS POWER MANAGEMENT
# ═══════════════════════════════════════
# easy shutdown/reboot
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"

# ═══════════════════════════════════════
# DISK UTILS
# ═══════════════════════════════════════
# make common commands easier to read for humans
alias df="df -Tha --total"
alias du="du -ach | sort -h"
alias free="free -mth"

# ═══════════════════════════════════════
# TIME AND DATE
# ═══════════════════════════════════════
# easy time and date printing
alias now='date +"%T"'
alias dt='date "+%F %T"'

# ═══════════════════════════════════════
# PRETTY THINGS
# ═══════════════════════════════════════
# custom cmatrix
alias cmatrix="cmatrix -bC yellow"

# ═══════════════════════════════════════
# PROCESS MANAGEMENT
# ═══════════════════════════════════════
# search processes (find PID easily)
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
# show all processes
alias psf="ps auxfww"
#given a PID, intercept the stdout and stderr
alias intercept="sudo strace -ff -e trace=write -e write=1,2 -p"
# kill a given process by name
function pskill() {
  pgrep ax | grep "$1" | grep -v grep | awk '{ print $1 }' | xargs kill
}

# ═══════════════════════════════════════
# NETWORKS AND FILES
# ═══════════════════════════════════════
# make wget continue downloads if inturrupted
alias wget="wget -c"

# show current IP address
ipf() {
  pip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -v ^$)
  echo "$pip" | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
}
alias ip=ipf

# super convenient HTTP server
# with python 3, it will be "python3 -m http.server"
alias http="python3 -m http.server"

# Show active http connections
alias ports='echo -e "\n${ECHOR}Open connections :$NC "; netstat -pan --inet;'

# # ═══════════════════════════════════════
# # SSH ALIASES
# # ═══════════════════════════════════════
# # So as to not expose my ip addresses of interest on GitHub
# if [[ -f ~/.ssh_aliases ]]; then source ~/.ssh_aliases; fi

# ═══════════════════════════════════════
# BOOKMARKING SYSTEM
# ═══════════════════════════════════════
#use to get current directory with spaces escaped
alias qwd='printf "%q\n" "$(pwd)"'

# ═══════════════════════════════════════
# GIT & GITHUB
# ═══════════════════════════════════════
# checkout a branch and display the files we see
function checkoutfun() {
  git checkout $1
  ls
}
alias checkout=checkoutfun

alias branch='git branch'
alias push='git push'
alias pull='git pull'
alias commit='git commit'
alias add='git add'
alias status='git status'
alias stash='git stash'
alias init='git init'
alias clone='git clone'

# ═══════════════════════════════════════
# UNICODE BLOCK
# ═══════════════════════════════════════
# For fun selection of random unicode chars
unicode='×Ø÷±ÿłŊŋƜɨɷɸΔΣΦΨΩαβγδεζηθκλμνξπρστυφχψωᴀᴃᴕᴖ⚗🗺🌀🌁🌂🌃🌄🌅🌆🌇🌈🌉🌊🌋'
unicode+='🌌🌍🌎🌏🌐🌑🌒🌓🌔🌕🌖🌗🌘🌙🌚🌛🌜🌝🌞🌟🌠🌡🌢🌣🌤🌥🌦🌧🌨🌩🌪🌫🌬🌭🌮🌯🌰🌱🌲🌳🌴🌵🌶'
unicode+='🌷🌸🌹🌺🌻🌼🌽🌾🌿🍀🍁🍂🍃🍄🍅🍆🍇🍈🍉🍊🍋🍌🍍🍎🍏🍐🍑🍒🍓🍔🍕🍖🍗🍘🍙🍚🍛🍜🍝🍞🍟🍠'
unicode+='🍡🍢🍣🍤🍥🍦🍧🍨🍩🍪🍫🍬🍭🍮🍯🍰🍱🍲🍳🍴🍵🍶🍷🍸🍹🍺🍻🍼🍽🍾🍿🎀🎁🎂🎃🎄🎅🎆🎇🎈🎉🎊'
unicode+='🎋🎌🎍🎎🎏🎐🎑🎒🎓🎔🎕🎖🎗🎘🎙🎚🎛🎜🎝🎞🎟🎠🎡🎢🎣🎤🎥🎦🎧🎨🎩🎪🎫🎬🎭🎮🎯🎰🎱🎲🎳🎴'
unicode+='🎵🎶🎷🎸🎹🎺🎻🎼🎽🎾🎿🏀🏁🏂🏃🏄🏅🏆🏇🏈🏉🏊🏋🏌🏍🏎🏏🏐🏑🏒🏓🏔🏕🏖🏗🏘🏙🏚🏛🏜🏝🏞🏟'
unicode+='🏠🏡🏢🏣🏤🏥🏦🏧🏨🏩🏪🏫🏬🏭🏮🏯🏰🏱🏲🏳🏴🏵🏶🏷🏸🏹🏺🏻🏼🏽🏾🏿🐀🐁🐂🐃🐄🐅🐆🐇🐈🐉'
unicode+='🐊🐋🐌🐍🐎🐏🐐🐑🐒🐓🐔🐕🐖🐗🐘🐙🐚🐛🐜🐝🐞🐟🐠🐡🐢🐣🐤🐥🐦🐧🐨🐩🐪🐫🐬🐭🐮🐯🐰🐱🐲'
unicode+='🐳🐴🐵🐶🐷🐸🐹🐺🐻🐼🐽🐾🐿👀👁👂👃👄👅👆👇👈👉👊👋👌👍👎👏👐👑👒👓👔👕👖👗👘👙👚👛'
unicode+='👜👝👞👟👠👡👢👣👤👥👦👧👨👩👪👫👬👭👮👯👰👱👲👳👴👵👶👷👸👹👺👻👼👽👾👿💀💁💂💃💄💅'
unicode+='💆💇💈💉💊💋💌💍💎💏💐💑💒💓💔💕💖💗💘💙💚💛💜💝💞💟💠💡💢💣💤💥💦💧💨💩💪💫💬💭💮'
unicode+='💯💰💱💲💳💴💵💶💷💸💹💺💻💼💽💾💿📀📁📂📃📄📅📆📇📈📉📊📋📌📍📎📏📐📑📒📓📔📕📖📗'
unicode+='📘📙📚📛📜📝📞📟📠📡📢📣📤📥📦📧📨📩📪📫📬📭📮📯📰📱📲📳📴📵📶📷📸📹📺📻📼📽📾📿🔀🔁'
unicode+='🔂🔃🔄🔅🔆🔇🔈🔉🔊🔋🔌🔍🔎🔏🔐🔑🔒🔓🔔🔕🔖🔗🔘🔙🔚🔛🔜🔝🔞🔟🔠🔡🔢🔣🔤🔥🔦🔧🔨🔩🔪🔫'
unicode+='🔬🔭🔮🔯🔰🔱🔲🔳🔴🔵🔶🔷🔸🔹🔺🔻🔼🔽🔾🔿🕀🕁🕂🕃🕄🕅🕆🕇🕈🕉🕊🕋🕌🕍🕎🕏🕐🕑🕒🕓🕔🕕🕖🕗'
unicode+='🕘🕙🕚🕛🕜🕝🕞🕟🕠🕡🕢🕣🕤🕥🕦🕧🕨🕩🕪🕫🕬🕭🕮🕯🕰🕱🕲🕳🕴🕵🕶🕷🕸🕹🕺🕻🕼🕽🕾🕿🖀🖁🖂🖃'
unicode+='🖄🖅🖆🖇🖈🖉🖊🖋🖌🖍🖎🖏🖐🖑🖒🖓🖔🖕🖖🖗🖘🖙🖚🖛🖜🖝🖞🖟🖠🖡🖢🖣🖤🖥🖦🖧🖨🖩🖪🖫🖬🖭🖮🖯🖰🖱🖲'
unicode+='🖳🖴🖵🖶🖷🖸🖹🖺🖻🖼🖽🖾🖿🗀🗁🗂🗃🗄🗅🗆🗇🗈🗉🗊🗋🗌🗍🗎🗏🗐🗑🗒🗓🗔🗕🗖🗗🗘🗙🗚🗛🗜🗝🗞🗟'
unicode+='🗠🗡🗢🗣🗤🗥🗦🗧🗨🗩🗪🗫🗬🗭🗮🗯🗰🗱🗲🗳🗴🗵🗶🗷🗸🗹🗺🗻🗼🗽🗾🗿🗡🖱🖲🖼🗂🏵🏷🐿👁'
unicode+='📽🕉🕊🕯🕰🕳🕴🏕🏖🏗🏘🏙🏚🏛🏜🏝🏞🏟🙐🙑🙒🙓🙔🙕🙖🙗🙘🙙🙚🙛🙜🙝🙞🙟🙠🙡🙢🙣🙤🙥🙦🙧'
unicode+='🙨🙩🙪🙫🙬🙭🙮🙯🙰🙱🙲🙳🙴🙵🙶🙷🙸🙹🙺🙻🙼🙽🙾🙿🏳🕵🗃🗄🗑🗒🗓🗜🗝🗞ᴗᴟᴤᴥᴦᴧᴨᴩᴪ•‣…‰‱※D‼‽⁁'
unicode+='⁂⁃⁄⁅⁆⁇⁈⁉⁎⁏⁐⁑⁰ⁱ⁴⁵⁶⁷⁸⁹⁺⁻⁼⁽⁾ⁿ₀₁₂₃₄₅₆₇₈₉₊₋₌₍₎ℂ℃ℇ℉ℊℋℌℍℎℏℐℑℒℓℕ№ℚℛℜℝ℣ℤΩKÅℬℯℰℱ'
unicode+='ℳ⅋ⅎ⅐⅑⅒⅓⅔⅕⅖⅗⅘⅙⅚⅛⅜⅝⅞⅟ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩⅰⅱⅲⅳⅴⅵⅶⅷⅸⅹ↔↕↝↠↣↦↬↭↮↯'
unicode+='↹↺↻⇎⇏⇒⇛⇝⇢⇶∀∁∂∃∄∅∆∇S∈∉∎∏∐∑−∓∔∕∖∗∘∙√∛∜∝∞∟∠∡∢∣∤∥∦∧∨∩∪∫∬∭∮∯∰∱'
unicode+='∲∳∴∵∶∷∸∹∺∻∼∽∾∿≀≁≂≃≄≅≆≇≈≉≊≋≌≍≎≏≐≑≒≓≔≕≖≗≘≙≚≛≜≝≞≟≠≡≢≣≤≥≦'
unicode+='≧≨≩≪≫≬≭≮≯≰≱≲≳≴≵≶≷≸≹≺≻≼≽≾≿⊀⊁⊂⊃⊄⊅⊆⊇⊈⊉⊊⊋⊌⊍⊎⊏⊐⊑⊒⊓⊔⊕⊖⊗⊘'
unicode+='⊙⊚⊛⊜⊝⊞⊟⊠⊡⊰⊱⊲⊳⊴⊵⊶⊷⊸⊹⊾⊿⋀⋁⋂⋃⋄⋅⋆⋇⋈⋉⋊⋋⋌⋍⋎⋏⋐⋑⋒⋓⋔⋕⋖⋗⋘⋙⋚'
unicode+='⋛⋜⋝⋞⋟⋠⋡⋢⋣⋤⋥⋦⋧⋨⋩⋪⋫⋬⋭⋮⋯⋰⋱⌀⌁⌂⌃⌄⌅⌆⌇⌑⌐⌒⌓⌔⌕⌖⌗⌘⌙⌚⌛⌤⌥⌦⌧⌨'
unicode+='⌫⌬⏏⏚⏛⏰⏱⏲⏳␣╱╲╳▀▁▂▃▄▅▆▇█▉▊▋▌▍▎▏░▒▓▖▗▘▙▚▛▜▝▞▟■□▢▣▤▥▦▧▨'
unicode+='▩▪▫▬▭▮▯▰▱▲△▴▵▶▷▸▹►▻▼▽▾▿◀◁◂◃◄◅◆◇◈◉◊○◌◍◎●◐◑◒◓◔◕◖◗◘◙◚◛◜◝◞◟◠◡'
unicode+='◢◣◤◥◦◧◨◩◪◫◬◭◮◯◰◱◲◳◴◵◶◷◸◹◺◻◼◽◾◿☀☁☂☃☄★☆☇☈☉☊☋☌☍☎☏☐☑'
unicode+='☒☓☔☕☖☗☘☙☚☛☜☝☞☟☠☡☢☣☤☥☦☧☨☩☪☫☬☭☮☯☰☱☲☳☴☵☶☷☸☼☽☾☿♀♁♂♃♄♅'
unicode+='♆♇♔♕♖♗♘♙♚♛♜♝♞♟♠♡♢♣♤♥♦♧♨♩♪♫♬♭♮♯♲♳♴♵♶♷♸♹♺♻♼♽♾⚀⚁⚂⚃⚄⚅'
unicode+='⚐⚑⚒⚓⚔⚕⚖⚗⚘⚙⚚⚛⚜⚝⚞⚟⚠⚡⚢⚣⚤⚥⚦⚧⚨⚩⚪⚫⚬⚭⚮⚯⚰⚱⚲⚳⚴⚵⚶⚷⚸⚹⚺⚻⚼⛀⛁⛂'
unicode+='⛃⛢⛤⛥⛦⛧⛨⛩⛪⛫⛬⛭⛮⛯⛰⛱⛲⛴⛵⛶⛷⛸⛹⛺⛻⛼⛽⛾⛿✁✂✃✄✅✆✇✈✉✊✋✌✍✎✏'
unicode+='✐✑✒✓✔✕✖✗✘✙✚✛✜✝✞✟✠✡✢✣✤✥✦✧✨✩✪✫✬✭✮✯✰✱✲✳✴✵✶✷✸✹✺✻✼✽✾✿❀'
unicode+='❁❂❃❄❅❆❇❈❉❊❋❌❍❎❏❐❑❒❓❔❕❖❗❟❠❡❢❣❤❥❦❧⟴⟿⤀⤁⤐⤑⤔⤕⤖⤗⤘⤨⤩⤪⤫⤬'
unicode+='⤭⤮⤯⤰⤱⤲⤼⤽⤾⤿⥀⥁⥂⥃⥄⥅⥆⥇⥈⥉⥊⥋⥌⥍⥎⥏⥐⥑⬒⬓⬔⬕⬖⬗⬘⬙⬚⸮〃〄﴾﴿︽︾﹁﹂﹃﹄﹅'
unicode+='﹆｟｠⌬⌬⌬⌬◉∰⁂⛃⛁◉∰⁂⛃⛁◉∰⁂⛃⛁◉∰⁂⛃⛁⛇⛓⚛⛇⛓⚛⛇⛓⚛⛇⛓⚛'

# Length of the previous string
unicodelen=${#unicode}

# Get a random character from the previous string
function getunicodec() {
  r="$RANDOM"
  from=$((r % unicodelen))
  echo "${unicode:from:1}"
}

alias unicode=getunicodec
