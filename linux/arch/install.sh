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

source ./arch/.install/global_fn.sh
source ./arch/.install/locale.sh
source ./arch/.install/repo.sh
source ./arch/.install/pacman.sh
source ./arch/.install/install_aur.sh
source ./arch/.install/paru.sh
source ./arch/.install/zsh.sh
source ./arch/.install/test.sh
# source .install/install_shell.sh
