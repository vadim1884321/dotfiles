#Requires -RunAsAdministrator

<#
	.SYNOPSIS
	Checks if Winget, Choco and/or Scoop are installed

	.PARAMETER winget
	Check if Winget is installed

	.PARAMETER choco
	Check if Chocolatey is installed

	.PARAMETER scoop
	Check if Scoop is installed
#>
function Test-WinPackageManager {
	Param(
		[System.Management.Automation.SwitchParameter]$winget,
		[System.Management.Automation.SwitchParameter]$choco,
		[System.Management.Automation.SwitchParameter]$scoop
	)

	$status = "not-installed"

	if ($winget) {
		# Install Winget if not detected
		$wingetExists = Get-Command -Name winget -ErrorAction SilentlyContinue

		if ($wingetExists) {
			# Check Winget Version
			$wingetVersionFull = (winget --version) # Full Version without 'v'.

			# Check if Preview Version
			if ($wingetVersionFull.Contains("-preview")) {
				$wingetVersion = $wingetVersionFull.Trim("-preview")
				$wingetPreview = $true
			}
			else {
				$wingetVersion = $wingetVersionFull
				$wingetPreview = $false
			}

			# Check if Winget's Version is too old.
			$wingetCurrentVersion = [System.Version]::Parse($wingetVersion.Trim('v'))
			# Grabs the latest release of Winget from the Github API for version check process.
			$response = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/Winget-cli/releases/latest" -Method Get -ErrorAction Stop
			$wingetLatestVersion = [System.Version]::Parse(($response.tag_name).Trim('v')) #Stores version number of latest release.
			$wingetOutdated = $wingetCurrentVersion -lt $wingetLatestVersion
			Write-Section -Text "Winget is installed" -Color Green
			Write-Host "Version: $wingetVersionFull" -ForegroundColor White

			if (!$wingetPreview) {
				Write-Host "   - Winget is a release version." -ForegroundColor Green
			}
			else {
				Write-Host "   - Winget is a preview version. Unexpected problems may occur." -ForegroundColor Yellow
			}

			if (!$wingetOutdated) {
				Write-Host "   - Winget is Up to Date" -ForegroundColor Green
				$status = "installed"
			}
			else {
				Write-Host "   - Winget is Out of Date" -ForegroundColor Red
				$status = "outdated"
			}
		}
		else {
			Write-Section -Text "Winget is not installed" -Color Red
			$status = "not-installed"
		}
	}

	if ($choco) {
		if ((Get-Command -Name choco -ErrorAction Ignore) -and ($chocoVersion = (Get-Item "$env:ChocolateyInstall\choco.exe" -ErrorAction Ignore).VersionInfo.ProductVersion)) {
			Write-Section -Text "Chocolatey is installed" -Color Green
			Write-Host "Version: v$chocoVersion" -ForegroundColor White
			$status = "installed"
		}
		else {
			Write-Section -Text "Chocolatey is not installed" -Color Red
			$status = "not-installed"
		}
	}

	if ($scoop) {
		if (Get-Command -Name scoop -ErrorAction Ignore) {
			Write-Section -Text "Scoop is installed" -Color Green
			$status = "installed"
		}
		else {
			Write-Section -Text "Scoop is not installed" -Color Red
			$status = "not-installed"
		}
	}

	return $status
}

<#
	.SYNOPSIS
	Downloads the Winget Prereqs.

	.DESCRIPTION
	Downloads Prereqs for Winget. Version numbers are coded as variables and can be updated as uncommonly as Microsoft updates the prereqs.
