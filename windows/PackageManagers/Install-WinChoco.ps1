<#
	.SYNOPSIS
	Installs Chocolatey if it is not already installed
#>
function Install-WinChoco {
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
		# Write-Host "===========================================" -Foregroundcolor Red
		# Write-Host "--     Chocolatey failed to install     ---" -Foregroundcolor Red
		# Write-Host "===========================================" -Foregroundcolor Red
	}
}
