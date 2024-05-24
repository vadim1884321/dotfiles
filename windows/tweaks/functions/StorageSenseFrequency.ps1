<#
	.SYNOPSIS
	Storage Sense running frequency

	.PARAMETER Month
	Run Storage Sense every month

	.PARAMETER Default
	Run Storage Sense during low free disk space

	.EXAMPLE
	StorageSenseFrequency -Month

	.EXAMPLE
	StorageSenseFrequency -Default

	.NOTES
	Current user
#>
function StorageSenseFrequency
{
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Month"
		)]
		[switch]
		$Month,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Default"
		)]
		[switch]
		$Default
	)

	switch ($PSCmdlet.ParameterSetName)
	{
		"Month"
		{
			if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 01) -eq "1")
			{
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 2048 -PropertyType DWord -Value 30 -Force
			}
		}
		"Default"
		{
			if ((Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 01) -eq "1")
			{
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name 2048 -PropertyType DWord -Value 0 -Force
			}
		}
	}
}
