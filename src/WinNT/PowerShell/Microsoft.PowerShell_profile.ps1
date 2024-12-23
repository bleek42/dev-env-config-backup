### PowerShell Profile Refactor
### Version 1.03 - Refactored

$debug = $false

if ($debug) {
	Write-Host "#######################################" -ForegroundColor Red
	Write-Host "#           Debug mode enabled        #" -ForegroundColor Red
	Write-Host "#          ONLY FOR DEVELOPMENT       #" -ForegroundColor Red
	Write-Host "#                                     #" -ForegroundColor Red
	Write-Host "#       IF YOU ARE NOT DEVELOPING     #" -ForegroundColor Red
	Write-Host "#       JUST RUN \`Update-Profile\`     #" -ForegroundColor Red
	Write-Host "#        to discard all changes       #" -ForegroundColor Red
	Write-Host "#   and update to the latest profile  #" -ForegroundColor Red
	Write-Host "#               version               #" -ForegroundColor Red
	Write-Host "#######################################" -ForegroundColor Red
	Import-Module -Name PSScriptAnalyzer -Global
}

#################################################################################################################################
############                                                                                                         ############
############                                          !!!   WARNING:   !!!                                           ############
############                                                                                                         ############
############                DO NOT MODIFY THIS FILE. THIS FILE IS HASHED AND UPDATED AUTOMATICALLY.                  ############
############                    ANY CHANGES MADE TO THIS FILE WILL BE OVERWRITTEN BY COMMITS TO                      ############
############                       https://github.com/ChrisTitusTech/powershell-profile.git.                         ############
############                                                                                                         ############
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#
############                                                                                                         ############
############                      IF YOU WANT TO MAKE CHANGES, USE THE Edit-Profile FUNCTION                         ############
############                              AND SAVE YOUR CHANGES IN THE FILE CREATED.                                 ############
############                                                                                                         ############
#################################################################################################################################

Import-Module -Name PowerType -Global
Enable-PowerType

