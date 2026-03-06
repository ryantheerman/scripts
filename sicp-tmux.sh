#!/bin/zsh

SESSION="sicp"

cd ~

if tmux has-session -t "$SESSION" 2>/dev/null; then
    # attach existing session at window 1
    if [[ -z $TMUX ]]; then
        tmux attach-session -d -t $SESSION:1
    else
        tmux switch-client -t $SESSION:1
    fi
else
    # creates detached session called sicp and opens 2 panes. loads vim sicp file in one and runs racket -I <dialect package subject to change> in the other, then switches back to pane 0
    tmux new-session -d -s $SESSION
#    tmux send-keys 'cd ~/projects/sicp && clear && vim ~/projects/sicp/sicp.rkt' C-m
#    tmux send-keys 'cd ~/projects/sicp && clear && vim -c "NERDTree ~/projects/sicp"' C-m
#    tmux send-keys 'cd ~/projects/sicp && vim .' C-m
    tmux send-keys 'cd ~/projects/sicp && vim -p work/1/notes.rkt work/1/exercises.rkt' C-m
    tmux split-pane -v
    tmux send-keys 'clear && racket -I simply-scheme' C-m
    tmux select-pane -t 0
    
    # attach the session and open the first window
    tmux attach-session -d -t $SESSION
fi
