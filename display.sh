#!/bin/bash

if [[ $($HOME/scripts/readMoon.sh) == "ganymede" ]]; then
    if [[ $(glxinfo | grep "renderer string: Mesa Intel(R)") ]]; then
        if [[ $(xrandr --query | grep "DP-1-6-8 connected") ]]; then
            ~/.screenlayout/ganymede-docked-integrated.sh
        else
            ~/.screenlayout/ganymede-onboard-integrated.sh
        fi
    else
        if [[ $(xrandr --query | grep "DP-1-3-6-8 connected") ]]; then
            pkill picom
            ~/.screenlayout/ganymede-docked-discrete.sh
        else
            ~/.screenlayout/ganymede-onboard-discrete.sh
            ~/scripts/start-picom-if-not-running.sh
        fi
    fi
else
    if [[ $(xrandr --query | grep "DP-1-6-8 connected") ]]; then
        ~/.screenlayout/callisto-docked.sh
    else
        ~/.screenlayout/callisto-onboard.sh
    fi
fi



i3-msg restart
