# Easier Navigation: .., ..., ...., ....., and ~
${function:~} = { Set-Location ~ }
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }
# function ~ { Set-Location ~ }
# function Set-ParentLocation = { Set-Location .. }

# Navigation Shortcuts
${function:dev} = { Set-Location ~\dev }
${function:pro} = { Set-Location ~\projects }
${function:pics} = { Set-Location ~\Pictures }
${function:dt} = { Set-Location ~\Desktop }
${function:docs} = { Set-Location ~\Documents }
${function:music} = { Set-Location ~\Music }
${function:videos} = { Set-Location ~\Videos }
${function:dl} = { Set-Location ~\Downloads }

${function:time} = { Get-Date -Format "HH:mm:ss" }

# Compute file hashes - useful for checking successful downloads
function md5 { Get-FileHash -Algorithm MD5 $args }
function sha1 { Get-FileHash -Algorithm SHA1 $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

# Drive shortcuts
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

# Git dotfiles
${function:config} = { git.exe --git-dir="$HOME\dotfiles.git\" --work-tree=$HOME @args }
${function:configs} = { config status -s --untracked-files=no }
${function:configc} = { Write-Host 'Configuration:'; config add ~/dotfiles; configs; config commit --untracked-files=no -a -m "Automatic update"; }

# Import-Module git-aliases -DisableNameChecking

# Stop & Restart the Windows explorer process
function Restart-Explorer {
	Write-Output "> Restarting Windows explorer to apply all changes. Note: This may cause some flickering."

	Start-Sleep 0.3

	Stop-Process -Name "explorer" -Force -ErrorAction SilentlyContinue

	Start-Sleep 0.3

	Start-Process -FilePath "explorer"

	Write-Output ""
}
