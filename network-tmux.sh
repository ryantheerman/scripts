#!/bin/zsh

SESSION="network"

cd ~

connected_net=$(nmcli | grep "connected to" | awk '{print $4}')
target_net=$(cat $HOME/scripts/.netdef)

if [[ "$connected_net" == "$target_net" ]]; then
    # all connection logic
    start_network() {
        # first window ssh into homeserver, start existing tmux session if available, else start new one
        tmux new-session -d -s $SESSION -n homeserver
        tmux send-keys -t "${SESSION}:homeserver" 'ssh homeserver' C-m
        tmux send-keys -t "${SESSION}:homeserver" 'tmux.sh' C-m
     
        # second window ssh into storage, start existing tmux session if available, else start new one
        tmux new-window -t "${SESSION}:" -n storage
        tmux send-keys -t "${SESSION}:storage" 'ssh storage' C-m
        tmux send-keys -t "${SESSION}:storage" 'tmux.sh' C-m
     
        # third window ssh into pi, start existing tmux session if available, else start new one
        tmux new-window -t "${SESSION}:" -n gamebox
        tmux send-keys -t "${SESSION}:gamebox" 'ssh gamebox' C-m
        tmux send-keys -t "${SESSION}:gamebox" 'tmux.sh' C-m
    
        # fourth window ready for if i want to jump into vms
        tmux new-window -t "${SESSION}:" -n vms
    #   tmux send-keys -t "${SESSION}:vms" 'ssh titan-vm' C-m
    #   tmux send-keys -t "${SESSION}:vms" 'tmux' C-m
       
       
        # switch to window 3, then window 2 so the order of previous windows will be ascending when the session attaches to window 
        tmux select-window -t "${SESSION}:3"
        tmux select-window -t "${SESSION}:2"
        tmux select-window -t "${SESSION}:1"
    }
    
    if tmux has-session -t "$SESSION" 2>/dev/null; then
        echo "session '$SESSION' exists."
        
        # attach existing session at window 1
        if [[ -z $TMUX ]]; then
            tmux attach-session -d -t $SESSION:1
        else
            tmux switch-client -t $SESSION:1
        fi
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


else
    echo "not connected to the home network bruh"
fi

