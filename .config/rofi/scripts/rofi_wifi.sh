#!/usr/bin/env bash

# Rofi wifi menu
# Dependencies: rofi, NetworkManager

# Options
opt_wifi_on="  Turn on WiFi"
opt_wifi_off="  Turn off WiFi"
opt_disconnect_wifi="  Disconnect WiFi"
opt_conned_wifi="  Connect WiFi"
opt_cancel="  Cancel"
options="$opt_wifi_on\n$opt_wifi_off\n$opt_disconnect_wifi\n$opt_conned_wifi\n$opt_cancel"

wlan=$(nmcli dev | grep wifi | sed 's/ \{2,\}/|/g' | cut -d '|' -f1 | head -1)

# Helper functions

turnon_wifi() {
	nmcli radio wifi on
	notify-send "WiFi has been turned on"
}

turnoff_wifi() {
	nmcli radio wifi off
	notify-send "WiFi has been turned off"
}

disconnect_wifi() {
	nmcli device disconnect "$wlan"
	sleep 1
	connection_state=$(nmcli dev | grep wifi | sed 's/ \{2,\}/|/g' | cut -d '|' -f3 | head -1)
	if [ "$connection_state" = "disconnected" ]; then
		notify-send "WiFi has been disconnected"
	fi
}

select_network() {
	notify-send "Scanig networks, please hold"
	sleep 1
	bssid=$(nmcli device wifi list | sed -n '1!p' | cut -b 9- | rofi -m -1 -dmenu -l 10 -i -p "Select Wifi   " | cut -d' ' -f1)
}

enter_password() {
	password=$(echo " " | rofi -m -1 -dmenu -l 1 -p "Enter Password ")
}

connect_wifi() {
	nmcli device wifi connect "$bssid" password "$password" || nmcli device wifi connect "$bssid"
}

check_wifi() {
	notify-send "Checking connection, please hold"
	sleep 1
	current_wifi=$(nmcli dev | grep wifi | sed 's/ \{2,\}/|/g' | cut -d '|' -f4 | head -1)
	if ping -q -c 2 -W 2 google.com >/dev/null; then
		notify-send "Connected to $current_wifi successfully"
	else
		notify-send "Connection failed"
	fi
}

# Rofi menu
cases=$(echo -e "$options" | rofi -m -1 -dmenu -l 6 -i -p " ")
case "$cases" in
$opt_wifi_on*)
	turnon_wifi
	;;
$opt_wifi_off*)
	turnoff_wifi
	;;
$opt_disconnect_wifi*)
	disconnect_wifi
	;;
$opt_conned_wifi*)
	select_network
	enter_password
	connect_wifi
	check_wifi
	;;
$opt_cancel*)
	exit 0
	;;
esac
