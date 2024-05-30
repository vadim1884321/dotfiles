#!/bin/bash
#|---/ /+------------------+---/ /|#
#|--/ /-| Global functions |--/ /-|#
#|-/ /--| Prasanth Rangan  |-/ /--|#
#|/ /---+------------------+/ /---|#

set -e

aurList=(yay paru)
shlList=(zsh fish)
# chk_list "aurhlpr" "${aurList[@]}"

_isInstalledPacman() {
	package="$1"
	check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")"
	if [ -n "${check}" ]; then
		echo 0 #'0' means 'true' in Bash
		return #true
	fi
	echo 1 #'1' means 'false' in Bash
	return #false
}

pkg_installed() {
	local PkgIn=$1

	if pacman -Qi "${PkgIn}" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

chk_list() {
	vrType="$1"
	local inList=("${@:2}")
	for pkg in "${inList[@]}"; do
		if pkg_installed "${pkg}"; then
			printf -v "${vrType}" "%s" "${pkg}"
			export "${vrType?}"
			return 0
		fi
	done
	return 1
}

pkg_available() {
	local PkgIn=$1

	if pacman -Si "${PkgIn}" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

aur_available() {
	local PkgIn=$1

	if ${aurhlpr} -Si "${PkgIn}" &>/dev/null; then
		return 0
	else
		return 1
	fi
}

install_package() {
	local PkgIn=$1
	if pkg_installed "${pkg}"; then
		echo -e "\033[0;33m[Skip]\033[0m ${pkg} is already installed..."
	elif pkg_available "${pkg}"; then
		repo=$(pacman -Si "${pkg}" | awk -F ': ' '/Repository / {print $2}')
		echo -e "\033[0;32m[${repo}]\033[0m queueing ${pkg} from official arch repo..."
		archPkg+=("${pkg}")
	elif aur_available "${pkg}"; then
		echo -e "\033[0;34m[aur]\033[0m queueing ${pkg} from arch user repo..."
		aurhPkg+=("${pkg}")
	else
		echo "Error: unknown package ${pkg}..."
	fi

	if [[ ${#archPkg[@]} -gt 0 ]]; then
		sudo pacman -S --noconfirm "${archPkg[@]}"
	fi

	if [[ ${#aurhPkg[@]} -gt 0 ]]; then
		"${aurhlpr}" -S --noconfirm "${aurhPkg[@]}"
	fi
}

prompt_timer() {
	set +e
	unset promptIn
	local timsec=$1
	local msg=$2
	while [[ ${timsec} -ge 0 ]]; do
		echo -ne "\r :: ${msg} (${timsec}s) : "
		read -t 1 -n 1 promptIn
		[ $? -eq 0 ] && break
		((timsec--))
	done
	export promptIn
	echo ""
	set -e
}
