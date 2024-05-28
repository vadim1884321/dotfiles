#!/bin/bash

#--------------------------------#
# import variables and functions #
#--------------------------------#
scrDir=$(dirname "$(realpath "$0")")
source "${scrDir}/global_fn.sh"
if [ $? -ne 0 ]; then
	echo "Error: unable to source global_fn.sh..."
	exit 1
fi

source ./global_fn.sh
source .install/locale.sh
source .install/repo.sh
source .install/pacman.sh
source .install/install_aur.sh
source .install/paru.sh
source .install/zsh.sh
source .install/test.sh
# source .install/install_shell.sh
