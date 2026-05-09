#!/bin/bash

TITLE="scratch"
WIN_JSON=$(niri msg --json windows | jq '.[] | select(.title == "scratch")')

link_notes() {
    if ! tmux list-windows -t "$TITLE" -F '#{window_name}' 2>/dev/null | grep -q '^notes$'; then
        tmux link-window -s workshop:notes -t "$TITLE"
        tmux select-window -t "$TITLE":1
        tmux rename-window -t "$TITLE":1 "scratch"
        tmux set-hook -t "$TITLE" window-unlinked 'if-shell "! tmux list-windows -t scratch -F \"#{window_index}\" | gep -qx 13" "unlink-window -t scratch:2"'
    fi
}

spawn() {
    tmux new-session -d -s "$TITLE" -c ~
#    tmux set-option -t "$TITLE" status off
    link_notes
    alacritty --title "$TITLE" -e tmux attach-session -t "$TITLE" &
    tmux set-option -t "$TITLE" status on
#    tmux set-option -t "$TITLE" status-left " 20%y-%m-%d %H:%M:%S"
#    tmux set-option -t "$TITLE" status-right "#(~/scripts/batt.sh) "
    tmux set-option -t "$TITLE" status-left ""
    tmux set-option -t "$TITLE" status-right ""
    tmux set-option -t "$TITLE" status-justify absolute-centre
#    tmux set-option -t "$TITLE" window-status-current-style 'bg=#FF0000 fg=#FF0000'
}

if [ -z "$WIN_JSON" ]; then
    spawn
else
    WIN_ID=$(echo "$WIN_JSON" | jq -r '.id')
    IS_FOCUSED=$(echo "$WIN_JSON" | jq -r '.is_focused')

    if [ "$IS_FOCUSED" = "false" ]; then
        niri msg action close-window --id "$WIN_ID"
        spawn
    else
        niri msg action close-window --id "$WIN_ID"
    fi
fi

# need to figure out closing closing the float when the window is on the current workspace but not focused
