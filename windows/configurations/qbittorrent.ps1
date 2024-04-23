# qBittorrent
if (Test-Path -Path "$env:ProgramFiles\qBittorrent")
{
	Stop-Process -Name qBittorrent -Force -ErrorAction Ignore

	# if (-not (Test-Path -Path "$env:APPDATA\qBittorrent"))
	# {
	# 	New-Item -Path "$env:APPDATA\qBittorrent" -ItemType "directory" -Force
	# }
	# Remove-Item -Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\qBittorrent" -Recurse -Force -ErrorAction Ignore

	Copy-Item -Path "$PSScriptRoot\..\qbittorrent\qBittorrent.ini" -Destination "$env:APPDATA\qBittorrent" -Force

	# $Parameters = @{
	# 	Uri             = "https://raw.githubusercontent.com/farag2/Utilities/master/qBittorrent/qBittorrent.ini"
	# 	OutFile         = "$env:APPDATA\qBittorrent\qBittorrent.ini"
	# 	UseBasicParsing = $true
	# 	Verbose         = $true
	# }
	# Invoke-WebRequest @Parameters

	# https://github.com/witalihirsch/qBitTorrent-fluent-theme
	$Parameters = @{
		Uri             = "https://api.github.com/repos/witalihirsch/qBitTorrent-fluent-theme/releases/latest"
		UseBasicParsing = $true
		Verbose         = $true
	}
	$LatestVersion = (Invoke-RestMethod @Parameters).assets.browser_download_url | Where-Object -FilterScript {$_ -Match "/fluent-dark.qbtheme"}

	$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
	$Parameters = @{
		Uri     = $LatestVersion
		OutFile = "$env:APPDATA\qBittorrent\fluent-dark.qbtheme"
		Verbose = $true
	}
	Invoke-WebRequest @Parameters

	$qbtheme = (Resolve-Path -Path "$env:APPDATA\qBittorrent\fluent-dark.qbtheme").Path.Replace("\", "/")
	# Save qBittorrent.ini in UTF8-BOM encoding to make it work with non-latin usernames
	(Get-Content -Path "$env:APPDATA\qBittorrent\qBittorrent.ini" -Encoding UTF8) -replace "General\\CustomUIThemePath=", "General\CustomUIThemePath=$qbtheme" | Set-Content -Path "$env:APPDATA\qBittorrent\qBittorrent.ini" -Encoding UTF8 -Force

	# Add to the Windows Defender Firewall exclusion list
	New-NetFirewallRule -DisplayName "qBittorent" -Direction Inbound -Program "$env:ProgramFiles\qBittorrent\qbittorrent.exe" -Action Allow
	New-NetFirewallRule -DisplayName "qBittorent" -Direction Outbound -Program "$env:ProgramFiles\qBittorrent\qbittorrent.exe" -Action Allow
}
