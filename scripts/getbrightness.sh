#!/bin/bash

MONITOR=$1
if [ "$MONITOR" = "eDP" ]; then
    brightness=$(cat /sys/class/backlight/amdgpu_bl0/brightness)
    max_brightness=$(cat /sys/class/backlight/amdgpu_bl0/max_brightness)
    bc -l <<< "scale=3; $brightness / $max_brightness * 100"
else
    brightness=$(xrandr --verbose \
	| grep Brightness -B10 \
	| sed -n '/connected/{s/ .*//; p}; /Brightness/{s/.*: //; p}' \
	| grep "$MONITOR" -A1 \
	| tail -1
    )
    bc -l <<< "scale=3; $brightness * 100"
fi | sed 's/^\./0\./; s/\..*//; s/$/%/'