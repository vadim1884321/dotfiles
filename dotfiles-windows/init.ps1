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

function clone($repo, $directory) {
		git clone --bare $repo $directory
}

function checkout($directory) {
		git --work-tree=$HOME --git-dir=$directory checkout
}

Admin-Check

$github="https://github.com/vadim1884321"

$win="$github/dotfiles.git"
$win_dir="$HOME/dotfiles"

Write-Host "# Installing git"
winget install --exact --silent Git.Git --accept-package-agreements

Write-Host "# Clone as a bare repository"
Write-Host $win
clone $win $win_dir -and checkout $win_dir

if (-not (Test-Path "$HOME/dotfiles-config.ps1")) {
		Copy-Item "$HOME/dotfiles/dotfiles-windows/default_config.ps1" "$HOME/dotfiles-config.ps1"
}

Write-Host "# Please complete the file $HOME/dotfiles-config.ps1"
Write-Host "# Next, run the ~/dotfiles/dotfiles-windows/main.ps1"
