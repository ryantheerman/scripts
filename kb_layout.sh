#! /bin/zsh

# script to sway the kb layout between us standard and us dvorak
# set the layout and rerun xmodmap cause setxkbmap wiped it out
# also setting the rate here because i use this script when a package install interferes with my x settings

if setxkbmap -query | grep -iq variant; then
    setxkbmap us &>/dev/null && xmodmap $HOME/.Xmodmap && xset r rate 200 30
    echo "<span color='yellow'>qwerty</span>" > ~/.config/i3status/keymap
    killall -USR1 i3status
else
    setxkbmap us -v dvorak &>/dev/null && xmodmap $HOME/.Xmodmap && xset r rate 200 30
    echo "<span color='pink'>dvorak</span>" > ~/.config/i3status/keymap
    killall -USR1 i3status
fi
