<#
	.SYNOPSIS
	Copilot button on the taskbar

	.PARAMETER Hide
	Hide Copilot button on the taskbar

	.PARAMETER Show
	Show Copilot button on the taskbar

	.EXAMPLE
	CopilotButton -Hide

	.EXAMPLE
	CopilotButton -Show

	.NOTES
	Current user
#>
function CopilotButton
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

	switch ($PSCmdlet.ParameterSetName)
	{
		"Hide"
		{
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCopilotButton" -PropertyType DWord -Value 0 -Force
		}
		"Show"
		{
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCopilotButton" -PropertyType DWord -Value 1 -Force
		}
	}
}
