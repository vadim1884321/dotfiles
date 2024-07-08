# Ярлыки навигации
function dev { if (Test-Path ~\dev) { Set-Location ~\dev } }
function pro { if (Test-Path ~\projects) { Set-Location ~\projects } }
function pics { if (Test-Path ~\Pictures) { Set-Location ~\Pictures } }
function dt { if (Test-Path ~\Desktop) { Set-Location ~\Desktop } }
function docs { if (Test-Path ~\Documents) { Set-Location ~\Documents } }
function music { if (Test-Path ~\Music) { Set-Location ~\Music } }
function videos { if (Test-Path ~\Videos) { Set-Location ~\Videos } }
function dl { if (Test-Path ~\Downloads) { Set-Location ~\Downloads } }

# Время
function time { Get-Date -Format "HH:mm:ss" }

# Вычисление хэш-суммы файла
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

# Ярлыки для устройств
function HKLM: { Set-Location HKLM: }
function HKCU: { Set-Location HKCU: }
function Env: { Set-Location Env: }

function gcom {
	git add .
	git commit -m "$args"
}
function lazyg {
	git add .
	git commit -m "$args"
	git push
}
function Get-PubIP {
	(Invoke-WebRequest http://ifconfig.me/ip ).Content
}

function find-file($name) {
	Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
		$place_path = $_.directory
		Write-Output "${place_path}\${_}"
	}
}
function unzip ($file) {
	Write-Output("Extracting", $file, "to", $pwd)
	$fullFile = Get-ChildItem -Path $pwd -Filter .\cove.zip | ForEach-Object { $_.FullName }
	Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function grep($regex, $dir) {
	if ( $dir ) {
		Get-ChildItem $dir | select-string $regex
		return
	}
	$input | select-string $regex
}
function touch($file) {
	"" | Out-File $file -Encoding ASCII
}
function df {
	get-volume
}
function sed($file, $find, $replace) {
	(Get-Content $file).replace("$find", $replace) | Set-Content $file
}
function which($name) {
	Get-Command $name | Select-Object -ExpandProperty Definition
}
function export($name, $value) {
	set-item -force -path "env:$name" -value $value;
}
function pkill($name) {
	Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}
function pgrep($name) {
	Get-Process $name
}
function head {
	param($Path, $n = 10)
	Get-Content $Path -Head $n
}
function tail {
	param($Path, $n = 10)
	Get-Content $Path -Tail $n
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

function sci { scoop install @args }
function scs { scoop status }
function scls { scoop list }
function scf { scoop search @args }
function scu { scoop update @args }
function scua { scoop update * }
function scr { scoop uninstall @args }

function wgi { winget install -e -h --accept-package-agreements --accept-source-agreements @args }
function wgf { winget search @args }
function wgs { winget list --upgrade-available @args }
function wgls { winget list @args }
function wgu { winget upgrade -e -h --accept-package-agreements --accept-source-agreements @args }
function wgua { winget upgrade --all -h --force --accept-package-agreements --accept-source-agreements @args }
function wgr { winget uninstall -h --accept-source-agreements --disable-interactivity @args }
