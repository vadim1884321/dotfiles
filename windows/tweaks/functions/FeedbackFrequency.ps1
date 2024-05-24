<#
	.SYNOPSIS
	The feedback frequency

	.PARAMETER Never
	Change the feedback frequency to "Never"

	.PARAMETER Automatically
	Change feedback frequency to "Automatically"

	.EXAMPLE
	FeedbackFrequency -Never

	.EXAMPLE
	FeedbackFrequency -Automatically

	.NOTES
	Current user
#>
function FeedbackFrequency
{
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Never"
		)]
		[switch]
		$Never,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Automatically"
		)]
		[switch]
		$Automatically
	)

	switch ($PSCmdlet.ParameterSetName)
	{
		"Never"
		{
			if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Siuf\Rules"))
			{
				New-Item -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -PropertyType DWord -Value 0 -Force
		}
		"Automatically"
		{
			Remove-Item -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Force -ErrorAction Ignore
		}
	}
}
