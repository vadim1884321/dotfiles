# PowerToys
try {
	if (Test-Path -Path "$env:LOCALAPPDATA\PowerToys\PowerToys.exe") {
		Write-Host "PowerToys configuration..." -ForegroundColor Cyan

		Stop-Process -Name PowerToys -Force -ErrorAction Ignore

		Copy-Item -Path "$PSScriptRoot\..\PowerToys" -Destination "$env:LOCALAPPDATA\Microsoft\" -Recurse -Force

		Start-Process -FilePath "$env:LOCALAPPDATA\PowerToys\PowerToys.exe"

		Write-Host "PowerToys configuration is complete." -ForegroundColor Blue
	}
}
catch {
	<#Do this if a terminating exception happens#>
}

