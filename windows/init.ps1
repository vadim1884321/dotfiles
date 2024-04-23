#Requires -RunAsAdministrator

Write-Host 'Installing Windows Terminal...' -ForegroundColor 'Yellow';
winget install --exact --silent Microsoft.WindowsTerminal --accept-package-agreements

Write-Host 'Installing PowerShell...' -ForegroundColor 'Yellow';
winget install --exact --silent Microsoft.PowerShell --accept-package-agreements

# Copy-Item -Path "https://raw.githubusercontent.com/vadim1884321/dotfiles/main/windows/terminal/settings.json" -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Force

$Parameters = @{
  Uri             = "https://raw.githubusercontent.com/vadim1884321/dotfiles/main/windows/terminal/settings.json"
  OutFile         = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
  UseBasicParsing = $true
  Verbose         = $true
}
Invoke-WebRequest @Parameters -Force

Write-Host 'Installing git...' -ForegroundColor 'Yellow';
winget install --exact --silent Git.Git --accept-package-agreements

# Write-Host 'Clone dotfiles repository...' -ForegroundColor 'Yellow';
# git clone git@github.com:vadim1884321/dotfiles.git

# if (-not (Test-Path "$HOME/dotfiles_data.ps1")) {
# 	Copy-Item "$HOME/dotfiles/windows/default_data.ps1" "$HOME/dotfiles_data.ps1"
# }

Write-Host 'Please complete the file ~/dotfiles_data.ps1' -ForegroundColor 'Green';
Write-Host 'Next, run the ~/dotfiles/windows/main.ps1' -ForegroundColor 'Green';
