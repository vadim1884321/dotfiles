# Determine user profile parent directory.
$DotfilesPath = "$env:USERPROFILE\dotfiles\windows"

# Connecting aliases to a profile file.
if (Test-Path "$PSScriptRoot\aliases.ps1") {
	. $PSScriptRoot\aliases.ps1
}

# connecting functions to a profile file.
if (Test-Path "$DotfilesPath\powershell\functions.ps1") {
	. $DotfilesPath\powershell\functions.ps1
}

# Load functions declarations from separate configuration file.
# if (Test-Path "$ConfigPath\oh-my-posh\my-theme.omp.json") {
# 	. $ConfigPath\powershell\functions.ps1
# }

# Load functions declarations from separate configuration file.
if (Test-Path "$env:LOCALAPPDATA\Programs\oh-my-posh\bin\oh-my-posh.exe") {
	oh-my-posh init pwsh --config "$PSScriptRoot\..\oh-my-posh\my-theme.omp.json" | Invoke-Expression
}

$modules = ("git-aliases")
$modules | ForEach-Object {
	if (Get-Module -ListAvailable -Name $_) {
		Import-Module $_ -DisableNameChecking
	}
}
