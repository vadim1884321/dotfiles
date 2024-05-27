#!/bin/bash

# Меняет стандартные репозитории
if [ -f /etc/pacman.d/mirrorlist ] && [ ! -f /etc/pacman.d/mirrorlist.backup ]; then
	echo -e "\033[0;32m[Repositories]\033[0m Changes the standard repositories..."

	if pkg_installed reflector; then
		echo -e "\033[0;33m[Skip]\033[0m reflector is already installed..."
	else
		sudo pacman -S --noconfirm reflector
	fi

	sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
	# Первоначальная настройка репозиториев, выбирает самые быстрые 5 серверов в России и записывает их в файл /etc/pacman.d/mirrorlist
	sudo reflector -c 'ru' -p 'https' -f 5 --save '/etc/pacman.d/mirrorlist'

	sudo sed -i "/^# --country France,Germany/c\--country 'ru'" /etc/xdg/reflector/reflector.conf
	# Включает и запускает сервисы Reflector в systemd
	sudo systemctl enable reflector.service
	sudo systemctl start reflector.service
	# Включает и запускает сервис таймер Reflector, который будет еженедельно проверять и измерять сервера и записывать в файл /etc/pacman.d/mirrorlist
	sudo systemctl enable reflector.timer
	sudo systemctl start reflector.timer

	pacman -Syu

else
	echo -e "\033[0;33m[Skip]\033[0m The repositories are already configured..."
fi
