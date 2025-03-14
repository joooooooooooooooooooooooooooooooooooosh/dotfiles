#!/usr/bin/env sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # if [ $(aerospace list-windows --workspace focused --count) -eq 0 ]; then
    #     sketchybar --set $NAME icon.drawing=on
    # fi
    sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME background.drawing=off
fi