#>
function Get-WingetPrerequisites {
	# I don't know of a way to detect the prereqs automatically, so if someone has a better way of defining these, that would be great.
	# Microsoft.VCLibs version rarely changes, but for future compatibility I made it a variable.
	$versionVCLibs = "14.00"
	$fileVCLibs = "https://aka.ms/Microsoft.VCLibs.x64.${versionVCLibs}.Desktop.appx"
	# Write-Host "$fileVCLibs"
	# Microsoft.UI.Xaml version changed recently, so I made the version numbers variables.
	$versionUIXamlMinor = "2.8"
	$versionUIXamlPatch = "2.8.6"
	$fileUIXaml = "https://github.com/microsoft/microsoft-ui-xaml/releases/download/v${versionUIXamlPatch}/Microsoft.UI.Xaml.${versionUIXamlMinor}.x64.appx"
	# Write-Host "$fileUIXaml"

	Try {
		Write-Host "Downloading Microsoft.VCLibs Dependency..."
		Invoke-WebRequest -Uri $fileVCLibs -OutFile $ENV:TEMP\Microsoft.VCLibs.x64.Desktop.appx
		Write-Host "Downloading Microsoft.UI.Xaml Dependency...`n"
		Invoke-WebRequest -Uri $fileUIXaml -OutFile $ENV:TEMP\Microsoft.UI.Xaml.x64.appx
	}
	Catch {
		throw [WingetFailedInstall]::new('Failed to install prerequsites')
	}
}

<#
	.SYNOPSIS
	Uses GitHub API to check for the latest release of Winget.

	.DESCRIPTION
	This function grabs the latest version of Winget and returns the download path to Install-WinUtilWinget for installation.
#>
function Get-WingetLatest {
	Try {
		# Grabs the latest release of Winget from the Github API for the install process.
		$response = Invoke-RestMethod -Uri "https://api.github.com/repos/microsoft/Winget-cli/releases/latest" -Method Get -ErrorAction Stop
		$latestVersion = $response.tag_name #Stores version number of latest release.
		$licenseWingetUrl = $response.assets.browser_download_url[0] #Index value for License file.
		Write-Host "Latest Version:`t$($latestVersion)`n"
		$assetUrl = $response.assets.browser_download_url[2] #Index value for download URL.
		Invoke-WebRequest -Uri $licenseWingetUrl -OutFile $ENV:TEMP\License1.xml
		# The only pain is that the msixbundle for winget-cli is 246MB. In some situations this can take a bit, with slower connections.
		Invoke-WebRequest -Uri $assetUrl -OutFile $ENV:TEMP\Microsoft.DesktopAppInstaller.msixbundle
	}
	Catch {
		throw [WingetFailedInstall]::new('Failed to get latest Winget release and license')
	}
}

<#
	.SYNOPSIS
	Installs Winget if it is not already installed.

	.DESCRIPTION
	This function will download the latest version of Winget and install it. If Winget is already installed, it will do nothing.
#>
function Install-Winget {

	$isWingetInstalled = Test-WinPackageManager -winget

	Try {
		if ($isWingetInstalled -eq "installed") {
			Write-Host "`nWinget is already installed.`r" -ForegroundColor Green
			return
		}
		elseif ($isWingetInstalled -eq "outdated") {
			Write-Host "`nWinget is Outdated. Continuing with install.`r" -ForegroundColor Yellow
		}
		else {
			Write-Host "`nWinget is not Installed. Continuing with install.`r" -ForegroundColor Red
		}

		# Gets the computer's information
		if ($null -eq $sync.ComputerInfo) {
			$ComputerInfo = Get-ComputerInfo -ErrorAction Stop
		}
		else {
			$ComputerInfo = $sync.ComputerInfo
		}

		if (($ComputerInfo.WindowsVersion) -lt "1809") {
			# Checks if Windows Version is too old for Winget
			Write-Host "Winget is not supported on this version of Windows (Pre-1809)" -ForegroundColor Red
			return
		}

		# Install Winget via GitHub method.
		# Used part of my own script with some modification: ruxunderscore/windows-initialization
		Write-Host "Downloading Winget Prerequsites`n"
		Get-WingetPrerequisites
		Write-Host "Downloading Winget and License File`r"
		Get-WingetLatest
		Write-Host "Installing Winget w/ Prerequsites`r"
		Add-AppxProvisionedPackage -Online -PackagePath $ENV:TEMP\Microsoft.DesktopAppInstaller.msixbundle -DependencyPackagePath $ENV:TEMP\Microsoft.VCLibs.x64.Desktop.appx, $ENV:TEMP\Microsoft.UI.Xaml.x64.appx -LicensePath $ENV:TEMP\License1.xml
		Write-Host "Manually adding Winget Sources, from Winget CDN."
		Add-AppxPackage -Path https://cdn.winget.microsoft.com/cache/source.msix #Seems some installs of Winget don't add the repo source, this should makes sure that it's installed every time.
		Write-Host "Winget Installed" -ForegroundColor Green
		Write-Host "Enabling NuGet and Module..."
		Install-PackageProvider -Name NuGet -Force
		Install-Module -Name Microsoft.WinGet.Client -Force
		# Winget only needs a refresh of the environment variables to be used.
		Write-Output "Refreshing Environment Variables...`n"
		$ENV:PATH = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
	}
 Catch {
		Write-Host "Failure detected while installing via GitHub method. Continuing with Chocolatey method as fallback." -ForegroundColor Red
		# In case install fails via GitHub method.
		Try {
			Start-Process -Verb runas -FilePath powershell.exe -ArgumentList "choco install winget-cli"
			Write-Host "Winget Installed" -ForegroundColor Green
			Write-Output "Refreshing Environment Variables...`n"
			$ENV:PATH = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
		}
		Catch {
			throw [WingetFailedInstall]::new('Failed to install!')
		}
	}
}

