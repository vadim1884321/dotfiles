function Write-Section {
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $true)]
		[string]$Text,

		[Parameter()]
		[string]$Color = "Green"
	)
	Write-Host "===================================================================" -ForegroundColor $Color
	Write-Host "   $Text " -ForegroundColor $Color
	Write-Host "===================================================================" -ForegroundColor $Color
}
Write-Section "Downloading Files..." -Color Green
Write-Section "Chocolatey failed to install" -Color Green
