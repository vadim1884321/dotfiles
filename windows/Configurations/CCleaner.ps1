# CCleaner
try {
	if (Test-Path -Path "$env:ProgramFiles\CCleaner\CCleaner64.exe") {
		Write-Host "CCleaner configuration..." -ForegroundColor Cyan

		Stop-Process -Name CCleaner -Force -ErrorAction Ignore

		# Удаляет задачу по обновлению
		Get-ScheduledTask -TaskName "CCleaner Update" -ea SilentlyContinue | Unregister-ScheduledTask -Confirm:$false

		# Удаляет обновление, проверки обновления и мониторинг
		$RegPath = "HKCU:\Software\Piriform\CCleaner"
		if (!(Test-PathRegistryKey -Path $RegPath -Name "UpdateBackground")) {
			New-ItemProperty -Path $RegPath -Name "UpdateBackground" -PropertyType String -Value 0 -Force
		}

		if (!(Test-PathRegistryKey -Path $RegPath -Name "UpdateCheck")) {
			New-ItemProperty -Path $RegPath -Name "UpdateCheck" -PropertyType String -Value 0 -Force
		}

		if (!(Test-PathRegistryKey -Path $RegPath -Name "Monitoring")) {
			New-ItemProperty -Path $RegPath -Name "Monitoring" -PropertyType String -Value 0 -Force
		}

		# Выключает проверку на местоположение страны (актуально для России)
		Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)PC" -Type String -Value 0
		Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)PE" -Type String -Value 0

		Write-Host "CCleaner configuration is complete." -ForegroundColor Blue
	}
}
catch {
	<#Do this if a terminating exception happens#>
}


