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
			# Write-Host "===========================================" -ForegroundColor Green
			# Write-Host "---        Winget is installed          ---" -ForegroundColor Green
			# Write-Host "===========================================" -ForegroundColor Green
			Write-Host "Version: $wingetVersionFull" -ForegroundColor White

			if (!$wingetPreview) {
				Write-Host "    - Winget is a release version." -ForegroundColor Green
			}
			else {
				Write-Host "    - Winget is a preview version. Unexpected problems may occur." -ForegroundColor Yellow
			}

			if (!$wingetOutdated) {
				Write-Host "    - Winget is Up to Date" -ForegroundColor Green
				$status = "installed"
			}
			else {
				Write-Host "    - Winget is Out of Date" -ForegroundColor Red
				$status = "outdated"
			}
		}
		else {
			Write-Section -Text "Winget is not installed" -Color Red
			# Write-Host "===========================================" -ForegroundColor Red
			# Write-Host "---      Winget is not installed        ---" -ForegroundColor Red
			# Write-Host "===========================================" -ForegroundColor Red
			$status = "not-installed"
		}
	}

	if ($choco) {
		if ((Get-Command -Name choco -ErrorAction Ignore) -and ($chocoVersion = (Get-Item "$env:ChocolateyInstall\choco.exe" -ErrorAction Ignore).VersionInfo.ProductVersion)) {
			Write-Section -Text "Chocolatey is installed" -Color Green
			# Write-Host "===========================================" -ForegroundColor Green
			# Write-Host "---      Chocolatey is installed        ---" -ForegroundColor Green
			# Write-Host "===========================================" -ForegroundColor Green
			Write-Host "Version: v$chocoVersion" -ForegroundColor White
			$status = "installed"
		}
		else {
			Write-Section -Text "Chocolatey is not installed" -Color Red
			# Write-Host "===========================================" -ForegroundColor Red
			# Write-Host "---    Chocolatey is not installed      ---" -ForegroundColor Red
			# Write-Host "===========================================" -ForegroundColor Red
			$status = "not-installed"
		}
	}

	if ($scoop) {
		if (Get-Command -Name scoop -ErrorAction Ignore) {
			Write-Section -Text "Scoop is installed" -Color Green
			# Write-Host "===========================================" -ForegroundColor Green
			# Write-Host "---      Chocolatey is installed        ---" -ForegroundColor Green
			# Write-Host "===========================================" -ForegroundColor Green
			# Write-Host "Version: v$scoopVersion" -ForegroundColor White
			$status = "installed"
		}
		else {
			Write-Section -Text "Scoop is not installed" -Color Red
			# Write-Host "===========================================" -ForegroundColor Red
			# Write-Host "---    Chocolatey is not installed      ---" -ForegroundColor Red
			# Write-Host "===========================================" -ForegroundColor Red
			$status = "not-installed"
		}
	}

	return $status
}
