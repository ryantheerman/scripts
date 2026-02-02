#!/bin/bash

if grep -Pzo 'touch\s*\{\s*// off\s*\}' ~/.config/niri/config.kdl > /dev/null; then
    echo "touchscreen enabled"
else
    echo "touchscreen disabled"
fi
