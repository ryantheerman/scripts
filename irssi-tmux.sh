#!/bin/zsh

while true; do
    hostname=homeserver
    # check if we need to use the tailnet
    if ! bash on-home-network.sh $hostname; then
        hostname=$hostname.tailnet
    fi

    # connect to remote and spin up relevant tmux session
    #autossh -M 0 -o "ServerAliveInterval=10" -o "ServerAliveCountMax=3" -t $hostname 'zsh -c "/home/$USER/scripts/irssi-session.sh || true; exec zsh"'
    ssh -o "ServerAliveInterval=10" -o "ServerAliveCountMax=3" -t $hostname 'zsh -c "/home/$USER/scripts/irssi-session.sh || true; exec zsh"'
done

