#!/bin/bash

TITLE="scratch"
WIN_JSON=$(niri msg --json windows | jq '.[] | select(.title == "scratch")')

link_notes() {
    if ! tmux list-windows -t scratch -F '#{window_name}' 2>/dev/null | grep -q '^notes$'; then
        tmux link-window -s workshop:notes -t scratch
        tmux select-window -t scratch:1
#        tmux set-hook -t scratch window-unlinked 'unlink-window -t scratch:2'
        tmux set-hook -t scratch window-unlinked \
          'if-shell "! tmux list-windows -t scratch -F \"#{window_index}\" | gep -qx 1" \
            "unlink-window -t scratch:2"'
    fi
}

wait_and_link() {
    for i in $(seq 1 20); do
        if tmux has-session -t scratch 2>/dev/null; then
            link_notes
            return
        fi
        sleep 0.1
    done
}

spawn() {
    alacritty --title "$TITLE" -e tmux new-session -A -s "$TITLE" -c ~ \; set-option status off &
    wait_and_link &
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
