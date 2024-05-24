<#
	.SYNOPSIS
	Stop error code when BSoD occurs

	.PARAMETER Enable
	Display Stop error code when BSoD occurs

	.PARAMETER Disable
	Do not display stop error code when BSoD occurs

	.EXAMPLE
	BSoDStopError -Enable

	.EXAMPLE
	BSoDStopError -Disable

	.NOTES
	Machine-wide
#>
function BSoDStopError
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
			New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "DisplayParameters" -PropertyType DWord -Value 1 -Force
		}
		"Disable"
		{
			New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\CrashControl" -Name "DisplayParameters" -PropertyType DWord -Value 0 -Force
		}
	}
}
