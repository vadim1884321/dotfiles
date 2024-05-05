<#
	.SYNOPSIS
	Bing search in the Start Menu

	.PARAMETER Disable
	Disable Bing search in the Start Menu

	.PARAMETER Enable
	Enable Bing search in the Start Menu

	.EXAMPLE
	BingSearch -Disable

	.EXAMPLE
	BingSearch -Enable

	.NOTES
	Current user
#>
function BingSearch
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
			if (-not (Test-Path -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer"))
			{
				New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Force
			}
			New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -PropertyType DWord -Value 1 -Force

			Set-Policy -Scope User -Path "Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Type DWORD -Value 1
		}
		"Enable"
		{
			Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Force -ErrorAction Ignore
			Set-Policy -Scope User -Path "Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Type CLEAR
		}
	}
}
