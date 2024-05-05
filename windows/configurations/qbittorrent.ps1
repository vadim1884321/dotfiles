# qBittorrent
if (Test-Path -Path "$env:ProgramFiles\qBittorrent\qbittorrent.exe") {
	Write-Host "qBittorrent configuration..." -ForegroundColor "Yellow"

	Stop-Process -Name qBittorrent -Force -ErrorAction Ignore

	if (!(Test-Path -Path "$env:APPDATA\qBittorrent")) {
		New-Item "$env:APPDATA\qBittorrent" -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
	}
	Copy-Item -Path "$PSScriptRoot\..\qbittorrent\qBittorrent.ini" -Destination "$env:APPDATA\qBittorrent" -Force

	$Parameters = @{
		Uri             = "https://api.github.com/repos/witalihirsch/qBitTorrent-fluent-theme/releases/latest"
		UseBasicParsing = $true
		Verbose         = $true
	}
	$LatestVersion = (Invoke-RestMethod @Parameters).assets.browser_download_url | Where-Object -FilterScript { $_ -Match "/fluent-dark.qbtheme" }

	$Parameters = @{
		Uri     = $LatestVersion
		OutFile = "$env:APPDATA\qBittorrent\fluent-dark.qbtheme"
		Verbose = $true
	}
	Invoke-WebRequest @Parameters

	$qbtheme = (Resolve-Path -Path "$env:APPDATA\qBittorrent\fluent-dark.qbtheme").Path.Replace("\", "/")
	# Сохранить qBittorrent.ini в UTF8-BOM encoding
		(Get-Content -Path "$env:APPDATA\qBittorrent\qBittorrent.ini" -Encoding UTF8) -replace "General\\CustomUIThemePath=", "General\CustomUIThemePath=$qbtheme" | Set-Content -Path "$env:APPDATA\qBittorrent\qBittorrent.ini" -Encoding UTF8 -Force

	# Добавить qBittorrent в правила Брандмауэра Windows
	New-NetFirewallRule -DisplayName "qBittorent" -Direction Inbound -Program "$env:ProgramFiles\qBittorrent\qbittorrent.exe" -Action Allow | Out-Null
	New-NetFirewallRule -DisplayName "qBittorent" -Direction Outbound -Program "$env:ProgramFiles\qBittorrent\qbittorrent.exe" -Action Allow | Out-Null

	Write-Host "✔️ qBittorrent configuration is complete." -ForegroundColor "Green"
}
