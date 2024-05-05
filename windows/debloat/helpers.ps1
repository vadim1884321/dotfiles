function Uninstall-AppPackage {
	[CmdletBinding()]
	param (
		[Parameter( Position = 0, Mandatory = $TRUE)]
		[String]
		$Name
	)

	try {
		Get-AppxPackage $Name -AllUsers | Remove-AppxPackage;
		Get-AppXProvisionedPackage -Online | Where-Object DisplayName -like $Name | Remove-AppxProvisionedPackage -Online;
	}
 catch {

	}
}

# Removes apps specified during function call from all user accounts and from the OS image.
function RemoveApps {
	param (
		$appslist
	)

	Foreach ($app in $appsList) {
		Write-Output "Attempting to remove $app..."

		if (($app -eq "Microsoft.OneDrive") -or ($app -eq "Microsoft.Edge")) {
			# Use winget to remove OneDrive and Edge
			if ($global:wingetInstalled -eq $false) {
				Write-Host "WinGet is not installed, app was not removed" -ForegroundColor Red
			}
			else {
				# Uninstall app via winget
				winget uninstall --accept-source-agreements --disable-interactivity --id $app
			}
		}
		else {
			# Use Remove-AppxPackage to remove all other apps
			$app = '*' + $app + '*'

			# Remove installed app for all existing users
			Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers

			# Remove provisioned app from OS image, so the app won't be installed for any new users
			Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -like $app } | ForEach-Object { Remove-ProvisionedAppxPackage -Online -AllUsers -PackageName $_.PackageName }
		}
	}
}

# Clear all pinned apps from the start menu.
# Credit: https://lazyadmin.nl/win-11/customize-windows-11-start-menu-layout/
function ClearStartMenu {
	param (
		$message
	)

	Write-Output $message

	# Path to start menu template
	# $startmenuTemplate = "$PSScriptRoot/Start/start2.bin"
	$startmenuTemplate = "$PSScriptRoot/../Start/start2.bin"

	# Get all user profile folders
	$usersStartMenu = get-childitem -path "C:\Users\*\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState"

	# Copy Start menu to all users folders
	ForEach ($startmenu in $usersStartMenu) {
		$startmenuBinFile = $startmenu.Fullname + "\start2.bin"

		# Check if bin file exists
		if (Test-Path $startmenuBinFile) {
			Copy-Item -Path $startmenuTemplate -Destination $startmenu -Force

			$cpyMsg = "Replaced start menu for user " + $startmenu.Fullname.Split("\")[2]
			Write-Output $cpyMsg
		}
		else {
			# Bin file doesn't exist, indicating the user is not running the correct version of Windows. Exit function
			Write-Output "Error: Start menu file not found. Please make sure you're running Windows 11 22H2 or later"
			return
		}
	}

	# Also apply start menu template to the default profile

	# Path to default profile
	$defaultProfile = "C:\Users\default\AppData\Local\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState"

	# Create folder if it doesn't exist
	if (-not(Test-Path $defaultProfile)) {
		new-item $defaultProfile -ItemType Directory -Force | Out-Null
		Write-Output "Created LocalState folder for default user"
	}

	# Copy template to default profile
	Copy-Item -Path $startmenuTemplate -Destination $defaultProfile -Force
	Write-Output "Copied start menu template to default user folder"
	Write-Output ""
}
