#!/bin/bash
while [ -e /tmp/nextonmonitor.lock ]; do sleep 0.01; done
touch /tmp/nextonmonitor.lock
currwin=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d '"' -f2`
if [ "$1" = "next" ]; then
    move=`i3-msg -t get_workspaces | jq '.[], .[] | .name, .output' | grep \"$currwin\" -A2 -m1 | tail -1 | cut -d\" -f2`
elif [ "$1" = "prev" ]; then
    move=`i3-msg -t get_workspaces | jq '.[], .[] | .name, .output' | grep \"$currwin\" -B2 -m2 | tail -3 | head -1 | cut -d\" -f2`
else
    echo "Usage: $0 [prev|next]"
    exit 1
fi
i3-msg workspace $move
rm /tmp/nextonmonitor.lock