#!/bin/bash

aurList=(yay paru)

if chk_list "aurhlpr" "${aurList[@]}"; then
	echo -e "\033[0;33m[Skip]\033[0m ${aurhlpr} is already installed..."
else
	echo -e "\u001b[32;1m Installation aur helpers...\u001b[0m"
	echo -e " \u001b[37;1m\u001b[4mSelect an option:\u001b[0m"
	echo -e "  \u001b[34;1m (1) Install Yay \u001b[0m"
	echo -e "  \u001b[34;1m (2) Install Paru \u001b[0m"
	echo -e "  \u001b[33;1m (*) Anything else to return main menu...\u001b[0m"
	echo -en "\u001b[32;1m ==> \u001b[0m"

	read -r option
	case $option in
	1) export aurhlpr="yay" ;;
	2) export aurhlpr="paru" ;;
	*)
		echo -e "\u001b[32;1m Return to main menu... \u001b[0m"
		source ./setup.sh
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

if [ "$aurhlpr" == "paru" ]; then
	if [ -f /etc/paru.conf ] && [ ! -f /etc/paru.conf.backup ]; then
		echo -e "\033[0;32m[Paru]\033[0m setting up a paru..."

		sudo cp /etc/paru.conf /etc/paru.conf.backup
		sudo sed -i "/^#BottomUp/c\BottomUp" /etc/paru.conf

		paru
	else
		echo -e "\033[0;33m[Skip]\033[0m paru is already configured..."
	fi
fi
