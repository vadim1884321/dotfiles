. "$PSScriptRoot\functions\eza.ps1"

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

# Obsidian авто синхронизация с git
function Sync-Obsidian {
	if ((Test-InternetConnection) -and (Test-Path -Path "$HOME\obsidian")) {
		try {
			Set-Location "$HOME\obsidian"
			if (Get-Command git -ErrorAction SilentlyContinue) {
				git pull
				$ChangedFiles = $(git status --porcelain | Measure-Object | Select-Object -expand Count)
				if ($ChangedFiles -gt 0) {
					git add .; git commit -q -m "♻️ Automatic Update"; git push -q
					# git add .; git commit -q -m "$(Get-Date -Format "dd MMMM yyyy HH:mm")"; git push -q
				}
				else {
					Write-Warning "Obsidian: Нет изменённых файлов"
				}
			}
			Set-Location -
		}
		catch {
			Write-Error "Obsidian: Синхронизация с git. Ошибка: $_"
		}
	}
}

# Скачивание видео c помощью утилиты "yt-dlp"
function Get-Video {
	param (
		[Parameter(Mandatory = $true)]
		[String]$Link
	)
	try {
		if (Test-InternetConnection) {
			if (Get-Command yt-dlp -ErrorAction SilentlyContinue) {
				# Скачивание видео
				$cmd = "-f bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best --merge-output-format mp4 $Link -o $HOME\Videos\%(title)s.%(ext)s"
				Start-Process -FilePath yt-dlp -ArgumentList $cmd -Wait -NoNewWindow
			}
			else {
				Write-Warning "Утилита 'yt-dlp' не установлена."
			}
		}
	}
	catch {
		throw $_.Exception.Message
	}
}

# Скачивание mp3 c помощью утилиты "yt-dlp"
function Get-Music {
	param (
		[Parameter(Mandatory = $true)]
		[String]$Link
	)
	try {
		if (Test-InternetConnection) {
			if (Get-Command yt-dlp -ErrorAction SilentlyContinue) {
				# Скачивание mp3
				$cmd = "-x --audio-format mp3 --audio-quality 0 --embed-thumbnail $Link -o $HOME\Music\%(title)s.%(ext)s"
				Start-Process -FilePath yt-dlp -ArgumentList $cmd -Wait -NoNewWindow
			}
			else {
				Write-Warning "Утилита 'yt-dlp' не установлена."
			}
		}
	}
	catch {
		throw $_.Exception.Message
	}
}
