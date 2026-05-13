#!/bin/zsh

#cd ~
#
#connected_wireless=$(nmcli | grep "connected to diaper-butt-home" | awk '{print $4}')
#connected_wired=$(nmcli | grep "inet4 192.168.30.")
#
#target_net=$(cat $HOME/scripts/.netdef)


# check if we need to use the tailnet

hostname=$1

if ! bash on-home-network.sh $hostname && [[ $hostname != 'piratebox' ]] && [[ $hostname != 'claudebox-server' ]] && [[ $hostname != 'brocade' ]]; then
    hostname=$hostname.tailnet
fi

if [[ $hostname == 'brocade' ]]; then
    ssh brocade
    exit
fi

ssh -t $hostname 'zsh -c "/home/$USER/scripts/tmux.sh || true; exec zsh"'
