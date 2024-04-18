function Admin-Check {
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

Admin-Check

Write-Host "# Installing git"
winget install --exact --silent Git.Git --accept-package-agreements

Write-Host "# Installing chezmoi"
winget install --exact --silent twpayne.chezmoi --accept-package-agreements

chezmoi init https://github.com/vadim1884321/dotfiles.git
