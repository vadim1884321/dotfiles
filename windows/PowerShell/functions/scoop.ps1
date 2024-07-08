# Aliases for Scoop
# Install app(s)
scoop alias add i 'foreach ($_ in $args) {scoop install $_}' 'Alias for Install apps'
scoop alias add add 'foreach ($_ in $args) {scoop install $_}' 'Alias for Install apps'

# Clear cache
scoop alias add cc 'scoop cache rm *' 'Alias for Clear the entire cache'
scoop alias add clear 'scoop cache rm *' 'Alias for Clear the entire cache'

# Uninstall app(s)
scoop alias add rm 'foreach ($_ in $args) {scoop uninstall $_}' 'Alias for Uninstall apps'
scoop alias add remove 'foreach ($_ in $args) {scoop uninstall $_}' 'Alias for Uninstall apps'

# List apps
scoop alias add ls 'scoop list' 'Alias for List installed apps'

# Show status
scoop alias add s 'scoop status' 'Alias for Show status and check for new app versions'

# Update app(s)
scoop alias add u 'foreach ($_ in $args) {scoop update $_}' 'Alias for Update apps, or Scoop itself'
scoop alias add upgrade 'foreach ($_ in $args) {scoop update $_}' 'Alias for Update apps, or Scoop itself'

# Update all apps
scoop alias add ua 'scoop update *' 'Alias for Update apps, or Scoop itself'
scoop alias add upgrade-all 'scoop update *' 'Alias for Update apps, or Scoop itself'
