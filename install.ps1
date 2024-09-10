## ? Define the application name and version
$appName = "MyApp"
$appVersion = "1.0.0"

## ? Define the installation directory
$installDir = "$env:USERPROFILE\$appName"

## ? Define the usage message
$usage = @"
Usage: install.ps1 [options]

Options:
  --interactive  Run the installation in interactive mode
  --help         Display this help message

Example:
  .\install.ps1 --interactive
"@

## ? Check for the --help flag
if ($args -contains "--help") {
  Write-Host $usage
  exit 0
}

## ? Check for the --interactive flag
if ($args -contains "--interactive") {
  Write-Host "Running installation in interactive mode..."
  Write-Host "Please confirm the installation directory: $installDir"
  $response = Read-Host "Install to $installDir? (y/n)"
  if ($response -ne "y") {
    Write-Host "Installation cancelled."
    exit 0
  }
}

## ? This script is meant to be run from the root of the repo to install & bootstrap all the config/dotfiles for the current user based on the OS/environment.
$os_long = (Get-OS).Name
Write-Host "Operating System/Shell Environment: $os_long"

switch -Regex ($os_long) {
    "Windows*" {
        $os_short = "Windows"
    }
    "Linux*" {
        $os_short = "Linux"
    }
    "Darwin*" {
        $os_short = "Darwin"
    }
    default {
        $os_short = "unknown_os"
    }
}

Write-Host "OS Short: $os_short"
## ? Create the installation directory if it doesn't exist
if (!(Test-Path $installDir)) {
  New-Item -ItemType Directory -Path $installDir
}

## ? Move the application files to the installation directory
Get-ChildItem -Path .\* -Exclude install.ps1 | Move-Item -Destination $installDir

Write-Host "Installation complete."
