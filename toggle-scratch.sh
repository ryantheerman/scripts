#!/bin/bash

#if $(niri msg windows | grep -i "Title: scratch"); then
#    echo "is open"
#else
#    echo "is not open"
#    alacritty --title scratch -e tmux new-session -A -s scratch -c ~ \; set-option -t scratch status off
#fi

TITLE="scratch"
WIN_JSON=$(niri msg --json windows | jq '.[] | select(.title == "scratch")')

if [ -z "$WIN_JSON" ]; then
    alacritty --title "$TITLE" -e tmux new-session -A -s "$TITLE" -c ~ \; set-option status off &
else
    WIN_ID=$(echo "$WIN_JSON" | jq -r '.id')
    IS_FOCUSED=$(echo "$WIN_JSON" | jq -r '.is_focused')

    if [ "$IS_FOCUSED" = "false" ]; then
        niri msg action close-window --id "$WIN_ID"
#        sleep 0.1
        alacritty --title "$TITLE" -e tmux new-session -A -s "$TITLE" -c ~ \; set-option status off &
    else
        niri msg action close-window --id "$WIN_ID"
    fi
fi
