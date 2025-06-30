#!/bin/zsh

SESSION="network"

cd ~

start_network() {
   tmux new-session -d -s $SESSION -n homeserver
   tmux send-keys -t "${SESSION}:homeserver" 'ssh homeserver' C-m
   tmux send-keys -t "${SESSION}:homeserver" 'tmux.sh' C-m

   # second window ssh into storage, start tmux
   tmux new-window -t "${SESSION}:" -n storage
   tmux send-keys -t "${SESSION}:storage" 'ssh storage' C-m
   tmux send-keys -t "${SESSION}:storage" 'tmux.sh' C-m

   # third window ssh into storage, start tmux
   tmux new-window -t "${SESSION}:" -n vms
#   tmux send-keys -t "${SESSION}:vms" 'ssh titan-vm' C-m
#   tmux send-keys -t "${SESSION}:vms" 'tmux' C-m
   
   
   # switch to window 3, then window 2 so the order of previous windows will be ascending when the session attaches to window 1
   tmux select-window -t "${SESSION}:2"
   tmux select-window -t "${SESSION}:1"
}

if tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "session '$SESSION' exists."
    
    # only toggles fullscreen on if i3bar is visible on eDP-1
#    if xwininfo -id $(xdotool search -name "i3bar for output eDP-1") | grep IsViewable 2>/dev/null; then
#        i3-msg 'fullscreen toggle'
#    fi

    # resets zoom to default, then zooms in one tick (this makes it so the tmux status bar fits neatly at the bottom without blank space
#    xdotool key Ctrl+0
#    xdotool key Ctrl+minus
#    xdotool key Ctrl+equal
#    xdotool key Ctrl+equal
    
    # for some reason 'Ctrl+plus' is not working as expected. Even when I run it manually. Must be another command.
    #xdotool key Ctrl+plus

    # attach existing session at window 1
    if [[ -z $TMUX ]]; then
        tmux attach-session -d -t $SESSION:1
    else
        tmux switch-client -t $SESSION:1
    fi
#    tmux select-window -t 1
#    tmux send-keys -t 1 'tmux choose-tree -s' C-m
else
    # if network does not exist...
    echo "session '$SESSION' does not exist."
    

    start_network
    # ... and we're NOT in a tmux session...
    # ... create the network session
    if [[ -z $TMUX ]]; then
        tmux attach-session -t "$SESSION"
    # but if we ARE in a tmux session
    else
        # simply attach the session
        # bug. what if the session does not exist? failure.
        tmux switch-client -t "$SESSION"
    fi
fi
