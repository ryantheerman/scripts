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
        tuned-adm profile balanced
        echo "balanced (ac)" > /home/match/.config/i3status/power-profile
    # or ac is off
    else
        tuned-adm profile balanced-battery
        echo "balanced (bat)" > /home/match/.config/i3status/power-profile
    fi
# if param is power-saving
elif [ $1 == "power-saving" ]; then
    # and ac is on
    if [ $acIsOn == 1 ]; then
        tuned-adm profile laptop-ac-powersave
        echo "power-saving (ac)" > /home/match/.config/i3status/power-profile
    # or ac is off
    else
        tuned-adm profile laptop-battery-powersave
        echo "power-saving (bat)"  > /home/match/.config/i3status/power-profile
    fi
# if param is performance
elif [ $1 == "performance" ]; then
    tuned-adm profile throughput-performance
    echo "performance" > /home/match/.config/i3status/power-profile
fi
