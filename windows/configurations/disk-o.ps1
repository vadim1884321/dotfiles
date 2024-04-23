# Downloading the Disk-O
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if ($Host.Version.Major -eq 5)
{
	# Progress bar can significantly impact cmdlet performance
	# https://github.com/PowerShell/PowerShell/issues/2138
	$Script:ProgressPreference = "SilentlyContinue"
}

$DownloadsFolder = Get-ItemPropertyValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" -Name "{374DE290-123F-4565-9164-39C4925E467B}"
$Parameters = @{
	Uri     = "https://disko.hb.cldmail.ru/disko/Disk-O_setup_offline.exe"
	OutFile = "$DownloadsFolder\Disk-O_setup.exe"
	Verbose = $true
}
Invoke-WebRequest @Parameters

Start-Process -FilePath "$DownloadsFolder\Disk-O_setup.exe" -ArgumentList "/VERYSILENT" -Wait

Remove-Item -Path "$DownloadsFolder\Disk-O_setup.exe"
