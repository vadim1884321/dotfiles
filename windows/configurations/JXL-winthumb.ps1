# https://github.com/saschanaz/jxl-winthumb
Write-Host "JPEG XL thumbnail configuration..." -ForegroundColor "Yellow"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Determining the latest version of the library file
$tag = (Invoke-WebRequest -Uri "https://api.github.com/repos/saschanaz/jxl-winthumb/releases" -UseBasicParsing | ConvertFrom-Json)[0].tag_name

# Downloading the latest $tag version of the library file
$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
$Parameters = @{
	Uri             = "https://github.com/saschanaz/jxl-winthumb/releases/download/$tag/jxl_winthumb.dll"
	OutFile         = "$DownloadsFolder\jxl_winthumb.dll"
	UseBasicParsing = $true
	Verbose         = $true
}
Invoke-WebRequest @Parameters

# Library Registration
$regsvrp = Start-Process regsvr32.exe -ArgumentList "/s $DownloadsFolder\jxl_winthumb.dll" -PassThru
$regsvrp.WaitForExit(5000) | Out-Null # Wait (up to) 5 seconds
# 5 are the error code (ACCESS_DENIED)
if ($regsvrp.ExitCode -ne 0) {
	Write-Error "regsvr32 exited with error $($regsvrp.ExitCode)"
}
Remove-Item -Path "$DownloadsFolder\jxl_winthumb.dll" -Force

Write-Host "✔️ JPEG XL thumbnail configuration is complete." -ForegroundColor "Green"

# Set-Location $env:TEMP
# sudo regsvr32 $file
# Set-Location ~

# $download = "https://github.com/$repo/releases/download/$tag/$file"
# $name = $file.Split(".")[0]
# $zip = "$name-$tag.zip"
# $dir = "$name-$tag"

# Write-Host Dowloading latest release

# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
# Invoke-WebRequest $download -Out $zip

# Write-Host Extracting release files
# Expand-Archive $zip -Force

# # Cleaning up target dir
# Remove-Item $name -Recurse -Force -ErrorAction SilentlyContinue

# # Moving from temp dir to target dir
# Move-Item $dir\$name -Destination $name -Force

# # Removing temp files
# Remove-Item $zip -Force
# Remove-Item $dir -Recurse -Force
