#!/bin/bash

if chk_list "aurhlpr" "${aurList[@]}"; then
	echo -e "\033[0;33m[Skip]\033[0m ${aurhlpr} is already installed..."
else
	echo -e "Available aur helpers:\n[1] yay\n[2] paru"
	prompt_timer 120 "Enter option number"

	case "${promptIn}" in
	1) export aurhlpr="yay" ;;
	2) export aurhlpr="paru" ;;
	*)
		echo -e "...Invalid option selected..."
		exit 1
		;;
	esac

	if pkg_installed base-devel; then
		echo -e "\033[0;33m[Skip]\033[0m base-devel is already installed..."
	else
		sudo pacman -S --noconfirm base-devel
	fi

	if [ -d "$HOME/Clone" ]; then
		echo "$HOME/Clone directory exists..."
		rm -rf "$HOME/Clone/${aurhlpr}"
	else
		mkdir "$HOME/Clone"
		echo "$HOME/Clone directory created..."
	fi

	if pkg_installed git; then
		git clone "https://aur.archlinux.org/${aurhlpr}.git" "$HOME/Clone/${aurhlpr}"
	else
		echo "git dependency is not installed..."
	fi

	cd "$HOME/Clone/${aurhlpr}" || exit
	makepkg -si --noconfirm
	cd "$HOME" || exit
	rm -rf "$HOME/Clone"

	echo -e "\033[0;32m[${aurhlpr}]\033[0m aur helper installed..."
fi