<#
	.SYNOPSIS
	Installs Chocolatey if it is not already installed
#>
function Install-Choco {
	try {
		Write-Host "Checking if Chocolatey is Installed..."

		if ((Test-WinPackageManager -choco) -eq "installed") {
			return
		}

		Write-Host "Seems Chocolatey is not installed, installing now."
		Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) -ErrorAction Stop
		powershell choco feature enable -n allowGlobalConfirmation
	}
	Catch {
		Write-Section -Text "Chocolatey failed to install" -Color Red
	}
}

<#
	.SYNOPSIS
	Installs Scoop if it is not already installed
#>
function Install-Scoop {
	try {
		Write-Host "Checking if Scoop is Installed..."

		if ((Test-WinPackageManager -scoop) -eq "installed") {
			return
		}

		Write-Host "Seems Scoop is not installed, installing now."
		# https://github.com/ScoopInstaller/Install#for-admin
		Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
		Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
	}
	Catch {
		Write-Section -Text "Scoop failed to install" -Color Red
	}
}

<#
	.SYNOPSIS
	Prints a text block surrounded by a section divider for enhanced output readability.

	.DESCRIPTION
	This function takes a string input and prints it to the console, surrounded by a section divider made of hash characters.
	It is designed to enhance the readability of console output.

	.PARAMETER Text
	The text to be printed within the section divider.

	.PARAMETER Color
	The color that the section will be colored with

	.EXAMPLE
	Write-Section "Downloading Files..." -Color Green
#>
function Write-Section {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true)]
		[string]$Text,

		[Parameter()]
		[string]$Color = "Green"
	)
	Write-Host "===================================================================" -ForegroundColor $Color
	Write-Host "   $Text " -ForegroundColor $Color
	Write-Host "===================================================================" -ForegroundColor $Color
}

Clear-Host

Install-Winget
Install-Choco
Install-Scoop

# Проверяет устанавлен ли Winget
# $winget = Get-Command -Name winget -ErrorAction SilentlyContinue

# if ($null -ne $winget) {
# 	Write-Host "Winget is already installed" -ForegroundColor Blue
# }
# else {
# 	Invoke-RestMethod asheroto.com/winget | Invoke-Expression
# }

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
# try {
# 	# Получаем массив установленных в систему шрифтов
# 	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
# 	$fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name

# 	# Проверяем наличие шрифта в массиве
# 	if ($fontFamilies -notcontains "Cascadia Code NF") {
# 		Write-Host "Cascadia Code fonts installation..." -ForegroundColor Cyan

