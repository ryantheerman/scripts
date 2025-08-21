#!/bin/bash

# this script is used in conjunction with i3 shortcuts to change power profiles
# if I use the i3 shortcut to change to power-saver profile, the script checks if the laptop is on ac or battery power and sets the appropriate profile.
# if I select the balanced profile, same behavior as above.
# if I select the throughput-performance profile, it doesn't matter if I'm on ac or batt. profile simply changes.
#   should I then even call this script in the case of throughput-performance selection? I think not. not necessary.
#   decided after all to include the switch to throughput-performance in this script. not because it NEEDS to be here, but if I want to swap out the performance tuner at some point, I only need to change the script, rather than changing the script and the i3 config, where I was going to directly call tuned-adm directly. better this way.



# keypress occurs to either set profile to balances or power-saving
# I don't care which key it is.
# that keypress calls this script with either balanced or power-saver as the param


# store truth value of ac power on in a param
acIsOn=$(cat /sys/class/power_supply/AC/online)

# if param is "balanced"
if [ $1 == "balanced" ]; then
    # and ac is on
    if [ $acIsOn == 1 ]; then
        echo "<span color='orange'>balanced AC</span>" > /home/match/.config/i3status/power-profile
        killall -USR1 i3status
        tuned-adm profile balanced
    # or ac is off
    else
        echo "<span color='orange'>balanced BAT</span>" > /home/match/.config/i3status/power-profile
        killall -USR1 i3status
        tuned-adm profile balanced-battery
    fi
# if param is power-saving
elif [ $1 == "power-saving" ]; then
    # and ac is on
    if [ $acIsOn == 1 ]; then
        echo "power-saving AC" > /home/match/.config/i3status/power-profile
        killall -USR1 i3status
        tuned-adm profile laptop-ac-powersave
    # or ac is off
    else
        echo "power-saving BAT"  > /home/match/.config/i3status/power-profile
        killall -USR1 i3status
        tuned-adm profile laptop-battery-powersave
    fi
# if param is performance
elif [ $1 == "performance" ]; then
    echo "<span color='red'>performance</span>" > /home/match/.config/i3status/power-profile
    killall -USR1 i3status
    tuned-adm profile throughput-performance
fi
