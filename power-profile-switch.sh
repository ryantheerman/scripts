#!/bin/bash

current_profile=$(tuned-adm active | awk '{print $4}')
echo "current profile: $current_profile"

# if we just plugged in
# and we're in BAT power-saving mode -> switch to AC power-saving mode
# or we're in BAT balanced mode -> switch to AC balanced mode
# or we're in performance mode -> do nothing
# in any case, write the profile to the i3status data file
if [ $1 == "true" ]; then
#    echo "we're plugged in"
    if [ $current_profile == "laptop-battery-powersave" ]; then
        tuned-adm profile laptop-ac-powersave
        echo "power-saving (ac)" > /home/match/.config/i3status/power-profile
    elif [ $current_profile == "balanced-battery" ]; then
        tuned-adm profile balanced
        echo "balanced (ac)" > /home/match/.config/i3status/power-profile
    elif [ $current_profile == "throughput-performance" ]; then
        echo "performance" > /home/match/.config/i3status/power-profile
    fi  
# else if we just unplugged
# and we're in AC power saving-mode -> switch to BAT power-saving mode
# or we're in AC balanced mode -> switch to BAT balanced mode
# or we're in performance mode -> do nothing
# in any case, write the profile to the i3status data file
elif [ $1 == "false" ]; then
#    echo "we're unplugged"
    if [ $current_profile == "laptop-ac-powersave" ]; then
        tuned-adm profile laptop-battery-powersave
        echo "power-saving (bat)" > /home/match/.config/i3status/power-profile
    elif [ $current_profile == "balanced" ]; then
        tuned-adm profile balanced-battery
        echo "balanced (bat)" > /home/match/.config/i3status/power-profile
    elif [ $current_profile == "throughput-performance" ]; then
        echo "performance" > /home/match/.config/i3status/power-profile
    fi
fi
