#!/bin/zsh

SESSION="remind"

cd ~/.reminders

if tmux has-session -t "$SESSION" 2>/dev/null; then
    # attach existing session at window 1
    if [[ -z $TMUX ]]; then
        tmux attach-session -d -t $SESSION:1
    else
        tmux switch-client -t $SESSION:1
    fi
else
    tmux new-session -d -s $SESSION
    tmux send-keys 'nvim' C-m
    
    # attach the session and open the first window
    tmux attach-session -d -t $SESSION
fi
