<#
	.SYNOPSIS
	Open Windows Terminal in context menu as administrator

	.PARAMETER Enable
	Open Windows Terminal in context menu as administrator by default

	.PARAMETER Disable
	Do not open Windows Terminal in context menu as administrator by default

	.EXAMPLE
	OpenWindowsTerminalAdminContext -Enable

	.EXAMPLE
	OpenWindowsTerminalAdminContext -Disable

	.NOTES
	Current user
#>
function OpenWindowsTerminalAdminContext
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

	if (-not (Get-AppxPackage -Name Microsoft.WindowsTerminal))
	{
		return
	}

	if (-not (Test-Path -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"))
	{
		Start-Process -FilePath wt -PassThru
		Start-Sleep -Seconds 2
		Stop-Process -Name WindowsTerminal -Force -PassThru
	}

	try
	{
		$Terminal = Get-Content -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Encoding UTF8 -Force | ConvertFrom-Json
	}
	catch [System.ArgumentException]
	{
		Write-Error -Message ($Global:Error.Exception.Message | Select-Object -First 1) -ErrorAction SilentlyContinue

		Invoke-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"

		Write-Information -MessageData "" -InformationAction Continue
		Write-Verbose -Message $Localization.Skipped -Verbose

		return
	}

	switch ($PSCmdlet.ParameterSetName)
	{
		"Enable"
		{
			Remove-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{9F156763-7844-4DC4-B2B1-901F640F5155}" -ErrorAction Ignore
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" -Name "{9F156763-7844-4DC4-B2B1-901F640F5155}" -ErrorAction Ignore

			if ($Terminal.profiles.defaults.elevate)
			{
				$Terminal.profiles.defaults.elevate = $true
			}
			else
			{
				$Terminal.profiles.defaults | Add-Member -MemberType NoteProperty -Name elevate -Value $true -Force
			}
		}
		"Disable"
		{
			if ($Terminal.profiles.defaults.elevate)
			{
				$Terminal.profiles.defaults.elevate = $false
			}
			else
			{
				$Terminal.profiles.defaults | Add-Member -MemberType NoteProperty -Name elevate -Value $false -Force
			}
		}
	}

	# Save in UTF-8 with BOM despite JSON must not has the BOM: https://datatracker.ietf.org/doc/html/rfc8259#section-8.1. Unless Terminal profile names which contains non-Latin characters will have "?" instead of titles
	ConvertTo-Json -InputObject $Terminal -Depth 4 | Set-Content -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Encoding UTF8 -Force
}
