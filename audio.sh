#!/bin/bash

# script checks which sink is the current default

default_sink=$(pactl get-default-sink)

echo "default sink: ${default_sink}"

sink_index=$(pactl list sinks short | grep -m 1 $default_sink | awk '{print $1}')

echo "sink index: ${sink_index}"


