<#
	.SYNOPSIS
	Installs Scoop if it is not already installed
#>
function Install-WinScoop {
	try {
		Write-Host "Checking if Scoop is Installed..."

		if ((Test-WinPackageManager -scoop) -eq "installed") {
			return
		}

		Write-Host "Seems Scoop is not installed, installing now."

		Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
		Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"
	}
	Catch {
		Write-Section -Text "Scoop failed to install" -Color Red
		# Write-Host "===========================================" -Foregroundcolor Red
		# Write-Host "--     Chocolatey failed to install     ---" -Foregroundcolor Red
		# Write-Host "===========================================" -Foregroundcolor Red
	}
}
