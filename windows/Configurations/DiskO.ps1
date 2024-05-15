<#
	.SYNOPSIS
	Облачный диск, сервис от Mail.ru

	.EXAMPLE
	.\DiskO.ps1

	.LINK
	https://disk-o.cloud/

	.NOTES
	Current user
#>
try {
	if (!(Test-Path -Path "$env:LOCALAPPDATA\Mail.Ru\Disk-O\DiskO.exe")) {
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		Write-Host "Disk-O installation and configuration..." -ForegroundColor Cyan

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

		Write-Host "Disk-O is successfully installed and configured." -ForegroundColor Blue
	}
	else {
		Write-Host "Disc-O is already installed." -ForegroundColor Blue
	}
}
catch {
	<#Do this if a terminating exception happens#>
}

