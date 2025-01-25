#! /bin/zsh

# bring headphone and speaker volumes to 100
# this will only apply if those channels are available (ie, laptop is not connected to dock).
amixer -c 0 set Speaker 100% > /dev/null
amixer -c 0 set Headphone 100% > /dev/null
