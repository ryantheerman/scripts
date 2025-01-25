#!/bin/sh

uptime=$(uptime -p)
days=$(echo "$uptime" | grep -oP '\d+(?= day)')
hours=$(echo "$uptime" | grep -oP '\d+(?= hour)')
minutes=$(echo "$uptime" | grep -oP '\d+(?= minute)')

formatted_uptime=""
if [ -n "$days" ]; then
  formatted_uptime=" ${days}d"
fi
if [ -n "$hours" ]; then
  formatted_uptime="${formatted_uptime} ${hours}h"
fi
formatted_uptime="${formatted_uptime} ${minutes}m "

echo "$formatted_uptime" > ~/.config/i3status/uptime-data
