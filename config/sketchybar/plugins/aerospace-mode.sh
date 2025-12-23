#!/usr/bin/env sh

# Use this for mouse.scolled.global because individual spaces might not always exist on the bar
if [ "${SENDER}" = "mouse.scrolled.global" ]; then
    if echo "${SCROLL_DELTA}" | grep -q '-'; then
        aerospace list-workspaces --monitor focused --empty no | grep -v scratchpad | aerospace workspace --wrap-around prev --stdin
    else
        aerospace list-workspaces --monitor focused --empty no | grep -v scratchpad | aerospace workspace --wrap-around next --stdin
    fi
elif [ "${SENDER}" = "aerospace_mode_change" ] || [ "${SENDER}" = "forced" ]; then
    if [ -n "$INFO" ]; then
        sketchybar --set "$NAME" label="$INFO"
        sketchybar --set "$NAME" background.drawing=on
    else
        sketchybar --set "$NAME" background.drawing=off
        sketchybar --set "$NAME" label=""
    fi
fi
