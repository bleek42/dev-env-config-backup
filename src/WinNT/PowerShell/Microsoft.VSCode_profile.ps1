### * Import must-have PowerShell modules 1st (PSReadLine, PSFzf, PowerType, etc.)
Import-Module -Name PowerType -MinimumVersion 0.1.0
Enable-PowerType

Import-Module -Name gsudoModule
Import-Module -Name PSReadLine -MinimumVersion 2.4.0 -Global
Import-Module -Name PSFzf -MinimumVersion 2.5.26 -Global

## * GSudo, SSH, Git Module to exec in admin, easily manage SSH keys, etc.
# Import-Module -Name Sudo
Import-Module -Name Posh-SSH -Global
Import-Module -Name posh-git -Global

### ? Import the Chocolatey Profile that contains the necessary code to enable
## * tab-completions to function for `choco`.
## * Be aware that if you are missing these lines from your profile, tab completion
## * for `choco` will not function.
## * See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path $ChocolateyProfile) {
	Import-Module "$ChocolateyProfile"
}

<### * Set Some Option for PSReadLine to show the history of our typed commands ###>
if ($env:TERM_PROGRAM -ne "vscode") {
	Set-PSReadLineOption -PredictionSource HistoryAndPlugin
}
else {
	Set-PSReadLineOption -PredictionSource History
}

Set-PSReadLineOption  -BellStyle Visual -PredictionViewStyle InlineView `
	-ContinuationPrompt "󰅂 " -ShowToolTips:$true `
	-HistorySaveStyle SaveIncrementally -HistoryNoDuplicates:$true `
	-HistorySearchCursorMovesToEnd:$true -HistorySearchCaseSensitive:$false


Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

## * Override default tab completion with PSFzf
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

Set-PsFzfOption -AltCCommand { Invoke-FuzzyHistory }
Set-PsFzfOption -TabExpansion -GitKeyBindings

## * Enable Fuzzy Search with PSFzf/Readline
Set-PsFzfOption -EnableAliasFuzzyHistory -EnableAliasFuzzyEdit -EnableAliasFuzzyKillProcess
Set-PsFzfOption -EnableAliasFuzzyGitStatus -EnableAliasFuzzyScoop

## * Override PSReadLine's history search
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'


## * VcRedist, PSCX (PowerShell Community Extensions), PSWindowsUpdate & other Windows tools for Visual C++ distributions,
## * managing dir/file permissions, users, permissions, execution policies + more
# Import-Module -Name Pscx -Scope Global
# Import-Module -Name VcRedist
# Import-Module "$env:ProgramData\scoop\apps\vcpkg\current\scripts\posh-vcpkg"

### * Import Terminal-Icons into
Import-Module -Name Terminal-Icons

Import-Module -Name PSScriptAnalyzer -Scope Global

# if (Get-Command -Name direnv -ErrorAction SilentlyContinue) {


# 	(direnv hook pwsh && direnv allow (Join-Path "$env:USERPROFILE" "\.envrc")) | Invoke-Expression

# }


if (Get-Command zoxide -ErrorAction SilentlyContinue) {
	Invoke-Expression (& { (zoxide init powershell --hook pwd --cmd zd | Out-String) })
}

### * ALIASES / FUNCTIONS
$scriptAliases = "$env:USERPROFILE\Documents\PowerShell\Scripts\Aliases.ps1"
if (Test-Path $scriptAliases) {

	. $scriptAliases

}

$CompletionScriptsDir = "$env:USERPROFILE\Documents\PowerShell\Scripts\Completions"
Get-ChildItem -Path $CompletionScriptsDir | ForEach-Object {

	. $_

}

## ? <## check to see if powershell is interactive, in alacritty or windows terminal ##>
if ($Host.Name -eq "ConsoleHost" -and (Get-Command fastfetch.exe -ErrorAction SilentlyContinue)) {

	fastfetch.exe

}

if ($env:TERM_PROGRAM -eq "vscode" -and (Get-Command oh-my-posh.exe -ErrorAction SilentlyContinue)) {

	$omptheme = "fish.omp.json"
	oh-my-posh.exe init pwsh --config (Join-Path "$env:POSH_THEMES_PATH" "$omptheme") | Invoke-Expression

}
elseif (Get-Command oh-my-posh.exe -ErrorAction SilentlyContinue) {

	$omptheme = "slimfat.omp.json"
	oh-my-posh.exe init pwsh --config (Join-Path "$env:POSH_THEMES_PATH" "$omptheme") | Invoke-Expression

}
else {

	Write-Host "oh-my-posh.exe not found..."

}

# $hasInterntAccess = Test-NetConnection -ErrorAction SilentlyContinue | Select-Object -Property PingSucceeded
# if ($hasInterntAccess) {

# 	#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
# 	Import-Module -Name Microsoft.WinGet.CommandNotFound -Global
# 	#f45873b3-b655-43a6-b217-97c00aa0db58

# }
