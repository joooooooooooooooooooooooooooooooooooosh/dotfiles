#!/bin/sh
if [ -z $1 ]; then
    sudo /home/joshh/Documents/scripts/brightchange.sh "$(rofi -dmenu -p "set brightness (0 - 4285)")"
else
    sudo /home/joshh/Documents/scripts/brightchange.sh "$@"
fi
polybar-msg action "#brightness.hook.0"
