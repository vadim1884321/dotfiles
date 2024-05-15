<#
	.SYNOPSIS
	Punto Switcher — программа, которая автоматически переключает раскладку клавиатуры.

	.EXAMPLE
	.\PuntoSwitcher.ps1

	.LINK
	https://yandex.ru/soft/punto/

	.NOTES
	Current user
#>
try {
	if (!(Test-Path -Path "$env:LOCALAPPDATA\Yandex\Punto Switcher\punto.exe")) {
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		Write-Host "Punto Switcher installation and configuration..." -ForegroundColor Cyan

		$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
		$Parameters = @{
			Uri     = "https://yandex.ru/soft/punto/download/?os=win"
			OutFile = "$DownloadsFolder\PuntoSwitcherSetup.exe"
			Verbose = $true
		}
		Invoke-WebRequest @Parameters

		#  -ArgumentList "/quiet" вызываает ошибку
		Start-Process -FilePath "$DownloadsFolder\PuntoSwitcherSetup.exe" -ArgumentList "/quiet" -Wait

		Remove-Item -Path "$DownloadsFolder\PuntoSwitcherSetup.exe" -Force

		Copy-Item -Path "$PSScriptRoot\..\Punto Switcher" -Destination "$env:APPDATA\Yandex\" -Recurse -Force

		Write-Host "Punto Switcher is successfully installed and configured." -ForegroundColor Blue
	}
	else {
		Write-Host "Punto Switcher is already installed." -ForegroundColor Blue
	}
}
catch {
	<#Do this if a terminating exception happens#>
}
