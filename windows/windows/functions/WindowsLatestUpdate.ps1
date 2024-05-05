<#
	.SYNOPSIS
	Windows latest updates

	.PARAMETER Disable
	Do not get the latest updates as soon as they're available

	.PARAMETER Enable
	Get the latest updates as soon as they're available

	.EXAMPLE
	WindowsLatestUpdate -Disable

	.EXAMPLE
	WindowsLatestUpdate -Enable

	.NOTES
	Machine-wide
#>
function WindowsLatestUpdate
{
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Disable"
		)]
		[switch]
		$Disable,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Enable"
		)]
		[switch]
		$Enable
	)

	switch ($PSCmdlet.ParameterSetName)
	{
		"Disable"
		{
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "IsContinuousInnovationOptedIn" -PropertyType DWord -Value 0 -Force
		}
		"Enable"
		{
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "IsContinuousInnovationOptedIn" -PropertyType DWord -Value 1 -Force
		}
	}
}
