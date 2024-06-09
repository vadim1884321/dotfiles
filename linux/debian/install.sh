#!/bin/bash

if locale -a | grep ru; then
	echo "русский язык установлен"
else
	echo "русский язык не установлен"
fi
