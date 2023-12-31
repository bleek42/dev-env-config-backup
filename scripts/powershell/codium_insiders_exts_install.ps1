#!/usr/bin/env pwsh

$extensions = @(
# $vsCodeExec = ($Env:LOCALAPPDATA) + "\VSCodium Insiders\Bin\codium-insiders"
"aperlman.mojo-theme"
"Angular.ng-template"
"asilva.win95"
"apollographql.apollo-midnight-color-theme"
"bmuskalla.vscode-tldr"
"blake-mealey.generate-wt-scheme"
"christian-kohler.npm-intellisense"
"brenix.hacker-theme"
"cweijan.vscode-mysql-client2"
"christian-kohler.path-intellisense"
"dbaeumer.vscode-eslint"
"cweijan.vscode-office"
"DeepInThought.vscode-shell-snippets"
"ddh4r4m.night-hacker-dark-theme"
"dotiful.dotfiles-syntax-highlighting"
"doggy8088.netcore-editorconfiggenerator"
"eamodio.gitlens"
"dsznajder.es7-react-js-snippets"
"esbenp.prettier-vscode"
"EditorConfig.EditorConfig"
"firefox-devtools.vscode-firefox-debug"
"fiazluthfi.bulma-snippets"
"foxundermoon.shell-format"
"formulahendry.code-runner"
"hasiburr.dark-hacker-theme-by-hasibur-r"
"glenn2223.live-sass"
"ionutvmi.reg"
"inferrinizzard.prettier-sql-vscode"
"jakebathman.mysql-syntax"
"IronGeek.vscode-env"
"jordanjanzen.office-ui-fabric-react-snippets"
"jeff-hykin.polacode-2019"
"ldlework.eslintlens"
"kumar-harsh.graphql-for-vscode"
"mads-hartmann.bash-ide-vscode"
"Luxcium.pop-n-lock-theme-vscode"
"meronz.manpages"
"magson.dark-hacker-theme"
"ms-azuretools.vscode-docker"
"mrmlnc.vscode-scss"
"ms-edgedevtools.vscode-edge-devtools"
"ms-dotnettools.vscode-dotnet-runtime"
"ms-vscode-remote.remote-ssh-edit"
"ms-vscode-remote.remote-containers"
"ms-vscode.powershell"
"ms-vscode-remote.remote-wsl"
"ms-vsliveshare.vsliveshare"
"ms-vscode.vscode-typescript-next"
"nespinozacr.mysql-autocomplete"
"msjsdiag.vscode-react-native"
"ParthR2031.colorful-comments"
"nrwl.angular-console"
"PKief.material-icon-theme"
"Perkovec.emoji"
"Remisa.shellman"
"pombadev.pbbs"
"rogalmic.bash-debug"
"ritwickdey.LiveServer"
"rvest.vs-code-prettier-eslint"
"rpinski.shebang-snippets"
"skacekachna.win-opacity"
"ShenHongFei.xshell"
"timonwong.shellcheck"
"syler.sass-indented"
"usernamehw.errorlens"
"Tyriar.windows-terminal"
"VisualStudioExptTeam.vscodeintellicode"
"VisualStudioExptTeam.intellicode-api-usage-examples"
"VisualStudioExptTeam.vscodeintellicode-insiders"
"VisualStudioExptTeam.vscodeintellicode-completions"
"WallabyJs.quokka-vscode"
"WakaTime.vscode-wakatime"
"xabikos.JavaScriptSnippets"
"wassimdev.windows-nt-vscode-theme"
"zgm.vscode-fish"
"ypresto.vscode-intelli-refactor"
"Zignd.html-css-class-completion"
# Open/Launch in Visual Studio cODIUM iNSIDERS
) | SORT

$extensions | ForEach-Object {
    try {
        Invoke-Expression "& codium-insiders.cmd --install-extension $_ --force"
        Write-Host # New-Line
    } catch {
        $_
        Exit(1)
    }
}

Exit(0)
