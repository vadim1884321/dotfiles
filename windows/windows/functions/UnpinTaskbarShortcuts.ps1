<#
	.SYNOPSIS
	Unpin shortcuts from the taskbar

	.PARAMETER Edge
	Unpin the "Microsoft Edge" shortcut from the taskbar

	.PARAMETER Store
	Unpin the "Microsoft Store" shortcut from the taskbar

	.EXAMPLE
	UnpinTaskbarShortcuts -Shortcuts Edge, Store

	.NOTES
	Current user
#>
function UnpinTaskbarShortcuts
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory = $true)]
		[ValidateSet("Edge", "Store")]
		[string[]]
		$Shortcuts
	)

	# Extract the localized "Unpin from taskbar" string from shell32.dll
	$LocalizedString = [WinAPI.GetStrings]::GetString(5387)

	foreach ($Shortcut in $Shortcuts)
	{
		switch ($Shortcut)
		{
			Edge
			{
				if (Test-Path -Path "$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk")
				{
					# Call the shortcut context menu item
					$Shell = (New-Object -ComObject Shell.Application).NameSpace("$env:AppData\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar")
					$Shortcut = $Shell.ParseName("Microsoft Edge.lnk")
					# Extract the localized "Unpin from taskbar" string from shell32.dll
					$Shortcut.Verbs() | Where-Object -FilterScript {$_.Name -eq "$([WinAPI.GetStrings]::GetString(5387))"} | ForEach-Object -Process {$_.DoIt()}
				}
			}
			Store
			{
				# Start-Job is used due to that the calling this function before UninstallUWPApps breaks the retrieval of the localized UWP apps packages names
				if ((New-Object -ComObject Shell.Application).NameSpace("shell:::{4234d49b-0245-4df3-b780-3893943456e1}").Items() | Where-Object -FilterScript {$_.Name -eq "Microsoft Store"})
				{
					Start-Job -ScriptBlock {
						# Extract the localized "Unpin from taskbar" string from shell32.dll
						((New-Object -ComObject Shell.Application).NameSpace("shell:::{4234d49b-0245-4df3-b780-3893943456e1}").Items() | Where-Object -FilterScript {
							$_.Name -eq "Microsoft Store"
						}).Verbs() | Where-Object -FilterScript {$_.Name -eq $using:LocalizedString} | ForEach-Object -Process {$_.DoIt()}
					} | Receive-Job -Wait -AutoRemoveJob
				}
			}
		}
	}
}
