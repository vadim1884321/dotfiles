#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Paru AUR Helper #

if [ -f /etc/paru.conf ] && [ ! -f /etc/paru.conf.backup ]; then
	echo -e "\033[0;32m[Paru]\033[0m setting up a paru..."

	sudo cp /etc/paru.conf /etc/paru.conf.backup
	sudo sed -i "/^#BottomUp/c\BottomUp" /etc/paru.conf

	paru
else
	echo -e "\033[0;33m[Skip]\033[0m paru is already configured..."
fi
