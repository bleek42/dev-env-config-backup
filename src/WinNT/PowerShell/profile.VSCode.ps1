### * Import must-have PowerShell modules 1st (PSReadLine, PSFzf, PowerType, etc.)
Import-Module -Name PSReadLine
Import-Module -Name PSFzf
Import-Module -Name PowerType

# * Import SSH, Git Module to more easily wield keys
Import-Module -Name posh-git
Import-Module -Name Posh-SSH

# * Set Some Option for PSReadLine to show the history of our typed commands
if($env:TERM_PROGRAM -ne "vscode") {
	Set-PSReadLineOption -PredictionViewStyle InlineView -PredictionSource Plugin
}
else {
	Set-PSReadLineOption -EditMode Windows -PredictionSource Plugin -PredictionViewStyle ListView
}

Set-PSReadLineOption -HistoryNoDuplicates:$True -HistorySearchCursorMovesToEnd:$True
Set-PSReadLineOption -BellStyle Visual -ShowToolTips

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
# * Override default tab completion
Set-PsFzfOption -TabExpansion -EnableFd   -EnableAliasFuzzyHistory -EnableAliasFuzzyEdit -EnableAliasFuzzyKillProcess
Set-PsFzfOption -EnableAliasFuzzyGitStatus -EnableAliasFuzzyScoop
# * Override PSReadLine's history search
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

### ? Import the Chocolatey Profile that contains the necessary code to enable
## * tab-completions to function for `choco`.
## * Be aware that if you are missing these lines from your profile, tab completion
## * for `choco` will not function.
## * See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
	Import-Module 'C:\ProgramData\scoop\apps\vcpkg\current\scripts\posh-vcpkg'
}

## * Import Carbon, PSWindowsUpdate, other Windows Tools for managing dir/file permissions, users, perms, execution policies + much more
Import-Module -Name Carbon
Import-Module -Name PSWindowsUpdate
Import-Module -Name VcRedist
### * Import Terminal-Icons into
Import-Module -Name Terminal-Icons

# Set-Alias grep -Value findstr

### * Initialize Oh My Posh with different prompts based on what terminal program powershell is running in.
# test this variable to see if it is a string
if ($env:WT_SESSION) {

	oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression

	if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
		fastfetch > $null
	}

}

else {

	oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\atomic.omp.json" | Invoke-Expression

}
### * ALIASES / FUNCTIONS

## * Utility Command that tells you where the absolute path of commandlets are
function Invoke-WhichCommand ($command) {
 Get-Command -Name $command -ErrorAction SilentlyContinue |
 Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

Set-Alias -Name which -Value Invoke-WhichCommand

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
	Invoke-Expression (& { (zoxide init powershell --hook pwd --cmd zd | Out-String) })
}

if (Get-Command lsd -ErrorAction SilentlyContinue) {
	function Invoke-LsdFiles {
		lsd -X --system-protected --header --reverse --group-dirs=first
	}

	Set-Alias -Name ls -Value Invoke-LsdFiles

	function Invoke-LsdInfo($dir) {
		lsd -l -F -X -1 --system-protected --reverse --group-dirs=first "$dir"
	}

	Set-Alias -name ll -Value Invoke-LsdInfo

	function Invoke-LsdHidden($dir) {
		lsd -A -X --system-protected --reverse --group-dirs=first --reverse "$dir"
	}

	Set-Alias -name la -Value Invoke-LsdHidden

	function Invoke-LsdDirs($dir) {
		lsd -A -d --system-protected -1 "$dir"
	}

	Set-Alias -name ld -Value Invoke-LsdDirs

	function Invoke-LsdTree($dir) {
		lsd -A -X --system-protected --depth=4 --tree "$dir"
	}

	Set-Alias -name lt -Value Invoke-LsdTree

	function Invoke-LsdSort($dir) {
		lsd -A -l -r --sizesort --reverse --group-dirs=first "$dir"
	}

	Set-Alias -name lsort -Value Invoke-LsdSort

}



