<#
	.SYNOPSIS
	Access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled

	.PARAMETER Enable
	Turn on access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled

	.PARAMETER Disable
	Turn off access to mapped drives from app running with elevated permissions with Admin Approval Mode enabled

	.EXAMPLE
	MappedDrivesAppElevatedAccess -Enable

	.EXAMPLE
	MappedDrivesAppElevatedAccess -Disable

	.NOTES
	Machine-wide
#>
function MappedDrivesAppElevatedAccess
{
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

	switch ($PSCmdlet.ParameterSetName)
	{
		"Enable"
		{
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -PropertyType DWord -Value 1 -Force
		}
		"Disable"
		{
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLinkedConnections" -Force -ErrorAction Ignore
		}
	}
}
