# Настройка профиля Powershell Core
# Write-Host $Localization.ConfigPowershellProfile -ForegroundColor Cyan
# if (!(Test-Path -Path $profile)) {
# 	New-Item -ItemType File -Path $profile -Force
# }
# Set-Content -Path $profile -Value '. "$HOME\dotfiles\windows\PowerShell\profile.ps1"'

# & $profile

Write-Host $Localization.ConfigPowershellProfile $Localization.ConfigSuccessfully -ForegroundColor Green -Wait
