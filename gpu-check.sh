#!/bin/bash

if glxinfo | grep "Mesa Intel(R)" > /dev/null; then
    echo "<span color='purple'>integrated</span>" > /home/match/.config/i3status/gpu
else
    echo "<span color='purple'>discrete</span>" > /home/match/.config/i3status/gpu
fi
