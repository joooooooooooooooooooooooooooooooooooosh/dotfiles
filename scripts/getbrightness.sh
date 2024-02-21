#!/bin/bash

MONITOR=$1
if [ "$MONITOR" = "eDP" ]; then
    brightness=$(cat /sys/class/backlight/*/brightness)
    max_brightness=$(cat /sys/class/backlight/*/max_brightness)
    bc -l <<< "scale=3; $brightness / $max_brightness * 100"
else
    brightness=$(stdbuf -o0 xrandr --verbose \
	| grep Brightness -B10 \
	| sed -n '/connected/{s/ .*//; p}; /Brightness/{s/.*: //; p}' \
	| grep "$MONITOR" -A1 \
	| tail -1
    )
    bc -l <<< "scale=3; $brightness * 100"
fi | sed 's/^\./0\./; s/\..*//; s/$/%/'
