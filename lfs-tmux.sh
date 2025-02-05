#!/bin/zsh

SESSION="lfs"

if tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "session '$SESSION' exists."
    
    # only toggles fullscreen on if i3bar is visible on eDP-1
#    if xwininfo -id $(xdotool search -name "i3bar for output eDP-1") | grep IsViewable 2>/dev/null; then
#        i3-msg 'fullscreen toggle'
#    fi

    # resets zoom to default, then zooms in one tick (this makes it so the tmux status bar fits neatly at the bottom without blank space
#    xdotool key Ctrl+0
#    xdotool key Ctrl+minus
#    xdotool key Ctrl+minus
#    xdotool key Ctrl+minus
    
    # for some reason 'Ctrl+plus' is not working as expected. Even when I run it manually. Must be another command.
    #xdotool key Ctrl+plus

    # attach existing session at window 1
    tmux attach-session -d -t $SESSION:1
    tmux select-window -t 1
    tmux send-keys -t 1 'tmux choose-tree -s' C-m
else
    echo "session '$SESSION' does not exist."

    # creates detached session called main and opens first window to zsh prompt
    tmux new-session -d -s $SESSION
    
    # opens second window, names it 'notes', and opens the daybook in vim
    tmux new-window -n 'lfs-notes'
    tmux send-keys -t 'lfs-notes' 'cd ~/notes/ && vim linux_from_scratch' C-m
    
    tmux select-window -t 1
    
    # attach the session and open the first window
    tmux attach-session -d -t $SESSION:\; choose-tree -st 1
fi
