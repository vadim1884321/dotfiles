oh-my-posh init pwsh --config "$HOME\dotfiles\dotfiles-windows\oh-my-posh\my-theme.omp.json" | Invoke-Expression

$dir="$HOME\dotfiles\dotfiles-windows\powershell"
"env", "vi_mode", "aliases", "bindings" | ForEach-Object { . "$dir\$_" }
