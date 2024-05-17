# Connecting aliases to a profile file.
if (Test-Path "$PSScriptRoot\aliases.ps1") {
	. "$PSScriptRoot\aliases.ps1"
}

# connecting functions to a profile file.
if (Test-Path "$PSScriptRoot\functions.ps1") {
	. "$PSScriptRoot\functions.ps1"
}

# Load functions declarations from separate configuration file.
if (Test-Path "$HOME\scoop\shims\oh-my-posh.exe") {
	oh-my-posh init pwsh --config "$PSScriptRoot\..\oh-my-posh\velvet.omp.json" | Invoke-Expression
}
# Invoke-Expression (&starship init powershell)

$modules = ("git-aliases")
$modules | ForEach-Object {
	if (Get-Module -ListAvailable -Name $_) {
		Import-Module $_ -DisableNameChecking
	}
}
