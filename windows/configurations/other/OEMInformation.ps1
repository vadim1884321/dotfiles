# Устнавить OEM-информацию производителя
function Set-OEMInformation {
	Write-Host "Setting OEM information (Registry)" -ForegroundColor "Green";

	$OEMRegPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\OEMInformation"

	Set-ItemProperty -Path $OEMRegPath -Name "Model" -Value "SER"
	Set-ItemProperty -Path $OEMRegPath -Name "Manufacturer" -Value "AZW"
	Set-ItemProperty -Path $OEMRegPath -Name "SupportURL" -Value "http://www.bee-link.com/"
	# Set-ItemProperty -Path $OEMRegPath -Name "SupportPhone" -Value "111111"
	Set-ItemProperty -Path $OEMRegPath -Name "SupportHours" -Value "Always"
	Set-ItemProperty -Path $OEMRegPath -Name "HelpCustomized" -Value 0
}
