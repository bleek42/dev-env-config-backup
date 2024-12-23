# ### * Import must-have PowerShell modules 1st (PSReadLine, PSFzf, PowerType, etc.)
# Import-Module -Name PSReadLine -MinimumVersion 2.4.0
# Import-Module -Name PowerType
# Enable-PowerType

# # Import-Module -Name PSFzf

# ### ? Import the Chocolatey Profile that contains the necessary code to enable
# ## * tab-completions to function for `choco`.
# ## * Be aware that if you are missing these lines from your profile, tab completion
# ## * for `choco` will not function.
# ## * See https://ch0.co/tab-completion for details.

# $ChocolateyProfile = Join-Path $env:ChocolateyInstall 'helpers\chocolateyProfile.psm1'
# if (Test-Path $ChocolateyProfile) {
# 	Import-Module $ChocolateyProfile
# }

# # $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# Set-PSReadLineOption  -BellStyle Visual -EditMode Windows
# Set-PSReadLineOption -PredictionViewStyle InlineView -PredictionSource HistoryAndPlugin

# Set-PSReadLineOption -HistorySaveStyle SaveIncrementally -HistoryNoDuplicates:$true -HistorySearchCursorMovesToEnd:$true -MaximumHistoryCount 3072 -ShowToolTips

# ## * Set-PSReadLineKeyHandler -
# Set-PSReadLineKeyHandler -Key Space -Function SelectLine
# Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
# Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward

# # Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# ## * Override default tab completion
# # Set-PsFzfOption -TabExpansion -GitKeyBindings
# # Set-PsFzfOption -AltCCommand { Invoke-FuzzyHistory }

# # ## * Override PSReadLine's history search
# # Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# # ## * Enable Fuzzy Search with PSFzf/Readline
# # Set-PsFzfOption -EnableAliasFuzzyHistory -EnableAliasFuzzyEdit -EnableAliasFuzzyKillProcess
# # Set-PsFzfOption -EnableAliasFuzzyGitStatus -EnableAliasFuzzyScoop


# ## * Import Carbon, PSWindowsUpdate, other Windows Tools for managing dir/file permissions, users, perms, execution policies + much more
# Import-Module -Name Carbon -Global
# # Import-Module -Name PSWindowsUpdate
# # Import-Module -Name VcRedist

# ### * Import Terminal-Icons into
# Import-Module -Name Terminal-Icons
# # Import-Module 'C:\ProgramData\scoop\apps\vcpkg\current\scripts\posh-vcpkg'

# if (Get-Command zoxide -ErrorAction SilentlyContinue) {
# 	Invoke-Expression (& { (zoxide init powershell --hook pwd --cmd zd | Out-String) })
# }

# # ### * ALIASES / FUNCTIONS
# # if (Test-Path '.\Scripts\Aliases.ps1') {
# # 	. '.\Scripts\Aliases.ps1'
# # }

# $completionScriptsDir = "$env:USERPROFILE\Documents\PowerShell\Completions"
# if (Test-Path $completionScriptsDir) {
# 	Get-ChildItem -Path $completionScriptsDir | ForEach-Object {
# 		. $_
# 	}
# }
# ## ? <## check to see if powershell is interactive, in alacritty or windows terminal ##>
# # if ($Host.Name -eq "ConsoleHost" -and (Get-Command fastfetch.exe -ErrorAction SilentlyContinue)) {
# # 	fastfetch.exe

# # }

# ### * Initialize Oh My Posh with different prompts based on what terminal program powershell is running in.
# if ($env:TERM_PROGRAM -eq "vscode" -and (Get-Command oh-my-posh.exe -ErrorAction SilentlyContinue)) {
# 	$omptheme = "blue-owl.omp.json"
# 	oh-my-posh.exe init pwsh --config (Join-Path "$env:POSH_THEMES_PATH" "$omptheme") | Invoke-Expression

# }
# elseif (Get-Command oh-my-posh.exe -ErrorAction SilentlyContinue) {
# 	$omptheme = "space.omp.json"
# 	oh-my-posh.exe init pwsh --config (Join-Path "$env:POSH_THEMES_PATH" "$omptheme") | Invoke-Expression

# }
# else {
# 	Write-Host "oh-my-posh.exe not found..."

# }

# # $hasInternetAccess = Test-NetConnection -InformationLevel Quiet -InformationAction SilentlyContinue `
# # 	-InformationVariable:$hasInternetAccessInfo -ErrorAction SilentlyContinue | Select-Object -Property PingSucceeded

# # if ($hasInternetAccess) {
# 	#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module
# 	Import-Module -Name Microsoft.WinGet.CommandNotFound -Global
# 	#f45873b3-b655-43a6-b217-97c00aa0db58

# # }
