#!/bin/bash

# outputs ##
left_32="$(niri msg outputs | grep 'Dell Inc. DELL U3223QE 8M79K04' | awk '{print $7}' | tr -d '()')"
right_32="$(niri msg outputs | grep 'Dell Inc. DELL U3223QE 6F129P3' | awk '{print $7}' | tr -d '()')"
right_27="$(niri msg outputs | grep 'Dell Inc. DELL U2723QE 1SS19P3' | awk '{print $7}' | tr -d '()')"

echo $left_32
echo $right_32
echo $right_27

mpvpaper -o "no-audio --panscan=1.0" -n 1200 ALL $LIVE_WALLPAPER_WORKSPACE &
mpvpaper-backdrop -o "no-audio --panscan=1.0" -n 1200 ALL $LIVE_WALLPAPER_BACKDROP &


# distinct outputs
#mpvpaper -o "no-audio --panscan=1.0" -n 1200 eDP-1 $LIVE_WALLPAPER_WORKSPACE &
#mpvpaper-backdrop -o "no-audio --panscan=1.0" -n 1200 eDP-1 $LIVE_WALLPAPER_WORKSPACE &

#mpvpaper -o "no-audio --panscan=1.0" -n 1200 $left_32 $LIVE_WALLPAPER_BACKDROP &
#mpvpaper-backdrop -o "no-audio --panscan=1.0" -n 1200 $left_32 $LIVE_WALLPAPER_BACKDROP &

#mpvpaper -o "no-audio --panscan=1.0" -n 1200 $right_32 $LIVE_WALLPAPER_WORKSPACE &
#mpvpaper-backdrop -o "no-audio --panscan=1.0" -n 1200 $right_32 $LIVE_WALLPAPER_WORKSPACE &

#mpvpaper -o "no-audio --panscan=1.0" -n 1200 $right_27 $LIVE_WALLPAPER_BACKDROP &
#mpvpaper-backdrop -o "no-audio --panscan=1.0" -n 1200 $right_27 $LIVE_WALLPAPER_BACKDROP &
