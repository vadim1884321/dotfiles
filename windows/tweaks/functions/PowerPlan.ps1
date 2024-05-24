<#
	.SYNOPSIS
	Power plan

	.PARAMETER High
	Set power plan on "High performance"

	.PARAMETER Balanced
	Set power plan on "Balanced"

	.EXAMPLE
	PowerPlan -High

	.EXAMPLE
	PowerPlan -Balanced

	.NOTES
	It isn't recommended to turn on for laptops

	.NOTES
	Current user
#>
function PowerPlan
{
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "High"
		)]
		[switch]
		$High,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Balanced"
		)]
		[switch]
		$Balanced
	)

	switch ($PSCmdlet.ParameterSetName)
	{
		"High"
		{
			# Set High performance profile
			powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
		}
		"Balanced"
		{
			# Set Balanced profile
			powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
		}
	}
}
