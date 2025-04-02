#!/bin/bash

if [[ $(rfkill | grep "tpacpi_bluetooth_sw unblocked unblocked") ]]; then
    rfkill block 0
    echo "<span color='red'>off</span>" > /home/match/.config/i3status/bluetooth
else
    rfkill unblock 0
    echo "on" > /home/match/.config/i3status/bluetooth
fi
