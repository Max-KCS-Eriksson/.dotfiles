#!/usr/bin/env bash

# Rofi power menu
# Dependencies: rofi, power-profiles-daemon

# Options
opt_logout="  Logout"
opt_reboot="  Reboot"
opt_poweroff="  Power off"
opt_suspend="  Suspend"
opt_lock="  Lock"
opt_power_profile="  Change power profile"
opt_cancel="  Cancel"

options="$opt_logout\n$opt_reboot\n$opt_poweroff\n$opt_suspend\n$opt_lock\n$opt_power_profile\n$opt_cancel"

# Power profile options
pwr_opt_performance="  Performance"
pwr_opt_balanced="  Balanced"
pwr_opt_power_saver="  Power Saver"
pwr_opt_cancel="  Cancel"

pwrs="$pwr_opt_performance\n$pwr_opt_balanced\n$pwr_opt_power_saver\n$pwr_opt_cancel"

# Rofi menu
action=$(echo -e "$options" | rofi -m -1 -dmenu -l 7 -i -p " ")
case "$action" in
$opt_logout*)
	pkill X
	;;
$opt_reboot*)
	systemctl reboot || loginctl reboot || reboot
	;;
$opt_poweroff*)
	systemctl poweroff || loginctl poweroff || poweroff
	;;
$opt_suspend*)
	betterlockscreen --suspend
	;;
$opt_lock*)
	betterlockscreen -l
	;;
$opt_power_profile*)
	currentpwr=$(powerprofilesctl get)
	pwraction=$(echo -e "$pwrs" | rofi -m -1 -dmenu -l 4 -i -p "Current profile: ${currentpwr^} | Select profile")
	case "$pwraction" in
	$pwr_opt_performance*)
		powerprofilesctl set performance && notify-send "Power profile set to Performance"
		;;
	$pwr_opt_balanced*)
		powerprofilesctl set balanced && notify-send "Power profile set to Balanced"
		;;
	$pwr_opt_power_saver*)
		powerprofilesctl set power-saver && notify-send "Power profile set to Power saver"
		;;
	$pwr_opt_cancel*)
		exit 0
		;;
	esac
	;;
$opt_cancel*)
	exit 0
	;;
esac
