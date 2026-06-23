#!/usr/bin/env bash

if timeout 1 bluetoothctl show | grep -q "Powered: yes"; then
	echo "󰂯"
else
	echo "󰂲"
fi
