#!/bin/bash

TARGET_TITLE="$1"

if [[ -z "$TARGET_TITLE" ]]; then
    echo "usage: $(basename "$0") <title>" >&2
    exit 1
fi

window_id=$(niri msg windows 2>/dev/null | awk -v title="\"$TARGET_TITLE\"" '
    /^Window ID/ { id = $3; gsub(/:/, "", id) }
    /Title:/ && $2 == title { print id; exit }
')

if [[ -n "$window_id" ]]; then
    niri msg action focus-window --id "$window_id"
else
    alacritty --title "$TARGET_TITLE" -e /home/match/scripts/ssh-machines.sh "$TARGET_TITLE"
fi