# 		$repo = "microsoft/cascadia-code"
# 		$tag = (Invoke-WebRequest -Uri "https://api.github.com/repos/$repo/releases" -UseBasicParsing | ConvertFrom-Json)[0].tag_name -replace 'v', ''

# 		$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
# 		$Parameters = @{
# 			Uri             = "https://github.com/$repo/releases/download/v$tag/CascadiaCode-$tag.zip"
# 			OutFile         = "$DownloadsFolder\CascadiaCode.zip"
# 			UseBasicParsing = $true
# 			Verbose         = $true
# 		}
# 		Invoke-WebRequest @Parameters

# 		Expand-Archive -Path "$DownloadsFolder\CascadiaCode.zip" -DestinationPath "$DownloadsFolder\CascadiaCode" -Force

# 		$destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
# 		Get-ChildItem -Path "$DownloadsFolder\CascadiaCode" -Depth 1 -Recurse -Filter "*.ttf" | ForEach-Object {
# 			If (-not(Test-Path "$SystemRoot\Fonts\$($_.Name)")) {
# 				$destination.CopyHere($_.FullName, 0x10)
# 			}
# 		}

# 		Remove-Item -Path "$DownloadsFolder\CascadiaCode" -Recurse -Force
# 		Remove-Item -Path "$DownloadsFolder\CascadiaCode.zip" -Force

# 		Write-Host "Cascadia Code fonts installation is complete." -ForegroundColor Blue
# 	}
# 	else {
# 		Write-Host "Cascadia Code fonts are already installed." -ForegroundColor Blue
# 	}
# }
# catch {
# 	Write-Error "Failed to download or install the Cascadia Code font. Error: $_"
# }

# Write-Host "Installing OpenSSH..." -ForegroundColor Cyan
# winget install --exact --silent Microsoft.OpenSSH.Beta --accept-package-agreements

# Write-Host "Installing Git..." -ForegroundColor Cyan
# winget install --exact --silent Git.Git --accept-package-agreements

# Обновляет системные переменные среды
# $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

scoop install main/git
scoop bucket add extras
scoop bucket add nerd-fonts
scoop update

# Install app
scoop alias add i 'scoop install $args[0]' 'Install app'
scoop alias add add 'scoop install $args[0]' 'Install app'

# Clear cache
scoop alias add cc 'scoop cache rm *' 'Clear the entire cache'
scoop alias add clear 'scoop cache rm *' 'Clear the entire cache'

# Uninstall app
scoop alias add rm 'scoop uninstall $args[0]' 'Uninstall an app'
scoop alias add remove 'scoop uninstall $args[0]' 'Uninstall an app'

# List apps
scoop alias add ls 'scoop list' 'List installed apps'

# Show status
scoop alias add s 'scoop status' 'Show status and check for new app versions'

# Update
scoop alias add u 'scoop update $args[0]' 'Update apps, or Scoop itself'
scoop alias add upgrade 'scoop update $args[0]' 'Update apps, or Scoop itself'

# Update all apps
scoop alias add ua 'scoop update $args[0]' 'Update apps, or Scoop itself'
scoop alias add upgrade-all 'scoop update $args[0]' 'Update apps, or Scoop itself'

scoop install main/openssh
scoop install main/oh-my-posh
scoop install nerd-fonts/Cascadia-Code
scoop install nerd-fonts/JetBrainsMono-NF
scoop install nerd-fonts/FiraCode-NF

Write-Host "Clone dotfiles repository..." -ForegroundColor Cyan
git clone https://github.com/vadim1884321/dotfiles.git

if (-not (Test-Path "$HOME\dotfiles-config.ps1")) {
	Copy-Item "$HOME\dotfiles\windows\default_config.ps1" "$HOME\dotfiles-config.ps1"
}

Write-Host "Please complete the file ~/dotfiles_data.ps1" -ForegroundColor Blue
Write-Host "Next, run the ~/dotfiles/windows/main.ps1" -ForegroundColor Blue
