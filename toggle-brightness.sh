#!/bin/bash

if [ $(brightnessctl get) -le 1 ]; then
	brightnessctl set 100%
else
	brightnessctl set 1
fi
