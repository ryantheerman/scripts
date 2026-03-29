#!/bin/zsh
printf '\033]2;claudebox-local\033\\'

SESSION="claudebox-local"

ssh -t claudebox 'zsh -c "/home/$USER/scripts/tmux.sh || true; exec zsh"'
