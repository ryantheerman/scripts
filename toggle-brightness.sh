#!/bin/bash

if [ $(brightnessctl get) -ne 1 ]; then
	brightnessctl set 1
else
	brightnessctl set 100%
fi
