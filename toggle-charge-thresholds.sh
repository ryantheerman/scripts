#!/bin/bash
charge_start_file=/sys/class/power_supply/BAT0/charge_start_threshold 
charge_stop_file=/sys/class/power_supply/BAT0/charge_stop_threshold 

if grep -q "0" $charge_start_file && grep -q "100" $charge_stop_file; then
	echo "defaults"
	echo 50 | sudo tee /sys/class/power_supply/BAT0/charge_start_threshold
	echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_stop_threshold
elif grep -q "50" $charge_start_file && grep -q "80" $charge_stop_file; then
	echo "battery saving"
fi
