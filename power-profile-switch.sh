#!/bin/bash

current_profile=$(tuned-adm active | awk '{print $4}')
echo "current profile: $current_profile"

# if we just plugged in
# and we're in BAT power-saving mode -> switch to AC power-saving mode
# or we're in BAT balanced mode -> switch to AC balanced mode
# or we're in performance mode (or any other mode) -> do nothing
# in any case, write the profile to the i3status data file
if [ $1 == "true" ]; then
#    echo "we're plugged in"
    if [ $current_profile == "laptop-battery-powersave" ]; then
        echo "power-saving AC" > /home/match/.config/i3status/power-profile
        killall -USR1 i3status
        tuned-adm profile laptop-ac-powersave
    elif [ $current_profile == "balanced-battery" ]; then
        echo "<span color='orange'>balanced AC</span>" > /home/match/.config/i3status/power-profile
        killall -USR1 i3status
        tuned-adm profile balanced
    fi  
# else if we just unplugged
# and we're in AC power saving-mode -> switch to BAT power-saving mode
# or we're in AC balanced mode -> switch to BAT balanced mode
# or we're in performance mode (or any other mode) -> do nothing
# in any case, write the profile to the i3status data file
elif [ $1 == "false" ]; then
#    echo "we're unplugged"
    if [ $current_profile == "laptop-ac-powersave" ]; then
        echo "power-saving BAT" > /home/match/.config/i3status/power-profile
        killall -USR1 i3status
        tuned-adm profile laptop-battery-powersave
    elif [ $current_profile == "balanced" ]; then
        echo "<span color='orange'>balanced BAT</span>" > /home/match/.config/i3status/power-profile
        killall -USR1 i3status
        tuned-adm profile balanced-battery
    fi
fi
