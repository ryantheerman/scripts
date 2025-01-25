#!/bin/bash

session_name="main" 

if xwininfo -id $(xdotool search -name "i3bar for output eDP-1") | grep IsViewable 2>/dev/null; then
    echo "bar is viewable"
else
    echo "bar is hidden"
fi
