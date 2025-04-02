#!/bin/bash

if [[ $($HOME/scripts/readMoon.sh) == "ganymede" ]]; then
    xscreensaver-command -lock
elif [[ $($HOME/scripts/readMoon.sh) == "callisto" ]]; then

    if [[ $(xrandr --query | grep "DP-1-6-8 connected") ]]; then
        i3lock -c 000000
    else
        lock_png=~/pictures/lock/lockscreen.png
        if [[ -f $lock_png ]]; then
            rm $lock_png
        fi
        flameshot screen -p $lock_png &>/dev/null
        magick $lock_png -blur 0x24 $lock_png &>/dev/null
        i3lock -i $lock_png &>/dev/null
    fi
fi
