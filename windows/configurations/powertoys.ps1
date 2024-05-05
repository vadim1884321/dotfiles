# PowerToys
if (Test-Path -Path "$env:LOCALAPPDATA\PowerToys\PowerToys.exe") {
	Write-Host "PowerToys configuration..." -ForegroundColor "Yellow"

	Stop-Process -Name PowerToys -Force -ErrorAction Ignore

	Copy-Item -Path "$PSScriptRoot\..\powertoys\PowerToys" -Destination "$env:LOCALAPPDATA\Microsoft\" -Recurse -Force

	Start-Process -FilePath "$env:LOCALAPPDATA\PowerToys\PowerToys.exe"

	Write-Host "✔️ PowerToys configuration is complete." -ForegroundColor "Green"
}
