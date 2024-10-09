## * Import PSReadLine module to enable customizable key bindings, tab completions, other features
Import-Module PSReadLine

## * Import Sudo module to enable cmdlets that mimic "sudo" command on GNU/linux
## * Enables user to perform operations that require elevated/administator permissions
Import-Module -Name Sudo

## * Import SSH, Git Module to more easily wield keys
Import-Module -Name Posh-SSH

### ? Import the Chocolatey Profile that contains the necessary code to enable
## * tab-completions to function for `choco`.
## * Be aware that if you are missing these lines from your profile, tab completion
## * for `choco` will not function.
## * See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

<### * Set Some Option for PSReadLine to show the history of our typed commands ###>
if ($env:TERM_PROGRAM -ne "vscode") {
	Set-PSReadLineOption -PredictionViewStyle ListView
}
else {
	Set-PSReadLineOption -PredictionViewStyle InlineView
}


# * Set Some Option for PSReadLine to show the history of our typed commands
Set-PSReadLineOption  -BellStyle Visual -PredictionSource History `
	-ContinuationPrompt "󰅂 " -ShowToolTips:$true `
	-HistorySaveStyle SaveIncrementally -HistoryNoDuplicates:$true `
	-HistorySearchCursorMovesToEnd:$true -HistorySearchCaseSensitive:$false

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

### * Imports the terminal Icons into curernt Instance of PowerShell
Import-Module -Name Terminal-Icons

### * Utility Command that tells you where the absolute path of commandlets are
function which ($command) {
 Get-Command -Name $command -ErrorAction SilentlyContinue |
 Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function Write-UnprotectedCmsMessage($Path, $To) {
	Get-Content -Path $Path | Unprotect-CmsMessage -To $To
}

Set-Alias -Name grep -Value findstr -Scope Global
Set-Alias -Name netstat -Value NETSTAT.exe -Scope Global

<## ? check to see if powershell is in interactive mode... ##>
if ($?) {

	## ! Invoke fastfetch to display system logo, info, etc. if the executable is installed & found in "$env:PATH"
	if ($env:TERM_PROGRAM -ne "vscode" -and (Get-Command -Name fastfetch -ErrorAction SilentlyContinue)) {
		fastfetch

	}

	if ($env:TERM_PROGRAM -ne "vscode" -and (Get-Command -Name oh-my-posh -ErrorAction SilentlyContinue)) {
		## ! Initialize Oh My Posh with theme chosen from the env variable "POSH_THEMES_PATH" pointing to default oh-my-posh themes directory
		New-Alias -Name omp -Value oh-my-posh -Scope Global
		oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_classic.omp.json" | Invoke-Expression
	}

	else {
		oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerline.omp.json" | Invoke-Expression

	}

}
