#!/bin/bash

xdotool search --onlyvisible --class "zen-browser" windowactivate --sync

sleep 0.1

xdotool key --clearmodifiers ctrl+l

sleep 0.1

xdotool key --clearmodifiers ctrl+c

sleep 0.1

url=$(xclip -o -selection clipboard)

if [[ "$url" =~ ^https?:// ]]; then
	firefox "$url" >/dev/null 2>&1 &

	# Wait briefly for new window to spawn
    sleep 1.0

    # Find the newest firefox window (best-effort)
    firefox_id=$(xdotool search --onlyvisible --class "firefox" | tail -n 1)

    # Focus and send F11
    if [ -n "$firefox_id" ]; then
        xdotool windowactivate --sync "$firefox_id"
        sleep 0.2
        xdotool key F11
    fi
fi

