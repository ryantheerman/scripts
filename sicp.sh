#!/bin/bash

zathura ~/Documents/sicp.pdf &
ZATHURA_PID=$!

# Wait until zathura window exists (max 5 seconds)
for i in {1..50}; do
    if niri msg --json windows | jq -e ".[] | select(.app_id == \"org.pwmt.zathura\")" >/dev/null 2>&1; then
        break
    fi
    sleep 0.1
done

#sleep 1

#alacritty -e ~/scripts/sicp.sh &
alacritty --title "sicp-workspace" -e ~/scripts/sicp-tmux.sh &
