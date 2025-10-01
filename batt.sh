#!/bin/bash

batteryLine=$(acpi | grep 'Battery 0')
batteryLineFourthElement=$(acpi | grep 'Battery 0' | awk '{print $4}' |  sed 's|,||g')
#echo $batteryLineFourthElement

if [[ $batteryLineFourthElement == "charging" ]] ; then
	echo $batteryLine | awk '{print $5}' | sed 's|,||g'
else
	echo $batteryLine | awk '{print $4}' | sed 's|,||g'
fi
