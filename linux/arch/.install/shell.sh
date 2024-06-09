#!/bin/bash

shlList=(zsh fish)

if chk_list "myShell" "${shlList[@]}"; then
	echo -e "\033[0;33m[Skip]\033[0m ${myShell} is already installed..."
else
	echo -e "Select shell:\n[1] zsh\n[2] fish"
	prompt_timer 120 "Enter option number"

	case "${promptIn}" in
	1) export myShell="zsh" ;;
	2) export myShell="fish" ;;
	*)
		echo -e "...Invalid option selected..."
		exit 1
		;;
	esac

	sudo pacman -S --noconfirm "${myShell}"

	# if pkg_installed "${myShell}"; then
	# 	echo -e "\033[0;33m[Skip Shell]\033[0m ${myShell} is already installed..."
	# elif pkg_available "${myShell}"; then
	# 	repo=$(pacman -Si "${myShell}" | awk -F ': ' '/Repository / {print $2}')
	# 	echo -e "\033[0;32m[${repo}]\033[0m queueing ${myShell} from official arch repo..."
	# 	archPkg+=("${myShell}")
	# elif aur_available "${myShell}"; then
	# 	echo -e "\033[0;34m[aur]\033[0m queueing ${myShell} from arch user repo..."
	# 	aurhPkg+=("${myShell}")
	# else
	# 	echo "Error: unknown package ${myShell}..."
	# fi
fi
