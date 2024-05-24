<#
	.SYNOPSIS
	Add support for JPEG-XL image format thumbnails

	.EXAMPLE
	JXLWinthumb

	.LINK
	https://github.com/saschanaz/jxl-winthumb

	.NOTES
	Current user
#>
function JXLWinthumb {
	try {
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
		Start-Process regsvr32.exe -ArgumentList "/s $DownloadsFolder\jxl_winthumb.dll" -PassThru -Wait

		Remove-Item -Path "$DownloadsFolder\jxl_winthumb.dll" -Force
	}
	catch {
		<#Do this if a terminating exception happens#>
	}
}

