#!/bin/zsh

SESSION="dev"

if tmux has-session -t $SESSION 2>/dev/null; then
    echo "session '$SESSION' exists."

#    if xwininfo -id $(xdotool search -name "i3bar for output eDP-1") | grep IsViewable 2>/dev/null; then
#        i3-msg 'fullscreen toggle'
#    fi

#    xdotool key Ctrl+0
#    xdotool key Ctrl+minus

    tmux attach-session -d -t $SESSION:1
else
    echo "session '$SESSION' does not exist."

    tmux new-session -d -s $SESSION
    tmux rename-window 'git'

    tmux send-keys 'cd ~/projects/aoc-java' C-m

    tmux new-window -n 'database'

#    if xwininfo -id $(xdotool search -name "i3bar for output eDP-1") | grep IsViewable 2>/dev/null; then
#        i3-msg 'fullscreen toggle'
#    fi

#    xdotool key Ctrl+0
#    xdotool key Ctrl+minus

    tmux attach-session -d -t $SESSION:1
fi
