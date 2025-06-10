#!/usr/bin/env sh

if [ -n "$INFO" ]; then
    sketchybar --set "$NAME" label="$INFO"
    sketchybar --set "$NAME" background.drawing=on
else
    sketchybar --set "$NAME" background.drawing=off
    sketchybar --set "$NAME" label=""
fi
