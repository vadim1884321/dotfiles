# . "~\dotfiles-config.ps1"
. "$PSScriptRoot\helpers.ps1"
$dotfilesDataConfig = Get-Content -Path "~\dotfiles-config.jsonc" -Raw | ConvertFrom-Json

# $jsonObject.uninstall.packages | ForEach-Object {
# 	Write-Output ($_)
# }
# Write-Host $jsonObject.uninstall.packages
RemoveApps($dotfilesDataConfig.uninstall)
# ClearStartMenu
