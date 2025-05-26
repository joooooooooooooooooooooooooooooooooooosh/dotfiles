#!/usr/bin/env sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    # if [ $(aerospace list-windows --workspace focused --count) -eq 0 ]; then
    #     sketchybar --set $NAME icon.drawing=on
    # fi
    sketchybar --set "$NAME" background.drawing=on
else
    sketchybar --set "$NAME" background.drawing=off
fi

if [ "$SENDER" = "mouse.scrolled" ] || [ "$SENDER" = "mouse.scrolled.global" ]; then
    if echo "$SCROLL_DELTA" | grep -q '-'; then
        aerospace list-workspaces --monitor focused --empty no | grep -v scratchpad | aerospace workspace --wrap-around prev
    else
        aerospace list-workspaces --monitor focused --empty no | grep -v scratchpad | aerospace workspace --wrap-around next
    fi
fi
