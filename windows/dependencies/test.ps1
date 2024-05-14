Write-Warning "Installing Git..."
winget install --exact --silent Git.Git --accept-package-agreements

$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

git --version
