<#
	.SYNOPSIS
	Classic Windows context menu

	.PARAMETER Disable
	Disable classic Windows context menu

	.PARAMETER Enable
	Enable classic Windows context menu

	.EXAMPLE
	ClassicContextMenu -Enable

	.EXAMPLE
	ClassicContextMenu -Disable

	.NOTES
	Current user
#>
function ClassicContextMenu {
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable
	)

	switch ($PSCmdlet.ParameterSetName) {
		"Enable" {
			if (-not (Test-Path -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}")) {
				New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Name "InprocServer32" -Force -Value ""
			}
		}
		"Disable" {
			Remove-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Recurse -Force -ErrorAction Ignore
		}
	}
}
