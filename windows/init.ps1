#Requires -RunAsAdministrator

# Проверяет устанавлен ли Winget
$winget = Get-Command -Name winget -ErrorAction SilentlyContinue

if ($null -ne $winget) {
	Write-Host "Winget is already installed" -ForegroundColor Blue
}
else {
	Invoke-RestMethod asheroto.com/winget | Invoke-Expression
}

Write-Host "Installing Windows Terminal..." -ForegroundColor Cyan
winget install --exact --silent Microsoft.WindowsTerminal --accept-package-agreements

Write-Host "Installing PowerShell..." -ForegroundColor Cyan
winget install --exact --silent Microsoft.PowerShell --accept-package-agreements

Write-Host "Copy configuration for Windows Terminal..." -ForegroundColor Cyan
$Parameters = @{
	Uri             = "https://raw.githubusercontent.com/vadim1884321/dotfiles/main/windows/WindowsTerminal/settings.json"
	OutFile         = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
	UseBasicParsing = $true
	Verbose         = $true
}
Invoke-WebRequest @Parameters

# Устанавливает шрифт Cascadia Code
try {
	# Получаем массив установленных в систему шрифтов
	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
	$fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name

	# Проверяем наличие шрифта в массиве
	if ($fontFamilies -notcontains "Cascadia Code NF") {
		Write-Host "Cascadia Code fonts installation..." -ForegroundColor Cyan

		$repo = "microsoft/cascadia-code"
		$tag = (Invoke-WebRequest -Uri "https://api.github.com/repos/$repo/releases" -UseBasicParsing | ConvertFrom-Json)[0].tag_name -replace 'v', ''

		$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
		$Parameters = @{
			Uri             = "https://github.com/$repo/releases/download/v$tag/CascadiaCode-$tag.zip"
			OutFile         = "$DownloadsFolder\CascadiaCode.zip"
			UseBasicParsing = $true
			Verbose         = $true
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

		Write-Host "Cascadia Code fonts installation is complete." -ForegroundColor Blue
	}
	else {
		Write-Host "Cascadia Code fonts are already installed." -ForegroundColor Blue
	}
}
catch {
	Write-Error "Failed to download or install the Cascadia Code font. Error: $_"
}

Write-Host "Installing OpenSSH..." -ForegroundColor Cyan
winget install --exact --silent Microsoft.OpenSSH.Beta --accept-package-agreements

Write-Host "Installing Git..." -ForegroundColor Cyan
winget install --exact --silent Git.Git --accept-package-agreements

# Обновляет системные переменные среды
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

Write-Host "Clone dotfiles repository..." -ForegroundColor Cyan
git clone https://github.com/vadim1884321/dotfiles.git

if (-not (Test-Path "$HOME/dotfiles-config.ps1")) {
	Copy-Item "$HOME/dotfiles/windows/default_config.ps1" "$HOME/dotfiles-config.ps1"
}

Write-Host "Please complete the file ~/dotfiles_data.ps1" -ForegroundColor Blue
Write-Host "Next, run the ~/dotfiles/windows/main.ps1" -ForegroundColor Blue
