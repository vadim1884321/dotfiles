Function Install-Desktop-Apps {

	<#
    .SYNOPSIS
    Manages the provided programs using Winget

    .PARAMETER ProgramsToInstall
    A list of programs to manage

    .PARAMETER manage
    The action to perform on the programs, can be either 'Installing' or 'Uninstalling'

    .NOTES
    The triple quotes are required any time you need a " in a normal script block.
    The winget Return codes are documented here: https://github.com/microsoft/winget-cli/blob/master/doc/windows/package-manager/winget/returnCodes.md
    #>

	param(
		[Parameter(Mandatory, Position = 0)]
		[PsCustomObject]$ProgramsToInstall,

		[Parameter(Position = 1)]
		[String]$manage = "Installing"
	)

	Write-Host "==========================================="
	Write-Host "--    Configuring winget packages       ---"
	Write-Host "==========================================="
	Foreach ($Program in $ProgramsToInstall) {
		if ($manage -eq "Installing") {
			if ($null -ne $Program.source) {
				winget install -e -h $Program.id --source $Program.source --accept-package-agreements --accept-source-agreements
			}
			else {
				winget install -e -h $Program.id --accept-package-agreements --accept-source-agreements
			}
		}
		if ($manage -eq "Uninstalling") {
			# Uninstall package via ID using winget directly.
			winget uninstall --accept-source-agreements --disable-interactivity --id $($Program.id)
		}
	}
}
