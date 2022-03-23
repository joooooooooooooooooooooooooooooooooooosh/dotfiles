#!/bin/bash

wal -q -i "$@"
if [ "$2" != "-l" ]; then
    wal-discord
    spicetify update
fi

# invert text colour of selected element
sed -i 's/@selected-.*fore/@back/' ~/.cache/wal/colors-rofi-dark.rasi

# replace white colour used by firefox
off_white=$(grep color7 ~/.cache/wal/colors.json | cut -d\" -f4)
sed -i '/color15/s/: ".*"/: "'"$off_white"'"/' ~/.cache/wal/colors.json
pywalfox update &
