# NixOS
try {
	$oldEncoding = [Console]::OutputEncoding
	[Console]::OutputEncoding = [Text.Encoding]::Unicode  # on Windows: UTF-16 LE
	if (!(wsl -l | Where-Object { $_ -match "^NixOS" })) {
		[Console]::OutputEncoding = $oldEncoding
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

		Write-Host "NixOS WSL download and installation..." -ForegroundColor Cyan

		$repo = "nix-community/NixOS-WSL"
		$gitHubApiUrl = "https://api.github.com/repos/$repo/releases/latest"
		$tag = (Invoke-RestMethod -Uri $gitHubApiUrl).tag_name

		New-Item "$env:USERPROFILE\NixOS" -ItemType Directory -Force -ErrorAction SilentlyContinue

		$Parameters = @{
			Uri             = "https://github.com/$repo/releases/download/$tag/nixos-wsl.tar.gz"
			OutFile         = "$env:USERPROFILE\NixOS\nixos-wsl.tar.gz"
			UseBasicParsing = $true
			Verbose         = $true
		}
		Invoke-WebRequest @Parameters

		Set-Location $env:USERPROFILE\NixOS\
		wsl --import NixOS . .\nixos-wsl.tar.gz
		# wsl -d NixOS # Если нужно сделать дистрибутив по умолчанию

		Write-Host "NixOS installation is complete." -ForegroundColor Green
	}
	else {
		Write-Host "NixOS is already installed." -ForegroundColor Green
	}
}
catch {
	<#Do this if a terminating exception happens#>
}
