#!/bin/sh
if [ $1 == "left" ]; then
    move=$((`i3-msg -t get_workspaces | sed 's/,/\n/g' | grep name | cut -d\" -f4 | sort -nr | grep ^.$ | head -1` + 1))
else 
    move=$((`i3-msg -t get_workspaces | sed 's/,/\n/g' | grep name | cut -d\" -f4 | sort -nr | head -1` + 1))
    if [ $move -lt 11 ]; then
        move=11
    fi
fi
i3-msg move container to workspace $move
i3-msg workspace $move