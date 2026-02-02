#!/bin/bash

if xinput | grep 'id=11\s*\[slave\s*pointer' > /dev/null; then
    echo "touchscreen enabled. disabling..."
    xinput disable 11
    echo "<span color='red'>touch</span>" > ~/.config/i3status/touchscreen
    killall -USR1 i3status
else
    echo "touchscreen disabled. enabling..."
    xinput enable 11
    echo "touch" > ~/.config/i3status/touchscreen
    killall -USR1 i3status
fi
