function Get-CommandPath {
	Get-Command -Name $args -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

New-Alias -Name 'which' -Value Get-CommandPath -Scope Global

if (Get-Command lsd -ErrorAction SilentlyContinue) {

	function Get-LsdDefault($dirpath = '.') {
		lsd -X -F --system-protected --reverse --group-directories-first $dirpath
	}

	function Get-LsdDetails($dirpath = '.') {
		lsd -l -F -X --system-protected --reverse --group-directories-first $dirpath
	}

	function Get-LsdHidden($dirpath = '.') {
		lsd -A -X --system-protected --reverse --group-directories-first $dirpath
	}

	function Get-LsdDirsOnly($dirpath = '.') {
		lsd -A -d --system-protected -1 $dirpath
	}

	function Get-LsdDirTree($dirpath = '.') {
		lsd -A -X --system-protected --depth 4 --tree $dirpath
	}

	function Get-LsdSort($dirpath = '.') {
		lsd -A -l -r --sizesort --reverse --group-directories-first $dirpath
	}

	Set-Alias -Name 'ls' -Value Get-LsdDefault -Force -Scope Global
	New-Alias -Name 'll' -Value Get-LsdDetails -Scope Global
	New-Alias -Name 'la' -Value Get-LsdHidden -Scope Global
	New-Alias -Name 'ld' -Value Get-LsdDirsOnly -Scope Global
	New-Alias -Name 'lt' -Value Get-LsdDirTree -Scope Global
	New-Alias -Name 'lsort' -Value Get-LsdSort -Scope Global

}

## ? reassign with conditional to use bat or cat
# $outputCommand = ($outputCommand) ?  bat -f --style=full : cat
## ? List out every executable program in the current PATH environment variable - all numbered, single line, single column form

if (Get-Command bat -ErrorAction SilentlyContinue) {
	function Get-PathExecutables {
		$env:PATH -split ";" | Sort-Object | Get-Unique -AsString | bat -f --style=full
	}

	New-Alias -Name 'lspath' -Value Get-PathExecutables -Scope Global

	function Get-NetworkConnections {
		NETSTAT.EXE -a -n -b | bat -f --style=full
	}

	function Get-NetworkProcesses {
		NETSTAT.EXE -a -o -b | bat -f --style=full
	}


	function Get-NetworkRoutes {
		NETSTAT.EXE -a -o -r | bat -f --style=full
	}


	function Get-NetworkTcpConnections {
		NETSTAT.EXE -a -n -o -t | bat -f --style=full
	}

	New-Alias -Name 'netstat' -Value Get-NetworkConnections -Scope Global
	New-Alias -Name 'netstata' -Value Get-NetworkProcesses -Scope Global
	New-Alias -Name 'netstatr' -Value Get-NetworkRoutes -Scope Global
	New-Alias -Name 'netstatc' -Value Get-NetworkTcpConnections -Scope Global

}

## * Updates Windows Subsystem for Linux (WSL) from the latest pre-release version on GitHub (default is from MS Store)
if (Get-Command wsl.exe -ErrorAction SilentlyContinue) {
	## * Shut down  WSL Kernel & any distribution instances running on it

	function Update-WSLPreRelease {
		wsl.exe --update --pre-release
	}

	function Stop-AllWSLInstances {
		wsl.exe --shutdown
	}

	function Stop-WSLInstanceWithDistroName($distroName = 'Ubuntu-22.04') {
		wsl.exe --terminate $distroName
	}

	New-Alias -Name 'wslupd' -Value Update-WSLPreRelease -Scope Global
	New-Alias -Name 'wslshutd' -Value Stop-AllWSLInstances -Scope Global
	New-Alias -Name 'wslt' -Value Stop-WSLInstanceWithDistroName -Scope Global

}

## * Open current directory with "explore" command alias - use FOSS "Files" app if it is installed, default is set to standard Windows File Explorer
if (Get-Command files.exe -ErrorAction SilentlyContinue) {
	New-Alias -Name 'explore' -Value 'files.exe .' -Scope Global
}
else {
	New-Alias -Name 'explore' -Value 'explorer.exe .' -Scope Global
}

if (Get-Command gh.exe -ErrorAction SilentlyContinue) {
	New-Alias -Name lsrepos -Value 'gh.exe repo list --limit=100' -Scope Global
}

if (Get-Command ag.exe -ErrorAction SilentlyContinue) {
	function Get-AgFileNameSearch($dirpath = '.') {
		ag -S -H -a -f --depth=8 -w $dirpath
	}

	function Get-AgHiddenFileNameSearch($dirpath = '.') {
		ag -S -H -a -f --hidden --depth=8 -g $dirpath
	}

	New-Alias -Name 'agfn' -Value Get-AgFileNameSearch -Scope Global
	New-Alias -Name 'agfh' -Value Get-AgHiddenFileNameSearch -Scope Global
}

if (Get-Command code.exe -ErrorAction SilentlyContinue) {

	function Open-VSCodeFromDir($dir = '.') {
		code.exe $dir
	}

	New-Alias -Name 'codein' -Value Open-VSCodeInsidersFromDir -Scope Global

}


if (Get-Command code-insiders.exe -ErrorAction SilentlyContinue) {

	function Open-VSCodeInsidersFromDir($dir = '.') {
		code-insiders.exe $dir
	}

	New-Alias -Name 'codeins' -Value Open-VSCodeInsidersFromDir -Scope Global

}

if (Get-Command codium-insiders.exe -ErrorAction SilentlyContinue) {

	function Open-VSCodiumInsidersFromDir($dir = '.') {
		codium-insiders.exe $dir
	}

	New-Alias -Name 'codiumin' -Value Open-VSCodiumInsidersFromDir -Scope Global

}
