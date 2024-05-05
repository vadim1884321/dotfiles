# Installing Disk-O
if (!(Test-Path -Path "$env:LOCALAPPDATA\Mail.Ru\Disk-O\DiskO.exe")) {
	Write-Host "Disk-O installation and configuration..." -ForegroundColor "Yellow"
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

	if ($Host.Version.Major -eq 5) {
		# Progress bar can significantly impact cmdlet performance
		# https://github.com/PowerShell/PowerShell/issues/2138
		$Script:ProgressPreference = "SilentlyContinue"
	}

	$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
	$Parameters = @{
		Uri     = "https://disko.hb.cldmail.ru/disko/Disk-O_setup_offline.exe"
		OutFile = "$DownloadsFolder\Disk-O_setup.exe"
		Verbose = $true
	}
	Invoke-WebRequest @Parameters
	# Inno Setup https://jrsoftware.org/ishelp/index.php?topic=setupcmdline
	Start-Process -FilePath "$DownloadsFolder\Disk-O_setup.exe" -ArgumentList "/VERYSILENT" -Wait

	Remove-Item -Path "$DownloadsFolder\Disk-O_setup.exe" -Force

	Write-Host "✔️ Disk-O is successfully installed and configured." -ForegroundColor "Green"
}
