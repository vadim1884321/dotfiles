# Функция для проверки подключения к Интернету
function Test-InternetConnection {
	try {
		Test-Connection -TargetName ya.ru -Count 1 -ErrorAction Stop
		return $true
	}
	catch {
		Write-Warning "Интернет недоступен. Пожалуйста, проверьте своё подключение."
		return $false
	}
}

# Перезапуск проводника Windows
function Restart-Explorer {
	Write-Output "Перезапуск проводника Windows."

	Start-Sleep 0.3

	Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue

	Start-Sleep 0.3

	Start-Process -FilePath "explorer"

	Write-Output ""
}

# PowerShell 7 doesn't load en-us localization automatically if there is no localization folder in user's language which is determined by $PSUICulture
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-localizeddata?view=powershell-7.3
# https://github.com/PowerShell/PowerShell/pull/19896
try {
	Import-LocalizedData -BindingVariable Global:Localization -UICulture $PSUICulture -BaseDirectory $PSScriptRoot\Localizations -FileName Localizations -ErrorAction Stop
}
catch {
	Import-LocalizedData -BindingVariable Global:Localization -UICulture en-US -BaseDirectory $PSScriptRoot\Localizations -FileName Localizations
}

function Test-PathRegistryKey {
	[CmdletBinding()]
	param (
		[Parameter( Position = 0, Mandatory = $TRUE)]
		[String]
		$Path,

		[Parameter( Position = 1, Mandatory = $TRUE)]
		[String]
		$Name
	)

	try {
		Get-ItemPropertyValue -Path $Path -Name $Name;
		Return $TRUE;
	}
 catch {
		Return $FALSE;
	}
}

# Get-BWSecret -BWSecretName Test1 -SaveinPWVault $true -PWVaultSecretName Test3
function Get-BWSecret {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true)][String]$BWSecretName,
		[Parameter(Mandatory = $false)][bool]$BWSecretNote,
		[Parameter(Mandatory = $false)][bool]$SaveinPWVault,
		[Parameter(Mandatory = $false)][String]$PWVaultSecretName
	)
	$env:BW_CLIENTID = Get-Secret -Vault SecretStore -Name BWAPIClient -AsPlainText
	$env:BW_CLIENTSECRET = Get-Secret -Vault SecretStore -Name BWAPIClientSecret -AsPlainText
	$env:BW_PASSWORD = Get-Secret -Vault SecretStore -Name BWPassword -AsPlainText
	Write-Host $Localization.GetBWSecretRequest
	#BW
	[void](Invoke-Command -ScriptBlock { bw login --apikey })
	$unlockSesh = Invoke-Command -ScriptBlock { bw unlock --passwordenv BW_PASSWORD }
	$pwline = $unlockSesh | Select-Object -Last 4 | Select-Object -First 1
	$seshkey = $pwline.Split('"')[1]
	if ($BWSecretNote -ne $true) {
		$bwtopwsecret = Invoke-Command -ScriptBlock { bw get password "$BWSecretName" --session $seshkey }
	}
	else {
		$bwtopwsecret = Invoke-Command -ScriptBlock { bw get notes "$BWSecretName" --session $seshkey }
	}
	# $bwtopwsecret = Invoke-Command -ScriptBlock { bw get password "$BWSecretName" --session $seshkey }
	if ($SaveinPWVault -eq $true) {
		Set-Secret -Name $PWVaultSecretName -Secret $bwtopwsecret
	}
	else {
		$bwtopwsecret
	}
	[void](Invoke-Command -ScriptBlock { bw logout })
	# Очистка переменных окружения
	$env:BW_CLIENTID = ""
	$env:BW_CLIENTSECRET = ""
	$env:BW_PASSWORD = ""
}

function Install-Apps {
	param (
		$appslist
	)

	Write-Host $Localization.menuInstallApps -ForegroundColor Green
	Write-Host $lineSeparator -ForegroundColor Cyan

	foreach ($app in $appslist) {
		# Проверяет установлено ли уже приложение
		$listApp = winget list --exact -q $app.values
		if (![String]::Join("", $listApp).Contains($app.values)) {
			winget install --id $app.values -e -h --accept-package-agreements --accept-source-agreements
		}
		else {
			Write-Host $Localization.appSkippingInstall $app.keys
		}
	}
	# Обновляет пути переменных окружения
	$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
}

# Removes apps specified during function call from all user accounts and from the OS image.
function Remove-DebloatApps {
	[CmdletBinding()]
	param (
		$appslist
	)

	Write-host $Localization.menuRemoveDebloatApps -ForegroundColor Green
	Write-Host $lineSeparator -ForegroundColor Cyan

	Foreach ($app in $appsList) {
		Write-Output "Attempting to remove $app..."

		if (($app -eq "Microsoft.OneDrive") -or ($app -eq "Microsoft.Edge")) {
			winget uninstall -h --id $app --accept-source-agreements --disable-interactivity
		}
		else {
			# Use Remove-AppxPackage to remove all other apps
			$app = '*' + $app + '*'

			# Remove installed app for all existing users
			Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers

			# Remove provisioned app from OS image, so the app won't be installed for any new users
			Get-AppxProvisionedPackage -Online | Where-Object { $_.PackageName -like $app } | ForEach-Object { Remove-ProvisionedAppxPackage -Online -AllUsers -PackageName $_.PackageName }
		}
	}
}
