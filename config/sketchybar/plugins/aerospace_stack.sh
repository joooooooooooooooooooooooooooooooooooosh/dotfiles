#!/usr/bin/env sh

if [ "$SENDER" = "mouse.scrolled" ]; then
    DIRECTION="up"
    if echo "$SCROLL_DELTA" | grep -q '-'; then
        DIRECTION="down"
    fi

    aerospace focus --boundaries-action wrap-around-the-workspace "$DIRECTION"
fi
