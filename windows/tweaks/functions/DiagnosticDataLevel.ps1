# . "$PSScriptRoot\Set-Policy.ps1"
<#
	.SYNOPSIS
	Diagnostic data

	.PARAMETER Minimal
	Set the diagnostic data collection to minimum

	.PARAMETER Default
	Set the diagnostic data collection to default

	.EXAMPLE
	DiagnosticDataLevel -Minimal

	.EXAMPLE
	DiagnosticDataLevel -Default

	.NOTES
	Machine-wide
#>
function DiagnosticDataLevel
{
	param
	(
		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Minimal"
		)]
		[switch]
		$Minimal,

		[Parameter(
			Mandatory = $true,
			ParameterSetName = "Default"
		)]
		[switch]
		$Default
	)

	if (-not (Test-Path -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"))
	{
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force
	}

	if (-not (Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack"))
	{
		New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" -Force
	}

	switch ($PSCmdlet.ParameterSetName)
	{
		"Minimal"
		{
			if (Get-WindowsEdition -Online | Where-Object -FilterScript {($_.Edition -eq "Enterprise") -or ($_.Edition -eq "Education")})
			{
				# Diagnostic data off
				New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -PropertyType DWord -Value 0 -Force
				Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWORD -Value 0
			}
			else
			{
				# Send required diagnostic data
				New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -PropertyType DWord -Value 1 -Force
				Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWORD -Value 1
			}

			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "MaxTelemetryAllowed" -PropertyType DWord -Value 1 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" -Name "ShowedToastAtLevel" -PropertyType DWord -Value 1 -Force
		}
		"Default"
		{
			# Optional diagnostic data
			New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "MaxTelemetryAllowed" -PropertyType DWord -Value 3 -Force
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" -Name "ShowedToastAtLevel" -PropertyType DWord -Value 3 -Force
			Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Force -ErrorAction Ignore

			Set-Policy -Scope Computer -Path "SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type CLEAR
		}
	}
}
