# Define main function to remove Microsoft Edge components
function Remove-MicrosoftEdge {
	[CmdletBinding()]
	param()

	# Function to shutdown processes related to Microsoft Edge
	function Stop-EdgeProcesses {
		$EdgeProcessesToShutdown | ForEach-Object {
			Stop-Process -Name $_ -Force -ErrorAction SilentlyContinue
		}
	}

	# Function to remove registry entries related to Microsoft Edge
	function Remove-EdgeRegistryEntries {
		# Clean up certain registry entries
		Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\msedge.exe" -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ie_to_edge_stub.exe" -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path 'Registry::HKEY_Users\S-1-5-21*\Software\Classes\microsoft-edge' -Recurse -ErrorAction SilentlyContinue
		Remove-Item -Path 'Registry::HKEY_Users\S-1-5-21*\Software\Classes\MSEdgeHTM' -Recurse -ErrorAction SilentlyContinue

		# Create new registry entries
		$EdgeExecutablePath = ($env:ProgramFiles, ${env:ProgramFiles(x86)})[[Environment]::Is64BitOperatingSystem] + '\Microsoft\Edge\Application\msedge.exe'
		New-Item -Path "HKLM:\SOFTWARE\Classes\microsoft-edge\shell\open\command" -Force -ErrorAction SilentlyContinue
		Set-ItemProperty -Path "HKLM:\SOFTWARE\Classes\microsoft-edge\shell\open\command" -Name '(Default)' -Value "`"$EdgeExecutablePath`" --single-argument %%1" -Force -ErrorAction SilentlyContinue

		New-Item -Path "HKLM:\SOFTWARE\Classes\MSEdgeHTM\shell\open\command" -Force -ErrorAction SilentlyContinue
		Set-ItemProperty -Path "HKLM:\SOFTWARE\Classes\MSEdgeHTM\shell\open\command" -Name '(Default)' -Value "`"$EdgeExecutablePath`" --single-argument %%1" -Force -ErrorAction SilentlyContinue
	}

	# Function to remove Microsoft Edge AppX packages
	function Remove-EdgeAppxPackages {
		$EdgeRemovalOptions.RemoveAppx | ForEach-Object {
			# Remove provisioned packages
			Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -like "*$_*" -and $EdgeRemovalOptions.Skip -notcontains $_.PackageName } | Remove-AppxProvisionedPackage -Online -AllUsers -ErrorAction SilentlyContinue

			# Remove installed packages
			Get-AppxPackage -AllUsers | Where-Object { $_.PackageFullName -like "*$_*" -and $EdgeRemovalOptions.Skip -notcontains $_.PackageFullName } | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
		}
	}

	# Function to remove Microsoft Edge processes, registry entries, and AppX packages
	try {
		Stop-EdgeProcesses
		Remove-EdgeRegistryEntries
		Remove-EdgeAppxPackages
		Write-Output "Microsoft Edge components have been successfully removed."
	}
 catch {
		Write-Error "Failed to remove Microsoft Edge components: $_"
	}
}

# Execute the main function
Remove-MicrosoftEdge
