#OpenSSH

Write-Host "Checking for Windows OpenSSH Client" -ForegroundColor Green
if ($(Get-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0).State -eq "NotPresent") {
	Write-Host "Installing Windows OpenSSH Client" -ForegroundColor Green
	Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0 -ErrorAction SilentlyContinue
}
else {
	Write-Host "Windows OpenSSH Client is already installed." -ForegroundColor Blue
}

Get-Service -Name ssh-agent | Set-Service -StartupType Automatic
Start-Service ssh-agent
