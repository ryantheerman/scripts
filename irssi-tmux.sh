#!/bin/zsh

cd ~

connected_wireless=$(nmcli | grep "connected to diaper-butt-home" | awk '{print $4}')
connected_wired=$(nmcli | grep "inet4 192.168.30.")

target_net=$(cat $HOME/scripts/.netdef)
if [[ "$connected_wireless" == "$target_net" || "$connected_wired" ]]; then
    ssh -t homeserver 'zsh -c "/home/$USER/scripts/irssi-session.sh || true; exec zsh"'
else
    ssh -t "homeserver.tailnet" 'zsh -c "/home/$USER/scripts/irssi-session.sh || true; exec zsh"'
fi

