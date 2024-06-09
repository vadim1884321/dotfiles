#!/bin/bash
source ./packages.sh

chk_list "aurhlpr" "${aurList[@]}"
# Installation of main components
echo -e "\u001b[7m Installing packages for arch...\u001b[0m"

for PKG1 in "${common_packages[@]}" "${arch_packages[@]}"; do
	if $aurhlpr -Q "$PKG1" &>/dev/null; then
		echo -e "\033[0;33m[Skip]\033[0m $PKG1 is already installed..."
	else
		# Package not installed
		echo -e "\033[0;32m[$PKG1]\033[0m Installing $PKG1..."
		$aurhlpr -S --noconfirm "$PKG1"
		# Making sure package is installed
		if $aurhlpr -Q "$PKG1"; then
			echo -e "\033[0;32m[$PKG1]\033[0m $PKG1 was installed."
		else
			# Something is missing, exiting to review log
			echo -e "\033[0;31m[ERROR]\033[0m $PKG1 Package installation failed :("
			exit 1
		fi
	fi
done
