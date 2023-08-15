#!/bin/bash

source "$XDG_CONFIG_HOME/shell/common/extras/colors.sh"

CurrentDir=$PWD
# DayOfWeek=$(date +%u)

echo ''
neofetch

if [[ $(date +%u) -lt 6 && $(date +%k) -lt 18 ]]; then
	echo -e "${BRed}  Get to work! It's a weekday!${Color_Off}"
elif [[ $(date +%u) -lt 6 && $(date +%k) -gt 17 ]]; then
	echo -e "${BRed}  It's getting late, have some rest!${Color_Off}"
elif [[ $(date +%u) -gt 5 ]]; then
	echo -e "${BRed}  Don't work to hard! Enjoy your weekend!${Color_Off}"
fi

echo ''
echo -e "${BWhite}Currently in ${BBlue}${CurrentDir}${Color_Off}"
echo -e "${BWhite}Directory contents: ${Color_Off}"
ls -lFh --color=always

unset CurrentDir
