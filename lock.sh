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

#pactl set-sink-mute @DEFAULT_SINK@ 1
~/projects/misc/i3lock-multimonitor/lock
#sleep 2
#if pgrep -x i3lock >/dev/null; then
#	xdotool key Shift
#	if ! pgrep -x xidlehook >/dev/null; then
#		xidlehook --timer 10 'systemctl suspend' '' &
#	fi
#else
#	pkill xidlehook
#fi
#xidlehook --timer 10 'systemctl suspend' '' &
#sleep 10
#systemctl suspend

#lock_png=~/pictures/lock/lockscreen.png
#i3lock -i $lock_png &>/dev/null

