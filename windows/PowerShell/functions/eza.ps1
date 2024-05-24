# https://github.com/eza-community/eza
# Проверяет установлена ли утилита eza
if (Get-Command eza -ErrorAction SilentlyContinue | Test-Path) {
	# Удаляет встроенный в Windows псевдоним ls
	Remove-Item alias:ls -ErrorAction SilentlyContinue
	function ls { eza -s=extension --icons --group-directories-first --git --git-ignore @args }
	function ls1 { ls --oneline @args }
	function l { ls -lbF @args }
	function ll { ls -la @args }
	function la { ls -lbhHigUmuSa @args }
	function lx { ls -lbhHigUmuSa@ @args }
	function tree { ls --tree @args }
	function lsd { ls -D @args }
	function lsf { ls -f @args }
}
else {
	function la { Get-ChildItem -Force @args }
	function lsd { Get-ChildItem -Directory -Force @args }
}
# if (Get-Command z -ErrorAction SilentlyContinue | Test-Path) {
# 	# Удаляет встроенный в Windows псевдоним ls
# 	Remove-Item alias:cd -ErrorAction SilentlyContinue
# 	function cd { Set-Location $(fzf --preview 'bat --color=always {}' --preview-window '~3') }
# }