#opt-out of telemetry before doing anything, only if PowerShell is run as admin
if ([bool]([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem) {
	[System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 'true', [System.EnvironmentVariableTarget]::Machine)
}


# Initial GitHub.com connectivity check with 1 second timeout
$global:canConnectToGitHub = Test-Connection github.com -Count 1 -Quiet -TimeoutSeconds 1

# Import Modules and External Profiles
# Ensure Terminal-Icons module is installed before importing
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
	Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -SkipPublisherCheck
}
Import-Module -Name Terminal-Icons

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

function Clear-Cache {
	# add clear cache logic here
	Write-Host "Clearing cache..." -ForegroundColor Cyan

	# Clear Windows Prefetch
	Write-Host "Clearing Windows Prefetch..." -ForegroundColor Yellow
	Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Force -ErrorAction SilentlyContinue

	# Clear Windows Temp
	Write-Host "Clearing Windows Temp..." -ForegroundColor Yellow
	Remove-Item -Path "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

	# Clear User Temp
	Write-Host "Clearing User Temp..." -ForegroundColor Yellow
	Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

	# Clear Internet Explorer Cache
	Write-Host "Clearing Internet Explorer Cache..." -ForegroundColor Yellow
	Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue

	Write-Host "Cache clearing completed." -ForegroundColor Green
}

# Admin Check and Prompt Customization
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
function prompt {
	if ($isAdmin) { "[" + (Get-Location) + "] # " } else { "[" + (Get-Location) + "] $ " }
}
$adminSuffix = if ($isAdmin) { " [ADMIN]" } else { "" }
$Host.UI.RawUI.WindowTitle = "PowerShell {0}$adminSuffix" -f $PSVersionTable.PSVersion.ToString()

Import-Module -Name PSReadLine -MinimumVersion 2.4.0 -Global
Import-Module -Name PSFzf -Global

## * SSH, Git Module to exec in admin, easily manage SSH keys, etc.
Import-Module -Name Posh-SSH -Global
Import-Module -Name posh-git -Global

### * ALIASES / FUNCTIONS
Write-Host
if (Test-Path "$PSScriptRoot\Scripts\Aliases.ps1") {
	.  "$PSScriptRoot\Scripts\Aliases.ps1"
}



# Enhanced PowerShell Experience
# Enhanced PSReadLine Configuration
$PSReadLineOptions = @{
	EditMode                      = 'Windows'
	HistoryNoDuplicates           = $true
	HistorySearchCursorMovesToEnd = $true
	Colors                        = @{
		Command   = '#87CEEB'  # SkyBlue (pastel)
		Parameter = '#98FB98'  # PaleGreen (pastel)
		Operator  = '#FFB6C1'  # LightPink (pastel)
		Variable  = '#DDA0DD'  # Plum (pastel)
		String    = '#FFDAB9'  # PeachPuff (pastel)
		Number    = '#B0E0E6'  # PowderBlue (pastel)
		Type      = '#F0E68C'  # Khaki (pastel)
		Comment   = '#D3D3D3'  # LightGray (pastel)
		Keyword   = '#8367c7'  # Violet (pastel)
		Error     = '#FF6347'  # Tomato (keeping it close to red for visibility)
	}
	PredictionSource              = 'HistoryAndPlugin'
	PredictionViewStyle           = 'InlineView'
	BellStyle                     = 'Visual'
}
Set-PSReadLineOption @PSReadLineOptions

Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
# Custom key handlers
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Chord 'Ctrl+w' -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Chord 'Alt+d' -Function DeleteWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+LeftArrow' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+RightArrow' -Function ForwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+z' -Function Undo
Set-PSReadLineKeyHandler -Chord 'Ctrl+y' -Function Redo

# Custom functions for PSReadLine
Set-PSReadLineOption -AddToHistoryHandler {
	param($line)
	$sensitive = @('password', 'secret', 'token', 'apikey', 'connectionstring')
	$hasSensitive = $sensitive | Where-Object { $line -match $_ }
	return ($null -eq $hasSensitive)
}

# Improved prediction settings
# Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -MaximumHistoryCount 20000

Set-PsFzfOption -EnableAliasFuzzyHistory -EnableFd -EnableAliasFuzzyEdit `
	-EnableAliasFuzzyGitStatus -EnableAliasFuzzyScoop `

## * Override PSReadLine's history search
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Custom completion for common commands
$scriptblock = {
	param($wordToComplete, $commandAst, $cursorPosition)
	$customCompletions = @{
		'git'  = @('status', 'add', 'commit', 'push', 'pull', 'clone', 'checkout')
		'npm'  = @('install', 'start', 'run', 'test', 'build')
		'deno' = @('run', 'compile', 'bundle', 'test', 'lint', 'fmt', 'cache', 'info', 'doc', 'upgrade')
	}

	$command = $commandAst.CommandElements[0].Value
	if ($customCompletions.ContainsKey($command)) {
		$customCompletions[$command] | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
			[System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
		}
	}
}
Register-ArgumentCompleter -Native -CommandName git, npm, deno, bun -ScriptBlock $scriptblock

$scriptblock = {
	param($wordToComplete, $commandAst, $cursorPosition)
	dotnet complete --position $cursorPosition $commandAst.ToString() |
	ForEach-Object {
		[System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
	}
}
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock


# Get theme from profile.ps1 or use a default theme
function Get-Theme {
	try {
		# 	$existingTheme = Select-String -Raw -Path $PROFILE.CurrentUserAllHosts -Pattern "oh-my-posh init pwsh --config"
		# 	if ($null -ne $existingTheme) {
		# 		Invoke-Expression $existingTheme
		# 		return
		# 	}

		oh-my-posh init pwsh --config (Join-Path "$env:POSH_THEMES_PATH" "night-owl.omp.json")  | Invoke-Expression
	}
	catch {
		# oh-my-posh init pwsh --config (Join-Path "$env:POSH_THEMES_PATH" "cobalt2.omp.json") | Invoke-Expression
		Write-Error "error reading Oh My Posh theme..!"
	}
}

## Final Line to set prompt
Get-Theme
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
	Invoke-Expression (& { (zoxide init --cmd zd powershell | Out-String) })
}
else {
	Write-Host "zoxide command not found. Attempting to install via winget..."
	try {
		winget install -e --id ajeetdsouza.zoxide
		Write-Host "zoxide installed successfully. Initializing..."
		Invoke-Expression (& { (zoxide init powershell | Out-String) })
	}
 catch {
		Write-Error "Failed to install zoxide. Error: $_"
	}
}

# Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
# Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

$completionScriptsDir = "$env:USERPROFILE\Documents\PowerShell\Completions"
if (Test-Path $completionScriptsDir) {
	Get-ChildItem -Path $completionScriptsDir | ForEach-Object {
		. $_
	}
}

## ? check to see if powershell is interactive, in alacritty or windows terminal ##>
if ($Host.Name -eq "ConsoleHost" -and (Get-Command fastfetch.exe -ErrorAction SilentlyContinue)) {
	fastfetch.exe
}

# Help Function
function Show-Help {
	$helpText = @"
$($PSStyle.Foreground.Cyan)PowerShell Profile Help$($PSStyle.Reset)
$($PSStyle.Foreground.Yellow)=======================$($PSStyle.Reset)

$($PSStyle.Foreground.Green)Update-Profile$($PSStyle.Reset) - Checks for profile updates from a remote repository and updates if necessary.

$($PSStyle.Foreground.Green)Update-PowerShell$($PSStyle.Reset) - Checks for the latest PowerShell release and updates if a new version is available.

$($PSStyle.Foreground.Green)Edit-Profile$($PSStyle.Reset) - Opens the current user's profile for editing using the configured editor.

$($PSStyle.Foreground.Green)touch$($PSStyle.Reset) <file> - Creates a new empty file.

$($PSStyle.Foreground.Green)ff$($PSStyle.Reset) <name> - Finds files recursively with the specified name.

$($PSStyle.Foreground.Green)Get-PubIP$($PSStyle.Reset) - Retrieves the public IP address of the machine.

$($PSStyle.Foreground.Green)winutil$($PSStyle.Reset) - Runs the latest WinUtil full-release script from Chris Titus Tech.

$($PSStyle.Foreground.Green)winutildev$($PSStyle.Reset) - Runs the latest WinUtil pre-release script from Chris Titus Tech.

$($PSStyle.Foreground.Green)uptime$($PSStyle.Reset) - Displays the system uptime.

$($PSStyle.Foreground.Green)reload-profile$($PSStyle.Reset) - Reloads the current user's PowerShell profile.

$($PSStyle.Foreground.Green)unzip$($PSStyle.Reset) <file> - Extracts a zip file to the current directory.

$($PSStyle.Foreground.Green)hb$($PSStyle.Reset) <file> - Uploads the specified file's content to a hastebin-like service and returns the URL.

$($PSStyle.Foreground.Green)grep$($PSStyle.Reset) <regex> [dir] - Searches for a regex pattern in files within the specified directory or from the pipeline input.

$($PSStyle.Foreground.Green)df$($PSStyle.Reset) - Displays information about volumes.

$($PSStyle.Foreground.Green)sed$($PSStyle.Reset) <file> <find> <replace> - Replaces text in a file.

$($PSStyle.Foreground.Green)which$($PSStyle.Reset) <name> - Shows the path of the command.

$($PSStyle.Foreground.Green)export$($PSStyle.Reset) <name> <value> - Sets an environment variable.

$($PSStyle.Foreground.Green)pkill$($PSStyle.Reset) <name> - Kills processes by name.

$($PSStyle.Foreground.Green)pgrep$($PSStyle.Reset) <name> - Lists processes by name.

$($PSStyle.Foreground.Green)head$($PSStyle.Reset) <path> [n] - Displays the first n lines of a file (default 10).

$($PSStyle.Foreground.Green)tail$($PSStyle.Reset) <path> [n] - Displays the last n lines of a file (default 10).

$($PSStyle.Foreground.Green)nf$($PSStyle.Reset) <name> - Creates a new file with the specified name.

$($PSStyle.Foreground.Green)mkcd$($PSStyle.Reset) <dir> - Creates and changes to a new directory.

$($PSStyle.Foreground.Green)docs$($PSStyle.Reset) - Changes the current directory to the user's Documents folder.

$($PSStyle.Foreground.Green)dtop$($PSStyle.Reset) - Changes the current directory to the user's Desktop folder.

$($PSStyle.Foreground.Green)ep$($PSStyle.Reset) - Opens the profile for editing.

$($PSStyle.Foreground.Green)k9$($PSStyle.Reset) <name> - Kills a process by name.

$($PSStyle.Foreground.Green)la$($PSStyle.Reset) - Lists all files in the current directory with detailed formatting.

$($PSStyle.Foreground.Green)ll$($PSStyle.Reset) - Lists all files, including hidden, in the current directory with detailed formatting.

$($PSStyle.Foreground.Green)gs$($PSStyle.Reset) - Shortcut for 'git status'.

$($PSStyle.Foreground.Green)ga$($PSStyle.Reset) - Shortcut for 'git add .'.

$($PSStyle.Foreground.Green)gc$($PSStyle.Reset) <message> - Shortcut for 'git commit -m'.

$($PSStyle.Foreground.Green)gp$($PSStyle.Reset) - Shortcut for 'git push'.

$($PSStyle.Foreground.Green)g$($PSStyle.Reset) - Changes to the GitHub directory.

$($PSStyle.Foreground.Green)gcom$($PSStyle.Reset) <message> - Adds all changes and commits with the specified message.

$($PSStyle.Foreground.Green)lazyg$($PSStyle.Reset) <message> - Adds all changes, commits with the specified message, and pushes to the remote repository.

$($PSStyle.Foreground.Green)sysinfo$($PSStyle.Reset) - Displays detailed system information.

$($PSStyle.Foreground.Green)flushdns$($PSStyle.Reset) - Clears the DNS cache.

$($PSStyle.Foreground.Green)cpy$($PSStyle.Reset) <text> - Copies the specified text to the clipboard.

$($PSStyle.Foreground.Green)pst$($PSStyle.Reset) - Retrieves text from the clipboard.

Use '$($PSStyle.Foreground.Magenta)Show-Help$($PSStyle.Reset)' to display this help message.
"@
	Write-Host $helpText
}

if (Test-Path "$PSScriptRoot\CTTcustom.ps1") {
	Invoke-Expression -Command "& `"$PSScriptRoot\CTTcustom.ps1`""
}

Write-Host "$($PSStyle.Foreground.Yellow)Use 'Show-Help' to display help$($PSStyle.Reset)"

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
Import-Module -Name Microsoft.WinGet.CommandNotFound -Global -ErrorAction SilentlyContinue
#f45873b3-b655-43a6-b217-97c00aa0db58
