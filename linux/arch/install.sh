#!/usr/bin/env bash

if [ -d ~/dotfiles ] ;then
    echo "A ML4W Dotfiles installation has been detected."
    echo "This script will guide you through the update process of the ML4W Dotfiles."
else
    echo "This script will guide you through the installation process of the ML4W dotfiles."
fi
echo ""


#--------------------------------#
# import variables and functions #
#--------------------------------#
scrDir=$(dirname "$(realpath "$0")")
source "${scrDir}/helper_fn.sh"
if [ $? -ne 0 ]; then
    echo "Error: unable to source helper_fn.sh..."
    exit 1
fi



