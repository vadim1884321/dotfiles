# $profileDir = Split-Path -parent $profile
# New-Item $profileDir -ItemType Directory -Force -ErrorAction SilentlyContinue

# Get-ChildItem -Path $PSScriptRoot -Exclude main.ps1, helpers -Name|
# Foreach-Object {
# 		New-Item -ItemType SymbolicLink -Path $profileDir\$_ -Target $PSScriptRoot\$_ -Force
# 		New-Item -ItemType SymbolicLink -Path $profileDir\$_ -Target $PSScriptRoot\$_ -Force
# }
Write-Host "Setting up a PowerShell profile..." -ForegroundColor "Yellow";
if (!(Test-Path -Path $profile)) {
	New-Item -ItemType File -Path $profile -Force
}
Set-Content -Path $profile -Value '. "$HOME\dotfiles\windows\powershell\profile.ps1"'

Write-Host "✔️ PowerShell profile setup is complete." -ForegroundColor "Green"
