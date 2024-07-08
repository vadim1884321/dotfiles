# Проверяет и устанавливает хранилище секретов
if (!(Get-SecretVault -Name SecretStore)) {
	Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault
}

# Устанавливает секрет Bitwarden Client ID
if (!(Get-Secret -Name BWAPIClient -Vault SecretStore -ErrorAction SilentlyContinue)) {
	$BWAPIClient = Read-Host $Localization.InputBWAPIClient -AsSecureString
	Set-Secret -Name BWAPIClient -Vault SecretStore -Secret $BWAPIClient
}

# Устанавливает секрет Bitwarden API token
if (!(Get-Secret -Name BWAPIClientSecret -Vault SecretStore -ErrorAction SilentlyContinue)) {
	$BWAPIClientSecret = Read-Host $Localization.InputBWAPIClientSecret -AsSecureString
	Set-Secret -Name BWAPIClientSecret -Vault SecretStore -Secret $BWAPIClientSecret
}

# Устанавливает секрет Bitwarden Password
if (!(Get-Secret -Name BWPassword -Vault SecretStore -ErrorAction SilentlyContinue)) {
	$BWPassword = Read-Host $Localization.InputBWPassword -AsSecureString
	Set-Secret -Name BWPassword -Vault SecretStore -Secret $BWPassword
}

# Get-BWSecret -BWSecretName username -BWSecretNote $true -SaveinPWVault $true -PWVaultSecretName username
