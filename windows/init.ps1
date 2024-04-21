function Test-Admin {
		if (!(Verify-Elevated)) {
				Write-Host 'You need to be an Admin to run this script.'
				exit
		}
}

function Verify-Elevated {
		# Get the ID and security principal of the current user account
		$myIdentity=[System.Security.Principal.WindowsIdentity]::GetCurrent()
		$myPrincipal=new-object System.Security.Principal.WindowsPrincipal($myIdentity)
		# Check to see if we are currently running "as Administrator"
		return $myPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Test-Admin;

# Checking whether winget is installed, if not, then installing it
Write-Host 'Checking whether winget is installed...' -ForegroundColor 'Yellow';

$hasPackageManager = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
if (!$hasPackageManager -or [version]$hasPackageManager.Version -lt [version]"1.10.0.0") {
	Write-Host 'Installing winget Dependencies'
	Add-AppxPackage -Path 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx'

	$releases_url = 'https://api.github.com/repos/microsoft/winget-cli/releases/latest'

	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
	$releases = Invoke-RestMethod -uri $releases_url
	$latestRelease = $releases.assets | Where { $_.browser_download_url.EndsWith('msixbundle') } | Select -First 1

	"Installing winget from $($latestRelease.browser_download_url)"
	Add-AppxPackage -Path $latestRelease.browser_download_url
}
else {
	Write-Host '✔️ winget already installed' -ForegroundColor 'Green';
}

Write-Host 'Installing git...' -ForegroundColor 'Yellow';
winget install --exact --silent Git.Git --accept-package-agreements

Write-Host 'Installing sudo...' -ForegroundColor 'Yellow';
winget install --exact --silent gerardog.gsudo --accept-package-agreements

Write-Host 'Clone repository...' -ForegroundColor 'Yellow';
git clone git@github.com:vadim1884321/dotfiles.git

if (-not (Test-Path "$env:USERPROFILE/dotfiles_data.ps1")) {
	Copy-Item "$env:USERPROFILE/dotfiles/windows/default_data.ps1" "$env:USERPROFILE/dotfiles_data.ps1"
}

Write-Host 'Please complete the file ~/dotfiles_data.ps1' -ForegroundColor 'Green';
Write-Host 'Next, run the ~/dotfiles/windows/main.ps1' -ForegroundColor 'Green';
