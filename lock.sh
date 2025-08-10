#!/bin/bash

#if [[ $($HOME/scripts/readMoon.sh) == "ganymede" ]]; then
#    xscreensaver-command -lock
#elif [[ $($HOME/scripts/readMoon.sh) == "callisto" ]]; then
#    if [[ $(xrandr --query | grep "DP-1-6-8 connected") ]]; then
#        /home/match/projects/misc/i3lock-multimonitor/lock
#    else
#        lock_png=~/pictures/lock/lockscreen.png
#        if [[ -f $lock_png ]]; then
#            rm $lock_png
#        fi
#        flameshot screen -p $lock_png &>/dev/null
#        magick $lock_png -blur 0x24 $lock_png &>/dev/null
#        i3lock -i $lock_png &>/dev/null
#    fi
#fi
#       lock_png=~/pictures/lock/lockscreen.png
#        if [[ -f $lock_png ]]; then
#            rm $lock_png
#        fi
#        flameshot screen -p $lock_png &>/dev/null
#        magick $lock_png -blur 0x24 $lock_png &>/dev/null
#       i3lock -i $lock_png &>/dev/null

~/projects/misc/i3lock-multimonitor/lock

#lock_png=~/pictures/lock/lockscreen.png
#i3lock -i $lock_png &>/dev/null

