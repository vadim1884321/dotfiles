#!/bin/bash
chk_list "aurhlpr" "${aurList[@]}"

install_zsh_packages() {
	zsh_packages=(
		oh-my-zsh-git
		zsh-autosuggestions
		zsh-completions
		zsh-history-substring-search
		zsh-fast-syntax-highlighting
	)
	for pkg in "${zsh_packages[@]}"; do
		install_package "$pkg"
	done
}

if pkg_installed zsh; then
	echo -e "\033[0;33m[Skip]\033[0m zsh is already installed..."
	install_zsh_packages
else
	echo -e "\033[0;32m[ZSH]\033[0m installation zsh..."
	sudo pacman -S --noconfirm zsh
	install_zsh_packages
fi
