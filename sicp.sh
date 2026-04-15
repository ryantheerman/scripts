#!/bin/bash

mpv --save-position-on-quit --pause ~/projects/sicp/lectures/cs61a-lectures.m3u &

sleep .25

# Capture existing zathura window IDs before launching
EXISTING_IDS=$(niri msg --json windows | jq -r '.[] | select(.app_id == "org.pwmt.zathura") | .id')

zathura ~/projects/sicp/documents/sicp.pdf &
ZATHURA_PID=$!

# Wait until a NEW zathura window appears (max 5 seconds)
for i in {1..50}; do
    NEW=$(niri msg --json windows \
        | jq -r '.[] | select(.app_id == "org.pwmt.zathura") | .id' \
        | grep -vxF "$EXISTING_IDS")
    if [[ -n "$NEW" ]]; then
        break
    fi
    sleep 0.1
done

#zathura ~/projects/sicp/documents/sicp.pdf &
#ZATHURA_PID=$!
#
## Wait until zathura window exists (max 5 seconds)
#for i in {1..50}; do
#    if niri msg --json windows | jq -e ".[] | select(.app_id == \"org.pwmt.zathura\")" >/dev/null 2>&1; then
#        break
#    fi
#    sleep 0.1
#done

alacritty --title "sicp-workspace" -e ~/scripts/sicp-tmux.sh &

sleep .25

zathura ~/projects/sicp/documents/course_reader_vol_1/homework_assignments.pdf &

sleep .25

zathura ~/projects/sicp/documents/course_reader_vol_1/lab_assignments.pdf &

sleep .25

zathura ~/projects/sicp/documents/course_syllabus.pdf &
