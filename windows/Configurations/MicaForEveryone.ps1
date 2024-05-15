# Mica For Everyone
try {
	if (Test-Path -Path "$env:LOCALAPPDATA\Programs\Mica For Everyone\MicaForEveryone.exe") {
		Write-Host "Mica For Everyone configuration..." -ForegroundColor Cyan

		Stop-Process -Name MicaForEveryone -Force -ErrorAction Ignore

		if (!(Test-Path -Path "$env:LOCALAPPDATA\Mica For Everyone")) {
			New-Item "$env:LOCALAPPDATA\Mica For Everyone" -ItemType Directory -Force -ErrorAction SilentlyContinue
		}
		Copy-Item -Path "$PSScriptRoot\..\MicaForEveryone\MicaForEveryone.conf" -Destination "$env:LOCALAPPDATA\Mica For Everyone" -Force

		# Добавление Mica For Everyone в автозагрузку
		$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
		if (!(Test-PathRegistryKey -Path $RegPath -Name "Mica For Everyone")) {
			New-ItemProperty -Path $RegPath -Name "Mica For Everyone" -PropertyType String -Value "$env:LOCALAPPDATA\Programs\Mica For Everyone\MicaForEveryone.exe" -Force
		}

		Write-Host "Mica For Everyone configuration is complete." -ForegroundColor Blue
	}
}
catch {
	<#Do this if a terminating exception happens#>
}

