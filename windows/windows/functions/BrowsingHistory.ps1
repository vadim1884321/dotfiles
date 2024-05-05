<#
	.SYNOPSIS
	Browsing history in the Start menu

	.PARAMETER Hide
	Do not show websites from your browsing history in the Start menu

	.PARAMETER Show
	Show websites from your browsing history in the Start menu

	.EXAMPLE
	BrowsingHistory -Hide

	.EXAMPLE
	BrowsingHistory -Show

	.NOTES
	Windows 11 build 23451 (Dev) required

	.NOTES
	Current user
#>
function BrowsingHistory
{
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show
	)

	if ((Get-CimInstance -ClassName CIM_OperatingSystem).BuildNumber -lt 23451)
	{
		Write-Information -MessageData "" -InformationAction Continue
		Write-Verbose -Message $Localization.Skipped -Verbose

		return
	}

	switch ($PSCmdlet.ParameterSetName)
	{
		"Hide"
		{
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_RecoPersonalizedSites" -PropertyType DWord -Value 0 -Force
		}
		"Show"
		{
			Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_RecoPersonalizedSites" -Force -ErrorAction Ignore
		}
	}
}
