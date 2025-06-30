#!/bin/bash
# this script creates a bridge interface

ip link add name br0 type bridge
ip link set dev br0 up
ip address add 192.168.50.42/24 dev br0
ip route append default via 192.168.50.1 dev br0
ip link set enp0s31f6 master br0
ip address del 192.168.50.42/24 dev enp0s31f6
