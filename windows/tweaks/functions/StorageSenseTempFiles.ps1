<#
	.SYNOPSIS
	Clean up of temporary files

	.PARAMETER Enable
	Turn on automatic cleaning up temporary system and app files

	.PARAMETER Disable
	Turn off automatic cleaning up temporary system and app files

	.EXAMPLE
	StorageSenseTempFiles -Enable

	.EXAMPLE
	StorageSenseTempFiles -Disable

	.NOTES
	Current user
#>
function StorageSenseTempFiles
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
			if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 01) -eq "1")
			{
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 04 -PropertyType DWord -Value 1 -Force
			}
		}
		"Disable"
		{
			if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 01) -eq "1")
			{
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 04 -PropertyType DWord -Value 0 -Force
			}
		}
	}
}
