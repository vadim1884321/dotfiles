#!/bin/bash

# Настраивает русскую локаль
if [ -f /etc/locale.gen ] && grep -Fxq "#ru_RU.UTF-8 UTF-8" /etc/locale.gen; then
	echo -e "\033[0;32m[Locale]\033[0m Setting up Russian language support..."

	sudo sed -i "/^#ru_RU.UTF-8 UTF-8/c\ru_RU.UTF-8 UTF-8" /etc/locale.gen
	sudo locale-gen
	sudo localectl set-locale ru_RU.UTF-8

	# Russian manual pages
	if pkg_installed man-pages-ru; then
		echo -e "\033[0;33m[Skip]\033[0m man-pages-ru is already installed..."
	else
		sudo pacman -S --noconfirm man-pages-ru
	fi
else
	echo -e "\033[0;33m[Skip]\033[0m Russian language support is already set up..."
fi
