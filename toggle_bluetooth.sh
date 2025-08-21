#!/bin/bash

if [[ $(rfkill | grep "tpacpi_bluetooth_sw unblocked unblocked") || $(rfkill | grep "hci0           unblocked unblocked") ]]; then
    rfkill block 0
    echo "<span color='red'>bluetooth</span>" > /home/match/.config/i3status/bluetooth
else
    rfkill unblock 0
    echo "bluetooth" > /home/match/.config/i3status/bluetooth
fi
killall -USR1 i3status
