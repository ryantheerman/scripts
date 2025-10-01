#!/bin/bash

if grep -q "LID.*enabled" /proc/acpi/wakeup; then
	/bin/sh -c "echo LID > /proc/acpi/wakeup"
fi
