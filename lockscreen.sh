#!/bin/bash

lock_png=~/pictures/lock/lockscreen.png
#lock_png=~/pictures/backgrounds/puget_sound.png

if [[ -f $lock_png ]]; then
    rm $lock_png
fi

flameshot screen -p $lock_png &>/dev/null

magick $lock_png -blur 0x24 $lock_png &>/dev/null
#magick $lock_png -blur 0x2 $lock_png &>/dev/null

i3lock -i $lock_png &>/dev/null
