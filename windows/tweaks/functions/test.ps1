<#
	.SYNOPSIS
	File name extensions

	.PARAMETER Show
	Show file name extensions

	.PARAMETER Hide
	Hide file name extensions

	.EXAMPLE
	FileExtensions -Show

	.EXAMPLE
	FileExtensions -Hide

	.NOTES
	Current user
#>
function test {
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

	switch ($PSCmdlet.ParameterSetName) {
		"Show" {
			$location = @{Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'; Name = 'Settings' }
			$value = Get-ItemPropertyValue @location
			$value[8] = { 123 }
			Set-ItemProperty @location $value
			Stop-Process -Name Explorer
		}
		"Hide" {
			$location = @{Path = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'; Name = 'Settings' }
			$value = Get-ItemPropertyValue @location
			$value[8] = { 122 }
			Set-ItemProperty @location $value
			Stop-Process -Name Explorer
		}
	}
}
