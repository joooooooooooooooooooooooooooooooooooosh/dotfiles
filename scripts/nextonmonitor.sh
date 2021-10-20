#!/bin/bash
LOCK_FILE="/tmp/nextonmonitor.lock"
while [ -e LOCK_FILE ]; do sleep 0.01; done
touch LOCK_FILE

# TODO: could turn into a read call
currwin=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num'`
curroutput=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).output'`

if [ "$1" = "next" ]; then
    move=`i3-msg -t get_workspaces | jq '.[], .[] | select(.output=='$curroutput') | .num' | grep ^$currwin$ -A1 -m1 | tail -1`
elif [ "$1" = "prev" ]; then
    move=`i3-msg -t get_workspaces | jq '.[], .[] | select(.output=='$curroutput') | .num' | grep ^$currwin$ -B1 | tail -2 | head -1`
else
    echo "Usage: $0 [prev|next]"
    rm LOCK_FILE
    exit 1
fi

i3-msg workspace $move
rm LOCK_FILE
