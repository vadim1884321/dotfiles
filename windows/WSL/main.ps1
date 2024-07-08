# Simple install script for Arch Linux in WSL
# More info at https://github.com/scottmckendry/ps-arch-wsl

#requires -RunAsAdministrator
#requires -Modules ps-arch-wsl

# Set-Location -Path $PSScriptRoot
if (Get-Secret -Name username -Vault SecretStore -ErrorAction SilentlyContinue) {
	$Username = Get-Secret -Name username -Vault SecretStore -AsPlainText
}
else {
	$Username = Get-BWSecret -BWSecretName username -BWSecretNote $true -SaveinPWVault $true -PWVaultSecretName username
}
Write-Host $Username
$Credential = Get-Credential -UserName "$Username"
Install-ArchWSL -Credential $Credential -PostInstallScript "$PSScriptRoot\arch-post-install.sh"
