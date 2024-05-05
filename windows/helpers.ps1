# Function to test internet connectivity
function Test-InternetConnection {
	try {
		Test-Connection -TargetName ya.ru -Count 1 -ErrorAction Stop
		return $true
	}
	catch {
		Write-Warning "Internet connection is required but not available. Please check your connection."
		return $false
	}
}

# Stop & Restart the Windows explorer process
function Restart-Explorer {
	Write-Output "> Restarting Windows explorer to apply all changes. Note: This may cause some flickering."

	Start-Sleep 0.3

	Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue

	Start-Sleep 0.3

	Start-Process -FilePath "explorer"

	Write-Output ""
}

function Test-PathRegistryKey {
	[CmdletBinding()]
	param (
		[Parameter( Position = 0, Mandatory = $TRUE)]
		[String]
		$Path,

		[Parameter( Position = 1, Mandatory = $TRUE)]
		[String]
		$Name
	)

	try {
		Get-ItemPropertyValue -Path $Path -Name $Name;
		Return $TRUE;
	}
 catch {
		Return $FALSE;
	}
}
