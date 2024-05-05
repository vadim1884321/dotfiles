# Установить классическое контекстное меню Windows
function Set-Classic-ContextMenu-Configuration {
	$RegPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}"
	if (-not (Test-Path -Path $RegPath)) {
		Write-Host "Activating classic Context Menu..." -ForegroundColor "Green"

		New-Item -Path $RegPath -Name "InprocServer32" -Force -Value "" | Out-Null

		Write-Host "✔️ Classic Context Menu successfully activated." -ForegroundColor "Green"
	}
}
Set-Classic-ContextMenu-Configuration

# Команда для возвращения современного контекстного меню
# Remove-Item -Path $RegPath -Recurse -Confirm:$false -Force

Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_41040327\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Recurse -Confirm:$false -Force
