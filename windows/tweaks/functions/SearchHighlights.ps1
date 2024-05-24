<#
	.SYNOPSIS
	Search highlights

	.PARAMETER Hide
	Hide search highlights

	.PARAMETER Show
	Show search highlights

	.EXAMPLE
	SearchHighlights -Hide

	.EXAMPLE
	SearchHighlights -Show

	.NOTES
	Current user
#>
function SearchHighlights
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
			# Check whether "Ask Copilot" and "Find results in Web" (Web) were disabled. They also disable Search Highlights automatically
			# Due to "Set-StrictMode -Version Latest" we have to use GetValue()
			$BingSearchEnabled = ([Microsoft.Win32.Registry]::GetValue("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search", "BingSearchEnabled", $null))
			$DisableSearchBoxSuggestions = ([Microsoft.Win32.Registry]::GetValue("HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer", "DisableSearchBoxSuggestions", $null))
			if (($BingSearchEnabled -eq 1) -or ($DisableSearchBoxSuggestions -eq 1))
			{
				Write-Information -MessageData "" -InformationAction Continue
				Write-Verbose -Message $Localization.Skipped -Verbose

				return
			}
			else
			{
				New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -PropertyType DWord -Value 0 -Force
			}
		}
		"Show"
		{
			# Enable "Ask Copilot" and "Find results in Web" (Web) icons in Windows Search in order to enable Search Highlights
			Remove-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Force -ErrorAction Ignore
			Remove-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Force -ErrorAction Ignore

			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -PropertyType DWord -Value 1 -Force
		}
	}
}
