#!/bin/bash

SESSION="spotify"

cd ~

if tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "session '$SESSION' exists."

    # attach existing session at window 1
    if [[ -z $TMUX ]]; then
        tmux attach-session -d -t $SESSION
    else
        tmux switch-client -t $SESSION
    fi
else
    echo "session '$SESSION' does not exist."

    # creates detached session called main and opens first window to zsh prompt
    tmux new-session -d -s $SESSION
    tmux send-keys -t 'spotify' 'ncspot' C-m
    
    # attach the session
    tmux attach-session -d -t $SESSION
fi
