#!/bin/zsh

hostname=$1

if ! bash on-home-network.sh $hostname && [[ $hostname != 'piratebox' ]] && [[ $hostname != 'claudebox-server' ]] && [[ $hostname != 'brocade' ]]; then
    hostname=$hostname.tailnet
fi

if [[ $hostname == 'brocade' ]]; then
    ssh brocade
    exit
fi

ssh -t $hostname 'zsh -c "/home/$USER/scripts/tmux.sh || true; exec zsh"'
