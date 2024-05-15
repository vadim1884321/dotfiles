# Устнавить OEM-информацию производителя
function Set-OEMInformation {
	Write-Host "Setting OEM information (Registry)" -ForegroundColor Cyan

	$OEMRegPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\OEMInformation"

	New-ItemProperty -Path $OEMRegPath -Name "Model" -Value "SER" | Out-Null
	New-ItemProperty -Path $OEMRegPath -Name "Manufacturer" -Value "AZW" | Out-Null
	New-ItemProperty -Path $OEMRegPath -Name "SupportURL" -Value "http://www.bee-link.com/" | Out-Null
	# New-ItemProperty -Path $OEMRegPath -Name "SupportPhone" -Value "111111" | Out-Null
	New-ItemProperty -Path $OEMRegPath -Name "SupportHours" -Value "Always" | Out-Null
	New-ItemProperty -Path $OEMRegPath -Name "HelpCustomized" -Value 0 | Out-Null
}
