#Requires -RunAsAdministrator
#Requires -PSEdition Core

# PS Modules
$psModules = @(
	"Microsoft.PowerShell.SecretManagement"
	"Microsoft.PowerShell.SecretStore"
	"powershell-yaml"
	"CompletionPredictor"
	"ps-menu"
	"ps-arch-wsl"
	# "ps-color-scripts"
)

$lineSeparator = ("=" * 64)

Clear-Host

. "$PSScriptRoot\helpers.ps1"
. "$PSScriptRoot\tweaks\helpers.ps1"

$Host.UI.RawUI.WindowTitle = $Localization.menuTitle

# Проверка подключения к Интернету
if (!(Test-InternetConnection)) {
	break
}

# Install PS Modules
$psModules | ForEach-Object {
	if (!(Get-Module -ListAvailable -Name $_)) {
		Install-Module -Name $_ -Force -AcceptLicense -Scope CurrentUser
	}
}

$psModules | ForEach-Object {
	if (Get-Module -ListAvailable -Name $_) {
		Import-Module $_ -DisableNameChecking
	}
}

if (!(Test-Path -Path "$HOME\dotfiles-config.yaml")) {
	Write-Warning "Файл c данными ~\dotfiles-config.yaml не найден. Завершение."
	break
}
else {
	$configData = Get-Content -Path "$HOME\dotfiles-config.yaml" -Raw | ConvertFrom-Yaml
}

function Set-MainMenu {
	$local:menuInstallApps = $Localization.menuInstallApps
	$local:menuRemoveDebloatApps = $Localization.menuRemoveDebloatApps
	$local:menuInstallSecretVault = $Localization.menuInstallSecretVault
	$local:menuTweaks = $Localization.menuTweaks
	$local:menuInstallWSL = $Localization.menuInstallWSL
	$local:menuExit = $Localization.menuExit

	do {
		Write-Host $lineSeparator -ForegroundColor Cyan
		Write-Host $Localization.menuTitle -ForegroundColor Green
		Write-Host $lineSeparator -ForegroundColor Cyan
		$local:applyMenu = Menu @(
			"${menuInstallApps}",
			"${menuRemoveDebloatApps}",
			"${menuInstallSecretVault}",
			"${menuTweaks}",
			"${menuInstallWSL}",
			"${menuExit}"
		)
		Write-Host $lineSeparator -ForegroundColor Cyan
		switch ( $applyMenu ) {
			"${menuInstallApps}" {
				Install-Apps $configData.install_apps
			}
			"${menuRemoveDebloatApps}" {
				Remove-DebloatApps $configData.remove_debloat_appx
			}
			"${menuInstallSecretVault}" {
				Write-Host $Localization.menuInstallSecretVault -ForegroundColor Green
				Write-Host $lineSeparator -ForegroundColor Cyan
				. "$PSScriptRoot\Bitwarden\main.ps1"
			}
			"${menuTweaks}" {
				Write-Host $Localization.menuTweaks -ForegroundColor Green
				Write-Host $lineSeparator -ForegroundColor Cyan
				foreach ($tweak in $configData.tweaks) {
					Invoke-Expression $tweak
				}
			}
			"${menuInstallWSL}" {
				Write-Host $Localization.menuInstallWSL -ForegroundColor Green
				Write-Host $lineSeparator -ForegroundColor Cyan
				. "$PSScriptRoot\WSL\main.ps1"
			}
			"${menuExit}" {
				Write-Host $Localization.menuExit -ForegroundColor Green
				Write-Host $lineSeparator -ForegroundColor Cyan
			}
			default { Write-Host "Invalid option, reselect please." }
		}
		# pause
	} until ($applyMenu -eq $Localization.menuExit)
}

Set-MainMenu



# do {
# 	Show-Menu –Title "Конфигурация Windows"
# 	Write-Host @"

#             Введите пункт меню на клавиатуре [1,2,3,Q] для продолжения
# "@ -NoNewline -ForegroundColor Green

# 	$Choice = Read-Host ' '

# 	switch ($Choice) {
# 		1 {
# 			# . "$PSScriptRoot/PowerShell/main.ps1"
# 			Install-WinUtilProgramWinget $install_apps
# 		}
# 		2 { Install-Chocolatey -AppPath $ChocoPath -DownloadURL $ChocoURL }
# 		3 { Install-Scoop -AppPath $ScoopPath -App $ScoopApp -PS1File $ScoopPS1 }
# 		default {
# 			Write-Host "Неверный выбор. Попробуйте снова."
# 		}
# 	}
# 	# pause
# } until ($Choice -eq 'q')
# . "$PSScriptRoot/PowerShell/main.ps1"
# . "$PSScriptRoot\tweaks\main.ps1"
# . "$PSScriptRoot/PowerShell/main.ps1"
# . "$PSScriptRoot/configurations/main.ps1"
# . "$PSScriptRoot/debloat/main.ps1"
# . "$PSScriptRoot/dependencies/test.ps1"
# . "$dir/dependencies/main.ps1"
# . "$dir/windows/main.ps1"
# . "$dir/git/main.ps1"
# . "$dir/nvim/main.ps1"
# . "$dir/alacritty/main.ps1"
# . "$dir/powertoys/main.ps1"
# . "$dir/kmonad/main.ps1"
# . "$dir/capslock/main.ps1"
# . "$dir/qutebrowser/main.ps1"
# . "$dir/waka/main.ps1"
