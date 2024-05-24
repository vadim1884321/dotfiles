<#
	.SYNOPSIS
	Gallery in Windows explorer

	.PARAMETER Disable
	Hide gallery in Windows explorer

	.PARAMETER Enable
	Show gallery in Windows explorer

	.EXAMPLE
	Gallery -Hide

	.EXAMPLE
	Gallery -Show

	.NOTES
	Current user
#>
function Gallery {
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

	switch ($PSCmdlet.ParameterSetName) {
		"Hide" {
			if (Test-Path -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_41040327\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}") {
				Remove-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_41040327\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Recurse -Force -ErrorAction Ignore
			}
		}
		"Show" {
			New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace_41040327" -Name "{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Force -Value ""
		}
	}
}
