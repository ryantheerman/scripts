#! /bin/zsh

# script to start up monitors

if [[ $(xrandr --query | grep "DP-1-6-8 connected") ]]; then
    echo "multi monitor"
    # check if required modes exist
    if [[ ! $(xrandr --query | grep "2560x1440_30.00") ]]; then
        # create the modes
        xrandr --newmode "2560x1440_30.00"  146.25  2560 2680 2944 3328  1440 1443 1448 1468 -hsync +vsync
        xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync

        # add the modes
        xrandr --addmode eDP-1 1920x1080_60.00
        xrandr --addmode DP-1-6-8 2560x1440_30.00
        xrandr --addmode DP-1-6-1-8 2560x1440_30.00
    fi
    
    # whether newly created or not, apply the display config with the custom modes
    xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1613x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-3 --off --output HDMI-3 --off --output DP-2-5 --off --output DP-2-6 --off --output DP-1-6-8 --mode 2560x1440_30.00 --pos 0x0 --rotate normal --output DP-2-6-1 --off --output DP-1-6-1-8 --mode 2560x1440_30.00 --pos 2560x0 --rotate normal


    #xrandr --output eDP-1 --mode 1920x1080_60.00 --output DP-1-6-8 --mode 2560x1440_30.00 --above eDP-1 --output DP-1-6-1-8 --mode 2560x1440_30.00 --right-of DP-1-6-8
    
else
    echo "single monitor"
    xrandr --output eDP-1 --mode 1920x1080 --primary
    xrandr --output DP-1-6-8 --off
    xrandr --output DP-1-6-1-8 --off
fi

# update the background scaling
feh --bg-fill $HOME/pictures/backgrounds/puget_sound.png.jpg
