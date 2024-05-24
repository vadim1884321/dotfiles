<#
	.SYNOPSIS
	The "Open in Windows Terminal" item in the folders context menu

	.PARAMETER Hide
	Hide the "Open in Windows Terminal" item in the folders context menu

	.PARAMETER Show
	Show the "Open in Windows Terminal" item in the folders context menu

	.EXAMPLE
	OpenWindowsTerminalContext -Show

	.EXAMPLE
	OpenWindowsTerminalContext -Hide

	.NOTES
	Current user
#>
function OpenWindowsTerminalContext
{
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Show"
		)]
		[switch]
		$Show,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Hide"
		)]
		[switch]
		$Hide
	)

	if (-not (Get-AppxPackage -Name Microsoft.WindowsTerminal))
	{
		return
	}

	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{9F156763-7844-4DC4-B2B1-901F640F5155}" -Force -ErrorAction Ignore

	switch ($PSCmdlet.ParameterSetName)
	{
		"Show"
		{
			Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{9F156763-7844-4DC4-B2B1-901F640F5155}" -Force -ErrorAction Ignore
		}
		"Hide"
		{
			if (-not (Test-Path -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked"))
			{
				New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Force
			}
			New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{9F156763-7844-4DC4-B2B1-901F640F5155}" -PropertyType String -Value "" -Force
		}
	}
}
