<#
	.SYNOPSIS
	Show Files from Office.com in File Explorer

	.PARAMETER Show
	Show Files from Office.com

	.PARAMETER Hide
	Do not show Files from Office.com

	.EXAMPLE
	ShowFilesOffice -Show

	.EXAMPLE
	ShowFilesOffice -Hide

	.NOTES
	Current user
#>
function ShowFilesOffice {
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
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name ShowCloudFilesInQuickAccess -PropertyType DWord -Value 1 -Force
		}
		"Hide" {
			New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name ShowCloudFilesInQuickAccess -PropertyType DWord -Value 0 -Force
		}
	}
}
