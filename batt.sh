#!/bin/bash

acpi | grep 'Battery 0' | awk '{print $4}' | sed 's|,||g'
