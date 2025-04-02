#!/bin/bash

if [[ $($HOME/scripts/readMoon.sh) == "ganymede" ]]; then
    if [[ $(glxinfo | grep "renderer string: Mesa Intel(R) Graphics") ]]; then
        if [[ $(xrandr --query | grep "DP-3-6-8 connected") ]]; then
            ~/.screenlayout/ganymede-docked-integrated.sh
        else
            ~/.screenlayout/ganymede-onboard-integrated.sh
        fi
    else
        xrandr --setprovideroutputsource modesetting NVIDIA-0
        if [[ $(xrandr --query | grep "DP-3-6-8 connected") ]]; then
            ~/.screenlayout/ganymede-docked-discrete.sh
        else
            ~/.screenlayout/ganymede-onboard-discrete.sh
        fi
    i3-msg restart
    fi
else
    if [[ $(xrandr --query | grep "DP-1-6-8 connected") ]]; then
        ~/.screenlayout/callisto-docked.sh
    else
        ~/.screenlayout/callisto-onboard.sh
    fi
    i3-msg restart
fi
