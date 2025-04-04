#!/bin/bash

if ! pgrep -x "picom" > /dev/null; then
    picom &
fi
