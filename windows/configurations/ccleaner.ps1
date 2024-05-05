# CCleaner
if (Test-Path -Path "$env:ProgramFiles\CCleaner\CCleaner64.exe") {
	Write-Host "CCleaner configuration..." -ForegroundColor "Yellow"

	Stop-Process -Name CCleaner -Force -ErrorAction Ignore

	Get-ScheduledTask -TaskName "CCleaner Update" -ea SilentlyContinue | Unregister-ScheduledTask -Confirm:$false

	$RegPath = "HKCU:\Software\Piriform\CCleaner"

	if (!(Test-PathRegistryKey -Path $RegPath -Name "UpdateBackground")) {
		New-ItemProperty -Path $RegPath -Name "UpdateBackground" -PropertyType String
	}
	Set-ItemProperty -Path $RegPath -Name "UpdateBackground" -Value 0

	if (!(Test-PathRegistryKey -Path $RegPath -Name "UpdateCheck")) {
		New-ItemProperty -Path $RegPath -Name "UpdateCheck" -PropertyType String
	}
	Set-ItemProperty -Path $RegPath -Name "UpdateCheck" -Value 0

	if (!(Test-PathRegistryKey -Path $RegPath -Name "Monitoring")) {
		New-ItemProperty -Path $RegPath -Name "Monitoring" -PropertyType String
	}
	Set-ItemProperty -Path $RegPath -Name "Monitoring" -Value 0

	Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)PC" -Type String -Value 0
	Set-ItemProperty -Path "HKLM:\Software\Piriform\CCleaner" -Name "(Cfg)PE" -Type String -Value 0

	Write-Host "✔️ CCleaner configuration is complete." -ForegroundColor "Green"
}

