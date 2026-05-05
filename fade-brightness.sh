#!/bin/bash
target=$1
current=$(brightnessctl g)

echo "$current" > /tmp/brightness

for ((v=current; v>=target; v-=250)); do
    brightnessctl -q s "$v"
    sleep 0.05
done
brightnessctl -q s "$target"
