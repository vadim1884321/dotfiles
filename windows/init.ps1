#Requires -RunAsAdministrator

# ============================================================================ #
# Установка Winget
# ============================================================================ #

try {
	if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
		Write-Host "`nInstalling Winget..." -ForegroundColor Cyan

		Strip-ProgressIndent -ScriptBlock {
			# Устанавливает NuGet
			if (!(Get-PackageProvider -Name "NuGet")) {
				Install-PackageProvider -Name "NuGet" -Force -Confirm:$false | Out-Null
			}

			# Проверяет и устанавливает доверие для PSGallery
			$psRepoInstallationPolicy = (Get-PSRepository -Name 'PSGallery').InstallationPolicy
			if ($psRepoInstallationPolicy -ne 'Trusted') {
				Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted | Out-Null
			}

			# Устанавливает Winget
			Install-Script -Name winget-install -Force
			winget-install -Force

			# Возвращает доверие для PSGallery в исходное состояние
			if ($psRepoInstallationPolicy -ne 'Trusted') {
				Set-PSRepository -Name 'PSGallery' -InstallationPolicy $psRepoInstallationPolicy | Out-Null
			}
		}

		# Подтверждает, что Winget установлен
		if (Get-Command winget -ErrorAction SilentlyContinue) {
			Write-Host "Winget is installed." -ForegroundColor Green
		}
		else {
			Write-Warning "There was an issue installing Winget which Windows Terminal depends on. Please try again."
			exit 1
		}
	}
	else {
		Write-Host "`nWinget is already installed." -ForegroundColor Green
	}
}
catch {
	throw $_.Exception.Message
}

# ============================================================================ #
# Установка Windows Terminal
# ============================================================================ #

try {
	if (!(Get-Command -Name wt -ErrorAction SilentlyContinue)) {
		Write-Host "`nInstalling Windows Terminal..." -ForegroundColor Cyan

		Strip-ProgressIndent -ScriptBlock {
			winget install -h Microsoft.WindowsTerminal --accept-package-agreements --accept-source-agreements --force --disable-interactivity
		}

		# Подтверждает, что Windows Terminal установлен
		if (Get-Command -Name wt -ErrorAction SilentlyContinue) {
			Write-Host "Windows Terminal is installed." -ForegroundColor Green
		}
		else {
			# Устанавливает Windows Terminal c помощью Winget из Microsoft Store
			Write-Warning "Windows Terminal was not installed. Trying another method..."

			Strip-ProgressIndent -ScriptBlock {
				winget install -h "windows terminal" --source "msstore" --accept-package-agreements --accept-source-agreements --force --disable-interactivity
			}

			if (Get-Command -Name wt -ErrorAction SilentlyContinue) {
				Write-Host "Windows Terminal is installed." -ForegroundColor Green
			}
			else {
				Write-Warning "There was an issue installing Windows Terminal. Please refer to any error messages above for more information."
				exit 1
			}
		}
	}
	else {
		Write-Host "`nWindows Terminal is already installed." -ForegroundColor Green
	}
}
catch {
	throw $_.Exception.Message
}

# Копирование конфигурации для Windows Terminal
Write-Host "`nCopying the configuration for the Windows Terminal..." -ForegroundColor Cyan
$Parameters = @{
	Uri     = "https://raw.githubusercontent.com/vadim1884321/dotfiles/main/windows/WindowsTerminal/settings.json"
	OutFile = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}
Invoke-WebRequest @Parameters

# ============================================================================ #
# Установка Powershell Core
# ============================================================================ #

if (!(Get-Command -Name pwsh -ErrorAction SilentlyContinue)) {
	Write-Host "`nInstalling Powershell Core..." -ForegroundColor Cyan
	winget install -e -h Microsoft.PowerShell --accept-source-agreements --accept-package-agreements
}
else {
	Write-Host "`nPowershell Core is already installed." -ForegroundColor Green
}

# ============================================================================ #
# Установка шрифта Cascadia Code
# ============================================================================ #

try {
	# Получаем массив установленных в систему шрифтов
	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
	$fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name

	# Проверяем наличие шрифта в массиве
	if ($fontFamilies -notcontains "Cascadia Code NF") {
		Write-Host "`nCascadia Code fonts installation..." -ForegroundColor Cyan

		$repo = "microsoft/cascadia-code"
		$tag = (Invoke-WebRequest -Uri "https://api.github.com/repos/$repo/releases" -UseBasicParsing | ConvertFrom-Json)[0].tag_name -replace 'v', ''

		$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
		$Parameters = @{
			Uri     = "https://github.com/$repo/releases/download/v$tag/CascadiaCode-$tag.zip"
			OutFile = "$DownloadsFolder\CascadiaCode.zip"
		}
		Invoke-WebRequest @Parameters

		Expand-Archive -Path "$DownloadsFolder\CascadiaCode.zip" -DestinationPath "$DownloadsFolder\CascadiaCode" -Force

		$destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
		Get-ChildItem -Path "$DownloadsFolder\CascadiaCode" -Depth 1 -Recurse -Filter "*.ttf" | ForEach-Object {
			If (-not(Test-Path "$SystemRoot\Fonts\$($_.Name)")) {
				$destination.CopyHere($_.FullName, 0x10)
			}
		}

		Remove-Item -Path "$DownloadsFolder\CascadiaCode" -Recurse -Force
		Remove-Item -Path "$DownloadsFolder\CascadiaCode.zip" -Force
	}
	else {
		Write-Host "`nCascadia Code fonts are already installed." -ForegroundColor Green
	}
}
catch {
	Write-Error "Failed to download or install the Cascadia Code font. Error: $_"
}

# Установка Git
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
	Write-Host "`nInstalling Git..." -ForegroundColor Cyan
	winget install -e -h Git.Git --accept-source-agreements --accept-package-agreements
}
else {
	Write-Host "`nGit is already installed." -ForegroundColor Green
}

# Обновляет системные переменные среды
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# Клонирование git репозитория dotfiles
if (!(Test-Path "$HOME\dotfiles")) {
	Write-Host "`nCloning the dotfiles repository..." -ForegroundColor Cyan
	git clone https://github.com/vadim1884321/dotfiles.git
}
else {
	Write-Host "`nCloning of the dotfiles repository has already been completed." -ForegroundColor Green
}

# Копирование конфигурационого файла c данными
if (!(Test-Path "$HOME\dotfiles-config.ps1")) {
	Copy-Item "$HOME\dotfiles\windows\default_config.ps1" "$HOME\dotfiles-config.ps1"
}

Write-Host "`nPlease complete the file ~/dotfiles_data.ps1" -ForegroundColor Green
Write-Host "Next, run the ~/dotfiles/windows/main.ps1" -ForegroundColor Green
