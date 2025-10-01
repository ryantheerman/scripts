#!/bin/bash

pactl set-sink-mute @DEFAULT_SINK@ on

systemctl suspend-then-hibernate
