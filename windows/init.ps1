#Requires -RunAsAdministrator

Write-Warning "Installing Windows Terminal..."
winget install --exact --silent Microsoft.WindowsTerminal --accept-package-agreements

Write-Warning "Installing PowerShell..."
winget install --exact --silent Microsoft.PowerShell --accept-package-agreements

Write-Warning "Copy configuration for Windows Terminal..."
$Parameters = @{
	Uri             = "https://raw.githubusercontent.com/vadim1884321/dotfiles/main/windows/WindowsTerminal/settings.json"
	OutFile         = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
	UseBasicParsing = $true
	Verbose         = $true
}
Invoke-WebRequest @Parameters

# Installing Scoop package manager...
# https://github.com/ScoopInstaller/Install#for-admin
# If the Scoop file does not exist, go install it
if (-not (Test-Path -Path "$HOME\scoop\shims\scoop" -PathType Leaf)) {
	Write-Warning "Installing Scoop package manager..."
	Invoke-Expression "& {$(Invoke-RestMethod get.scoop.sh)} -RunAsAdmin"

	Write-Warning "Installing git and add buckets to scoop..."
	# 7Zip will be installed while installing git
	scoop install main/git
	scoop bucket add extras
	scoop bucket add nerd-fonts
	scoop update
	scoop install main/oh-my-posh nerd-fonts/Cascadia-Code
}
# If the file already exists, show the message and do nothing.
else {
	Write-Host "An existing Scoop installation was detected!" -ForegroundColor Green
}

Write-Warning "Clone dotfiles repository..."
git clone git@github.com:vadim1884321/dotfiles.git

if (-not (Test-Path "$HOME/dotfiles-config.ps1")) {
	Copy-Item "$HOME/dotfiles/windows/default_config.ps1" "$HOME/dotfiles-config.ps1"
}

Write-Host "Please complete the file ~/dotfiles_data.ps1" -ForegroundColor Blue
Write-Host "Next, run the ~/dotfiles/windows/main.ps1" -ForegroundColor Blue
