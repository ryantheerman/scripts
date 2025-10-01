#!/bin/bash

if [ $1 == "down" ]; then
	brightnessctl set 1%-
else
	brightnessctl set +1%
fi

$HOME/scripts/calculate-brightness-percentage.sh
