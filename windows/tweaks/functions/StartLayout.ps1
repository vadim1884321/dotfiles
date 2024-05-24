<#
	.SYNOPSIS
	Configure Start layout

	.PARAMETER Default
	Show default Start layout

	.PARAMETER ShowMorePins
	Show more pins on Start

	.PARAMETER ShowMoreRecommendations
	Show more recommendations on Start

	.EXAMPLE
	StartLayout -Default

	.EXAMPLE
	StartLayout -ShowMorePins

	.EXAMPLE
	StartLayout -ShowMoreRecommendations

	.NOTES
	Current user
#>
function StartLayout
{
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Default"
		)]
		[switch]
		$Default,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "ShowMorePins"
		)]
		[switch]
		$ShowMorePins,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "ShowMoreRecommendations"
		)]
		[switch]
		$ShowMoreRecommendations
	)

	switch ($PSCmdlet.ParameterSetName)
	{
		"Default"
		{
			# Default
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -PropertyType DWord -Value 0 -Force
		}
		"ShowMorePins"
		{
			# Show More Pins
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -PropertyType DWord -Value 1 -Force
		}
		"ShowMoreRecommendations"
		{
			# Show More Recommendations
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -PropertyType DWord -Value 2 -Force
		}
	}
}
