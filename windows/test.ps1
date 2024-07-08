# Requires -PSEdition Core
# Set-Secret -Name BWAPIClient
# $pwd_secure_string = Read-Host "Введите токен" -AsSecureString

# Set-Secret -Name test -Secret $pwd_secure_string

function Test-Test {
	Write-Host "Проверка"
}

function Show-Menu {
	param (
		[string]$Title = 'My Menu'
	)
	Clear-Host
	Write-Host "        ______________________________________________________________" -ForegroundColor Cyan

	Write-Host "`n                  $Title" -ForegroundColor Green

	Write-Host "`n              [1] " -ForegroundColor Yellow -NoNewline; Write-Host "Activate Microsoft Products" -ForegroundColor Blue
	Write-Host "              [2] " -ForegroundColor Yellow -NoNewline; Write-Host "Install Chocolatey Package Management Tool" -ForegroundColor Blue
	Write-Host "              [3] " -ForegroundColor Yellow -NoNewline; Write-Host "Install Scoop installer Management Tool" -ForegroundColor Blue
	Write-Host "              [4] " -ForegroundColor Yellow -NoNewline; Write-Host "Dev Environment Setup" -ForegroundColor Blue
	Write-Host "              [Q] " -ForegroundColor Yellow -NoNewline; Write-Host "Выход" -ForegroundColor Blue
	Write-Host "              __________________________________________________" -ForegroundColor Cyan

	Write-Host "`n              Author     :   Вадим"
	Write-Host "              License    :   MIT"
	Write-Host "        ______________________________________________________________" -ForegroundColor Cyan
}

do {
	Show-Menu –Title "Конфигурация Windows"
	Write-Host @"

            Введите пункт меню на клавиатуре [1,2,3,Q] для продолжения
"@ -NoNewline -ForegroundColor Green

	$Choice = Read-Host ' '

	switch ($Choice) {
		1 { Test-Test }
		2 { Install-Chocolatey -AppPath $ChocoPath -DownloadURL $ChocoURL }
		3 { Install-Scoop -AppPath $ScoopPath -App $ScoopApp -PS1File $ScoopPS1 }
	}
	pause
} until ($Choice -eq 'q')