## * List out every executable program in the current PATH environment variable - all numbered, single line, single column form
if (Get-Command bat -ErrorAction SilentlyContinue) {
	function Invoke-ListPath {
		$env:PATH -split ";" | Sort-Object | Get-Unique -AsString | bat -f --style=full
	}

	# function Invoke-NetstatAll {
	# 	NETSTAT.EXE -a -n -b | bat -f --style=full
	# }

	function Invoke-NetstatExes {
		NETSTAT.exe -a -n -o -b | bat -f --style=full
	}

	function Invoke-NetstatRoutes {
		NETSTAT.EXE -a -o -r | bat -f --style=full
	}

	function Invoke-NetstatStates {
		NETSTAT.exe -a -n -o -t | bat -f --style=full
	}

	# function Invoke-ports {
	# 	# Write-Host "`nOpen connections :"
	# 	NETSTAT.EXE -a -n | bat -f --style=full
	# }

}
else {
	function Invoke-ListPath {
		$env:PATH -split ";" | Sort-Object | Get-Unique -AsString
	}

	function Invoke-NetstatAll {
		NETSTAT.EXE -a -o -b
	}

	function Invoke-NetstatExes {
		NETSTAT.exe -a -o -b
	}

	function Invoke-NetstatRoutes {
		NETSTAT.EXE -a -o -r
	}

	function Invoke-NetstatStates {
		NETSTAT.exe -a -o -t
	}

	# function Invoke-ports {
	# 	Write-Host "`nOpen connections :"
	# 	NETSTAT.EXE -a -n
	# }
}
##

## * Updates Windows Subsystem for Linux (WSL) from the latest pre-release version on GitHub (default is from MS Store)
if (Get-Command wsl -ErrorAction SilentlyContinue) {
	function Invoke-WSLUpdatePreRelease {
		wsl --update --pre-release
	}

	Set-Alias -Name wslupd -Value Invoke-WSLUpdatePreRelease

	## * Shut down  WSL Kernel & any distribution instances running on it
	function Invoke-WSLShutDown {
		wsl --shutdown
	}

	Set-Alias -Name wslshutd -Value Invoke-WSLShutDown

}

## * Upgrades/Updates all programs installed with WinGet package manager
if (Get-Command winget -ErrorAction SilentlyContinue) {
	function Invoke-WingetUpgradeAll {
		winget upgrade --all
	}

	Set-Alias -Name wingetup -Value Invoke-WingetUpgradeAll

}

## * Open current directory with "explore" command alias - use FOSS "Files" app if it is installed, default is set to standard Windows File Explorer
if (Get-Command files -ErrorAction SilentlyContinue) {
	function Invoke-FileExplorer {
		files .
	}

	Set-Alias -Name explore -Value Invoke-FileExplorer
}
else {
	function Invoke-FileExplorer {
		explorer .
	}

	Set-Alias -Name explore -Value Invoke-FileExplorer

}

if (Get-Command gh -ErrorAction SilentlyContinue) {
	function Invoke-GhRepoList {
		gh repo list --limit=100
	}

	Set-Alias -Name lsrepos -Value Invoke-GhRepoList
}

if (Get-Command ag -ErrorAction SilentlyContinue) {
	function Invoke-AGFindSmartHiddenMatches($searchString) {
		ag -S -l --hidden -g "$searchString"
	}

	Set-Alias -Name aghs -Value Invoke-AGFindSmartHiddenMatches
}

if (Get-Command code-insiders -ErrorAction SilentlyContinue) {
	function Invoke-VSCodeInsiders($dir) {
		code-insiders "$dir"
	}

	Set-Alias -Name codeins -Value Invoke-VSCodeInsiders
}

if (Get-Command codium-insiders -ErrorAction SilentlyContinue) {
	function Invoke-VSCodiumInsiders($dir) {
		codium-insiders "$dir"
	}

	Set-Alias -Name codmins -Value Invoke-VSCodiumInsiders
}
