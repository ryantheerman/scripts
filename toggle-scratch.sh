#!/bin/bash

TITLE="scratch"
WIN_JSON=$(niri msg --json windows | jq '.[] | select(.title == "scratch")')

if [ -z "$WIN_JSON" ]; then
    alacritty --title "$TITLE" -e tmux new-session -A -s "$TITLE" -c ~ \; set-option status off &
else
    WIN_ID=$(echo "$WIN_JSON" | jq -r '.id')
    IS_FOCUSED=$(echo "$WIN_JSON" | jq -r '.is_focused')

    if [ "$IS_FOCUSED" = "false" ]; then
        niri msg action close-window --id "$WIN_ID"
        alacritty --title "$TITLE" -e tmux new-session -A -s "$TITLE" -c ~ \; set-option status off &
    else
        niri msg action close-window --id "$WIN_ID"
    fi
fi
