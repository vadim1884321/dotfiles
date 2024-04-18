# Easier Navigation: .., ..., ...., ....., and ~
${function:~} = { Set-Location ~ }
${function:Set-ParentLocation} = { Set-Location .. }; Set-Alias ".." Set-ParentLocation
${function:...} = { Set-Location ..\.. }
${function:....} = { Set-Location ..\..\.. }
${function:.....} = { Set-Location ..\..\..\.. }
${function:......} = { Set-Location ..\..\..\..\.. }

# Navigation Shortcuts
${function:dev} = { Set-Location ~\dev }
${function:pro} = { Set-Location ~\projects }
${function:pics} = { Set-Location ~\Pictures }
${function:dt} = { Set-Location ~\Desktop }
${function:docs} = { Set-Location ~\Documents }
${function:music} = { Set-Location ~\Music }
${function:videos} = { Set-Location ~\Videos }
${function:dl} = { Set-Location ~\Downloads }

# Git dotfiles
${function:config} = { git.exe --git-dir="$HOME\dotfiles.git\" --work-tree=$HOME @args }
${function:configs} = { config status -s --untracked-files=no}
${function:configc} = { Write-Host 'Configuration:'; config add ~/dotfiles; configs; config commit --untracked-files=no -a -m "Automatic update";}

Import-Module git-aliases -DisableNameChecking
