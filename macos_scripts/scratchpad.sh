#!/usr/bin/env bash

scratchpad_id=$(aerospace list-windows --all | grep Scratchpad$ | cut -d' ' -f1)

if [ -z "$scratchpad_id" ]; then
    open -a Alacritty -n --args -t Scratchpad
else
    aerospace move-node-to-workspace --fail-if-noop --focus-follows-window --window-id "${scratchpad_id}" $(aerospace list-workspaces --focused) \
        || aerospace move-node-to-workspace --window-id "${scratchpad_id}" scratchpad
fi
