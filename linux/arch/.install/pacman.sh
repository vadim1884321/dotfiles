#!/bin/bash
# 💫 https://github.com/vadim1884321 💫 #
# setting up a pacman #

if [ -f /etc/pacman.conf ] && [ ! -f /etc/pacman.conf.backup ]; then
	echo -e "\033[0;32m[Pacman]\033[0m setting up a pacman..."

	sudo cp /etc/pacman.conf /etc/pacman.conf.backup
	sudo sed -i "/^#VerbosePkgLists/c\VerbosePkgLists
    /^#ParallelDownloads/c\ParallelDownloads = 5" /etc/pacman.conf
	sudo sed -i '/^#\[multilib\]/,+1 s/^#//' /etc/pacman.conf

	# updating pacman.conf
	sudo pacman -Sy

else
	echo -e "\033[0;33m[Skip]\033[0m pacman is already configured..."
fi
