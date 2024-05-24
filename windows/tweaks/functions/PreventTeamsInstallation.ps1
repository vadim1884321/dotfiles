<#
	.SYNOPSIS
	Chat (Microsoft Teams) installation for new users

	.PARAMETER Enable
	Hide the Chat icon (Microsoft Teams) on the taskbar and prevent Microsoft Teams from installing for new users

	.PARAMETER Disable
	Show the Chat icon (Microsoft Teams) on the taskbar and remove block from installing Microsoft Teams for new users

	.EXAMPLE
	PreventTeamsInstallation -Enable

	.EXAMPLE
	PreventTeamsInstallation -Disable

	.NOTES
	Current user
#>
function PreventTeamsInstallation
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

	Clear-Variable -Name Task -ErrorAction Ignore

	switch ($PSCmdlet.ParameterSetName)
	{
		"Disable"
		{
			# Save string to run it as "NT SERVICE\TrustedInstaller"
			# Prevent Microsoft Teams from installing for new users
			$Task = "New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications -Name ConfigureChatAutoInstall -Value 0 -Type Dword -Force"
		}
		"Enable"
		{
			# Save string to run it as "NT SERVICE\TrustedInstaller"
			# Remove block from installing Microsoft Teams for new users
			$Task = "Remove-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications -Name ConfigureChatAutoInstall -Value 1 -Type Dword -Force"
		}
	}

	# Create a Scheduled Task to run it as "NT SERVICE\TrustedInstaller"
	$Parameters = @{
		TaskName = "BlockTeamsInstallation"
		Action   = New-ScheduledTaskAction -Execute powershell.exe -Argument "-WindowStyle Hidden -Command $Task"
	}
	Register-ScheduledTask @Parameters -Force

	$ScheduleService = New-Object -ComObject Schedule.Service
	$ScheduleService.Connect()
	$ScheduleService.GetFolder("\").GetTask("BlockTeamsInstallation").RunEx($null, 0, 0, "NT SERVICE\TrustedInstaller")

	# Remove temporary task
	Unregister-ScheduledTask -TaskName BlockTeamsInstallation -Confirm:$false
}
