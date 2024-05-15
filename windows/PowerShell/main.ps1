Write-Warning "Setting up a PowerShell profile..."
if (not (Test-Path -Path $profile)) {
	New-Item -ItemType File -Path $profile -Force
}
Set-Content -Path $profile -Value '. "$HOME\dotfiles\windows\PowerShell\profile.ps1"'

Write-Host "✔️ PowerShell profile setup is complete." -ForegroundColor Green
