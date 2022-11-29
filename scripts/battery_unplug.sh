#!/bin/bash
if ! acpi -b | grep "rate information unavailable"; then
    sudo /home/joshh/Documents/scripts/toggle-power-mode.sh low-power
fi
