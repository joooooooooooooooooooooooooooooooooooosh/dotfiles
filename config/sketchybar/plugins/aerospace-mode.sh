#!/usr/bin/env sh

sketchybar --set "$NAME" label="$INFO"

if [ -n "$INFO" ]; then
    sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME background.drawing=off
fi
