#!/bin/zsh

SESSION="main"

cd ~

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
    tmux select-window -t 1
    tmux send-keys -t 1 'tmux choose-tree -s' C-m
else
    echo "session '$SESSION' does not exist."

    # creates detached session called main and opens first window to zsh prompt
    tmux new-session -d -s $SESSION
    
    # opens second window, names it 'notes', and opens the daybook in vim
    tmux new-window -n 'notes'
    tmux send-keys -t 'notes' 'cd ~/notes/ && daybook' C-m

    # opens third window called scripting
    tmux new-window -n 'scripts'
    tmux send-keys 'clear && cd ~/scripts' C-m
    tmux split-pane -h
    tmux send-keys 'clear && cd ~/scripts' C-m
    tmux select-pane -t 0

    # opens fourth window for project
    tmux new-window -n 'project'
    tmux send-keys -t 'project' 'cd ~/projects/aoc-java' C-m
    tmux send-keys -t 'project' 'clear' C-m
    
    # opens fifth window and runs ncspot (spotify tui)
    tmux new-window -n 'spotify'
    tmux send-keys -t 'spotify' 'ncspot' C-m
    
    # opens sixth window and runs htop
    tmux new-window -n 'processes'
    tmux send-keys 'htop' C-m
    if [[ $($HOME/scripts/readMoon.sh) == "ganymede" ]]; then
        tmux split-pane -h
        tmux send-keys 'nvtop' C-m
    fi

    # opens seventh window and runs irssi
    tmux new-window -n 'irc'
    tmux send-keys 'irssi' C-m

    


    # make terminal full screen (checks if i3bar is visible on eDP-1. if yes, toggles fullscreen on. else does not toggle fullscreen.
#    if xwininfo -id $(xdotool search -name "i3bar for output eDP-1") | grep IsViewable 2>/dev/null; then
#        i3-msg 'fullscreen toggle'
#    fi
    
    # resets zoom to default, then zooms out one tick
#    xdotool key Ctrl+0
#    xdotool key Ctrl+minus
    #xdotool key Ctrl+plus

    # resets zoom to default, then zooms in one tick (this makes it so the tmux status bar fits neatly at the bottom without blank space
#    xdotool key Ctrl+0
#    xdotool key Ctrl+minus
#    xdotool key Ctrl+equal
#    xdotool key Ctrl+equal

    # switch to window 3, then window 2 so the order of previous windows will be ascending when the session attaches to window 1
    tmux select-window -t 6
    tmux select-window -t 5
    tmux select-window -t 4
    tmux select-window -t 3
    tmux select-window -t 2
    tmux select-window -t 1
    
    # attach the session and open the first window
    tmux attach-session -d -t $SESSION:\; choose-tree -st 1
fi
