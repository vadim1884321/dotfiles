# Connecting aliases to a profile file.
if (Test-Path "$PSScriptRoot\aliases.ps1") {
	. "$PSScriptRoot\aliases.ps1"
}

# connecting functions to a profile file.
if (Test-Path "$PSScriptRoot\functions.ps1") {
	. "$PSScriptRoot\functions.ps1"
}

# Load functions declarations from separate configuration file.
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
	oh-my-posh init pwsh --config "$PSScriptRoot\..\oh-my-posh\my-theme2.omp.json" | Invoke-Expression
	# oh-my-posh init pwsh --config "$HOME\scoop\apps\oh-my-posh\current\themes\powerlevel10k_lean.omp.json" | Invoke-Expression
}

if ((Get-Command starship -ErrorAction SilentlyContinue) -and (!(Get-Command oh-my-posh -ErrorAction SilentlyContinue))) {
	Invoke-Expression (&starship init powershell)
}

if (Get-Command fnm -ErrorAction SilentlyContinue) {
	fnm env --use-on-cd | Out-String | Invoke-Expression
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
	Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
}

$modules = ("git-aliases", "powershell-yaml")
$modules | ForEach-Object {
	if (Get-Module -ListAvailable -Name $_) {
		Import-Module $_ -DisableNameChecking
	}
}

if (Get-Module -ListAvailable -Name "PSReadLine") {
	Set-PSReadLineOption -PredictionSource HistoryAndPlugin
	Set-PSReadLineOption -PredictionViewStyle ListView
	Set-PSReadLineOption -EditMode Windows
	Set-PSReadLineKeyHandler -Key Tab -Function Complete
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

$env:FZF_DEFAULT_OPTS = '--height 50% --layout=reverse --border'

function ff {
	nvim $(fzf --preview 'bat --color=always {}' --preview-window '~3')
}

# Override PSReadLine's history search
# Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' `
# -PSReadlineChordReverseHistory 'Ctrl+r'
# Override default tab completion
# Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

function ytuu {
	## Шапка скрипта ##
	[System.Console]::Title = "Скачать видео с YouTube с помощью yt-dlp"

	## Предупреждение перед запуском ##
	Write-Host
	Write-Host "Перед запуском операции скачивания поместите в буфер обмена URL нужного ролика, канала или плейлиста" -ForegroundColor Cyan

	## Запуск цикла скрипта ##
	while ($true) {

		## Формирование меню скрипта ##
		Write-Host
		Write-Host "------------------------------------------------" -ForegroundColor Yellow
		Write-Host "   1. Скачать видео" -ForegroundColor Green
		Write-Host "   2. Скачать аудиодорожку в формате mp3" -ForegroundColor Green
		Write-Host "------------------------------------------------" -ForegroundColor Yellow
		Write-Host

		## Селектор ##
		$choice = Read-Host "Выберите вариант"
		Write-Host

		switch ($choice) {

			## Скачивание видео ##
			1 {
				$cmd = "-f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best --merge-output-format mp4 $(Get-Clipboard) -o video\%(title)s.%(ext)s"
				Start-Process -FilePath yt-dlp.exe -ArgumentList $cmd -Wait -NoNewWindow
			}

			## Скачивание mp3 ##
			2 {
				$cmd = "-x --audio-format mp3 --audio-quality 0 --embed-thumbnail $(Get-Clipboard) -o audio\%(title)s.%(ext)s"
				Start-Process -FilePath yt-dlp.exe -ArgumentList $cmd -Wait -NoNewWindow
			}

			## Неверный выбор ##
			default {
				Write-Host "Неверный выбор. Попробуйте снова." -ForegroundColor Red
				Write-Host
			}

		}
	}
}

function ncu {
	if (Get-Command npm -ErrorAction SilentlyContinue) {
		npx npm-check-updates $args
	}
}
function Add-NodeVersion {
	if (Get-Command node -ErrorAction SilentlyContinue) {
		node --version | Out-File -FilePath .\.node-version
	}
}
