#!/usr/bin/env bash

ext_list=(
    "andrejunges.Handlebars"
    "AndriiSabinich.plainly"
    "Angular.ng-template"
    "aperlman.mojo-theme"
    "apollographql.apollo-midnight-c"olor-theme
    "apollographql.vscode-apollo"
    "asilva.win95"
    "beastdestroyer.firefox-quantum-"themes
    "blake-mealey.generate-wt-scheme"
    "bmuskalla.vscode-tldr"
    "brenix.hacker-theme"
    "christian-kohler.npm-intellisen"se
    "christian-kohler.path-intellise"nse
    "cweijan.vscode-mysql-client2"
    "cweijan.vscode-office"
    "DanielSanMedium.dscodegpt"
    "DavidAnson.vscode-markdownlint"
    "dbaeumer.vscode-eslint"
    "ddh4r4m.night-hacker-dark-theme"
    "DeepInThought.vscode-shell-snip"pets
    "doggy8088.netcore-editorconfigg"enerator
    "donjayamanne.jquerysnippets"
    "dotiful.dotfiles-syntax-highlig"hting
    "dsznajder.es7-react-js-snippets"
    "eamodio.gitlens"
    "EditorConfig.EditorConfig"
    "emmanuelbeziat.vscode-great-ico"ns
    "esbenp.prettier-vscode"
    "EstevamSouza.nestjs-snippets-fo"r-vscode
    "fiazluthfi.bulma-snippets"
    "firefox-devtools.vscode-firefox"-debug
    "formulahendry.code-runner"
    "foxundermoon.shell-format"
    "GitHub.copilot"
    "GitHub.copilot-chat"
    "glenn2223.live-sass"
    "Greenbyte.handlebars-preview"
    "hasiburr.dark-hacker-theme-by-h"asibur-r
    "humao.rest-client"
    "inferrinizzard.prettier-sql-vsc"ode
    "ionutvmi.reg"
    "IronGeek.vscode-env"
    "ItsMeAdarsh.vsc-handlebars-ext"
    "jakebathman.mysql-syntax"
    "jeff-hykin.polacode-2019"
    "jordanjanzen.office-ui-fabric-r"eact-snippets
    "justinmahar.react-bootstrap-sni"ppets
    "kakumei.ts-debug"
    "kisstkondoros.vscode-codemetric"s
    "kumar-harsh.graphql-for-vscode"
    "kuscamara.hyper-dark-material"
    "ldlework.eslintlens"
    "leveluptutorials.react-apollo-s"nippets
    "lkrms.inifmt"
    "Luxcium.pop-n-lock-theme-vscode"
    "mads-hartmann.bash-ide-vscode"
    "magson.dark-hacker-theme"
    "mattpocock.ts-error-translator"
    "meronz.manpages"
    "mrmlnc.vscode-scss"
    "ms-azuretools.vscode-docker"
    "ms-dotnettools.vscode-dotnet-ru"ntime
    "ms-edgedevtools.vscode-edge-dev"tools
    "ms-vscode-remote.remote-contain"ers
    "ms-vscode-remote.remote-ssh-edi"t
    "ms-vscode-remote.remote-wsl"
    "ms-vscode.powershell"
    "ms-vscode.vscode-typescript-nex"t
    "ms-vsliveshare.vsliveshare"
    "msjsdiag.vscode-react-native"
    "mxsdev.typescript-explorer"
    "nespinozacr.mysql-autocomplete"
    "Noctarya.terminals"
    "nrwl.angular-console"
    "ParthR2031.colorful-comments"
    "Perkovec.emoji"
    "PKief.material-icon-theme"
    "pnp.polacode"
    "pombadev.pbbs"
    "Remisa.shellman"
    "ritwickdey.LiveServer"
    "roerohan.mongo-snippets-for-nod"e-js
    "rogalmic.bash-debug"
    "rogalmic.zsh-debug"
    "rpinski.shebang-snippets"
    "rvest.vs-code-prettier-eslint"
    "ShenHongFei.xshell"
    "silofy.hackthebox"
    "skacekachna.win-opacity"
    "SolarLiner.linux-themes"
    "steveblue.theme-firefox-devtool"s-italic
    "styled-components.vscode-styled"-components
    "syler.sass-indented"
    "thekalinga.bootstrap4-vscode"
    "timonwong.shellcheck"
    "Tyriar.windows-terminal"
    "usernamehw.errorlens"
    "VisualStudioExptTeam.intellicod"e-api-usage-examples
    "VisualStudioExptTeam.vscodeinte"llicode
    "VisualStudioExptTeam.vscodeinte"llicode-completions
    "VisualStudioExptTeam.vscodeinte"llicode-insiders
    "vscode-icons-team.vscode-icons"
    "WakaTime.vscode-wakatime"
    "WallabyJs.quokka-vscode"
    "wassimdev.windows-nt-vscode-the"me
    "xabikos.JavaScriptSnippets"
    "ypresto.vscode-intelli-refactor"
    "Zaczero.bootstrap-v4-snippets"
    "zgm.vscode-fish"
    "Zignd.html-css-class-completion"
)

case "${VISUAL}" in
"codium")
    for ext in "${ext_list[@]}"; do
        codium --install-extension "${ext}" | xargs -L -o {}
    done
    unset ext
    ;;
"codium-insiders")
    for ext in "${ext_list[@]}"; do
        codium-insiders --install-extension "${ext}" | xargs -L -o {}
    done
    unset ext
    ;;
"code-insiders")
    for ext in "${ext_list[@]}"; do
        code-insiders --install-extension "${ext}" | xargs -L -o {}
    done
    unset ext
    ;;
*)
    for ext in "${ext_list[@]}"; do
        code --install-extension "${ext}" | xargs -L -o {}
    done
    unset ext
    ;;
esac
