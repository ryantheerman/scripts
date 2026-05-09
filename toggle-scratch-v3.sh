#!/bin/bash

TITLE="scratch"
ALL_WINDOWS=$(niri msg --json windows)
WIN_JSON=$(echo "$ALL_WINDOWS" | jq '.[] | select(.title == "scratch")')

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
    link_notes
    alacritty --title "$TITLE" -e tmux attach-session -t "$TITLE" &
    tmux set-option -t "$TITLE" status on
    tmux set-option -t "$TITLE" status-left ""
    tmux set-option -t "$TITLE" status-right ""
    tmux set-option -t "$TITLE" status-justify absolute-centre
}

if [ -z "$WIN_JSON" ]; then
    spawn
else
    WIN_ID=$(echo "$WIN_JSON" | jq -r '.id')
    IS_FOCUSED=$(echo "$WIN_JSON" | jq -r '.is_focused')
    WIN_WS=$(echo "$WIN_JSON" | jq -r '.workspace_id')
    FOCUSED_WS=$(niri msg --json workspaces | jq -r '.[] | select(.is_focused == true) | .id')

    if [ "$IS_FOCUSED" = "true" ]; then
        niri msg action close-window --id "$WIN_ID"
    elif [ "$WIN_WS" = "$FOCUSED_WS" ]; then
        niri msg action close-window --id "$WIN_ID"
    else
        niri msg action close-window --id "$WIN_ID"
        spawn
    fi
fi
