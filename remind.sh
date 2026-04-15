#!/bin/bash


# Capture existing zathura window IDs before launching
EXISTING_IDS=$(niri msg --json windows | jq -r '.[] | select(.app_id == "org.pwmt.zathura") | .id')

zathura ~/Documents/papers/the-book-of-remind.pdf &
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



#zathura ~/Documents/papers/the-book-of-remind.pdf &
#ZATHURA_PID=$!
#
## Wait until zathura window exists (max 5 seconds)
#for i in {1..50}; do
#    if niri msg --json windows | jq -e ".[] | select(.app_id == \"org.pwmt.zathura\")" >/dev/null 2>&1; then
#        break
#    fi
#    sleep 0.1
#done

alacritty --title "remind-workspace" -e ~/scripts/remind-tmux.sh &

tkremind -m -b1
