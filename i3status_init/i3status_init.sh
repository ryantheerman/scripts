#!/bin/bash

# this script inits the i3status config file depending on the machine I'm on, as i want different modules for different machines

config_file=""

if [[ $($HOME/scripts/readMoon.sh) == "ganymede" ]]; then
    config_file=~/scripts/i3status_init/config_ganymede
elif [[ $($HOME/scripts/readMoon.sh) == "callisto" ]]; then
    config_file=~/scripts/i3status_init/config_callisto
fi

cat $config_file > ~/.config/i3status/config
