#!/usr/bin/env pwsh

# Set Some Option for PSReadLine to show the history of our typed commands
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

#Fzf (Import the fuzzy finder and set a shortcut key to begin searching)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Utility Command that tells you where the absolute path of commandlets are
function which ($command) {
 Get-Command -Name $command -ErrorAction SilentlyContinue |
 Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Imports the terminal Icons into curernt Instance of PowerShell
Import-Module -Name Terminal-Icons
# Initialize Oh My Posh with the theme which we chosen
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\thecyberden.omp.json" | Invoke-Expression

# Set some useful Alias to shorten typing and save some key stroke
# Set-Alias ls lsd
Set-Alias grep findstr
Set-Alias ETSTAT netstat
