#!/bin/zsh
printf '\033]2;claude-vm\033\\'

SESSION="claude-vm"

ssh -t claude-vm 'zsh -c "/home/$USER/scripts/tmux.sh || true; exec zsh"'
