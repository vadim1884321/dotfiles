# . ~\dotfiles-config.ps1
# . ~\dotfiles\dotfiles-windows\helpers.ps1

function Install-Desktop-Apps {
	param (
		$appslist
	)

	Foreach ($app in $appslist) {
		#check if the app is already installed
		$listApp = winget list --exact -q $app.name
		if (![String]::Join("", $listApp).Contains($app.name)) {
			Write-host "Installing:" $app.name
			if ($app.source -ne $null) {
				winget install --exact --silent $app.name --source $app.source --accept-package-agreements
			}
			else {
				winget install --exact --silent $app.name --accept-package-agreements
			}
		}
		else {
			Write-host "Skipping Install of " $app.name
		}
	}
}

# Устанавливает NuGet, если не установлен
function Install-Nuget {
	if (!(Get-PackageProvider-Installation-Status -PackageProviderName "NuGet")) {
		Write-Host "Installing NuGet as package provider..." -ForegroundColor Cyan
		Install-PackageProvider -Name "NuGet" -Force
	}
	else {
		Write-Host "NuGet is already installed." -ForegroundColor Green
	}
}

# Получает статус установлен ли пакетный провайдер
function Get-PackageProvider-Installation-Status {
	[CmdletBinding()]
	param(
		[Parameter(Position = 0, Mandatory = $true)]
		[string]
		$PackageProviderName
	)

	try {
		Get-PackageProvider -Name $PackageProviderName
		return $true
	}
	catch [Exception] {
		return $false
	}
}

# Устанавливает репозиторий PSGallery, если не установлен
function Install-PSGallery {
	if (-not (Get-PSRepository-Trusted-Status -PSRepositoryName "PSGallery")) {
		Write-Host "Setting up PSGallery as PowerShell trusted repository..." -ForegroundColor Cyan
		Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
	}
	else {
		Write-Host "PSGallery is already installed." -ForegroundColor Green
	}
}

# Получает статус установлен ли репозиторий
function Get-PSRepository-Trusted-Status {
	[CmdletBinding()]
	param(
		[Parameter(Position = 0, Mandatory = $TRUE)]
		[string]
		$PSRepositoryName
	)

	try {
		if (!(Get-PSRepository -Name $PSRepositoryName -ErrorAction SilentlyContinue)) {
			return $false
		}

		if ((Get-PSRepository -Name $PSRepositoryName).InstallationPolicy -eq "Trusted") {
			return $true
		}
		return $false
	}
	catch [Exception] {
		return $false
	}
}

function Install-PackageManagement {
	if (!(Get-Module-Installation-Status -ModuleName "PackageManagement" -ModuleMinimumVersion "1.4.6")) {
		Write-Host "Updating PackageManagement module..." -ForegroundColor Cyan
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		Install-Module -Name "PackageManagement" -Force -MinimumVersion "1.4.6" -Scope "CurrentUser" -AllowClobber -Repository "PSGallery"
	}
	else {
		Write-Host "PackageManagement is already installed." -ForegroundColor Green
	}
}

function Get-Module-Installation-Status {
	[CmdletBinding()]
	param(
		[Parameter(Position = 0, Mandatory = $true)]
		[string]
		$ModuleName,

		[Parameter(Position = 1, Mandatory = $false)]
		[string]
		$ModuleMinimumVersion
	)

	try {
		if (!([string]::IsNullOrEmpty($ModuleMinimumVersion))) {
			if ((Get-Module -ListAvailable -Name $ModuleName).Version -ge $ModuleMinimumVersion) {
				return $true
			}
			return $false
		}

		if (Get-Module -ListAvailable -Name $ModuleName) {
			return $true
		}
		else {
			return $false
		}
	}
	catch [Exception] {
		return $false
	}
}
Install-NuGet
Install-PSGallery
Install-PackageManagement
