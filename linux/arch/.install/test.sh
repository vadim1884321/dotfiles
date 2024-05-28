#!/bin/bash
chk_list "aurhlpr" "${aurList[@]}"
p="curl"
# install_package bat
# if pkg_installed curl; then
# 	echo -e "\033[0;33m[Skip]\033[0m curl is already installed..."
# 	install_package "$pkg"
# fi
install_package "curl"
