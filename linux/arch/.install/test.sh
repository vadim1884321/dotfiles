#!/bin/bash

echo -e "\u001b[32;1m Installation aur helpers...\u001b[0m"
echo -e " \u001b[37;1m\u001b[4mSelect an option:\u001b[0m"
echo -e "  \u001b[34;1m (1) Install Yay \u001b[0m"
echo -e "  \u001b[34;1m (2) Install Paru \u001b[0m"
echo -e "  \u001b[33;1m (*) Anything else to return main menu...\u001b[0m"
echo -en "\u001b[32;1m ==> \u001b[0m"

read -r option
case $option in
1) export aurhlpr="yay" ;;
2) export aurhlpr="paru" ;;
*)
	echo -e "\u001b[34;1m Return to main menu... \u001b[0m"
	source ./setup.sh
	;;
esac
