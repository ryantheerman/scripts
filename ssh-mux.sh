#!/bin/zsh

cd ~

connected_wireless=$(nmcli | grep "connected to diaper-butt-home" | awk '{print $4}')
connected_wired=$(nmcli | grep "inet4 192.168.30.")

target_net=$(cat $HOME/scripts/.netdef)

if [[ "$connected_wireless" == "$target_net" || "$connected_wired" ]]; then
    if [[ $1 == 'brocade' ]]; then
        ssh brocade
    fi
    ssh -t $1 'zsh -c "/home/$USER/scripts/tmux.sh || true; exec zsh"'
else
    if [[ $1 == 'brocade' ]]; then
        echo "can't connect to the brocade remotely bro"
        exit
    fi
    ssh -t "$1.tailnet" 'zsh -c "/home/$USER/scripts/tmux.sh || true; exec zsh"'
fi

