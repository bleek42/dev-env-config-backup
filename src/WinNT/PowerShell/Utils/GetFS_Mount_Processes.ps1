
function GetMountedProcesses {
	param (
		$letterDrive
	)

	Get-Process * | Select-Object Path | findstr $letterDrive
}
