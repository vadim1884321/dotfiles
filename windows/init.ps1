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

Write-Warning "Installing Git..."
winget install --exact --silent Git.Git --accept-package-agreement

Write-Warning "Clone dotfiles repository..."
git clone git@github.com:vadim1884321/dotfiles.git

if (-not (Test-Path "$HOME/dotfiles-config.ps1")) {
	Copy-Item "$HOME/dotfiles/windows/default_config.ps1" "$HOME/dotfiles-config.ps1"
}

Write-Host "Please complete the file ~/dotfiles_data.ps1" -ForegroundColor Blue
Write-Host "Next, run the ~/dotfiles/windows/main.ps1" -ForegroundColor Blue
