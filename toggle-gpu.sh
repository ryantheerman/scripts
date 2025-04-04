#!/bin/bash

if glxinfo | grep "Mesa Intel(R)" > /dev/null; then
    sudo envycontrol -s nvidia
else
    sudo envycontrol -s integrated
fi
