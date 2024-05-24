Write-Host "Setting up a PowerShell profile..." -ForegroundColor Cyan
if (!(Test-Path -Path $profile)) {
	New-Item -ItemType File -Path $profile -Force
}
Set-Content -Path $profile -Value '. "$HOME\dotfiles\windows\PowerShell\profile.ps1"'

Write-Host "PowerShell profile setup is complete." -ForegroundColor Green
