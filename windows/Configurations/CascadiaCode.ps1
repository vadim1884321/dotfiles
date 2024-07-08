<#
	.SYNOPSIS
	Font Cascadia Code from Microsoft

	.DESCRIPTION
	The script checks if the Cascadia Code font from Microsoft is installed and if it is not installed,
	then downloads it and installs it into the system

	.EXAMPLE
	.\CascadiaCode.ps1

	.LINK
	https://github.com/microsoft/cascadia-code

	.NOTES
	Current user
#>
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
