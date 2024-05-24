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
	oh-my-posh init pwsh --config "$PSScriptRoot\..\oh-my-posh\my-theme2.omp.json" | Invoke-Expression
}
# Invoke-Expression (&starship init powershell)

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
	Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
}

$modules = ("git-aliases")
$modules | ForEach-Object {
	if (Get-Module -ListAvailable -Name $_) {
		Import-Module $_ -DisableNameChecking
	}
}

if (Get-Module -ListAvailable -Name "PSReadLine") {
	Set-PSReadLineOption -PredictionSource History
	Set-PSReadLineOption -PredictionViewStyle ListView
	Set-PSReadLineOption -EditMode Windows
	Set-PSReadLineKeyHandler -Key Tab -Function Complete
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

$env:FZF_DEFAULT_OPTS = '--height 50% --layout=reverse --border'

function ff {
	nvim $(fzf --preview 'bat --color=always {}' --preview-window '~3')
}

# Override PSReadLine's history search
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' `
	-PSReadlineChordReverseHistory 'Ctrl+r'
# Override default tab completion
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
