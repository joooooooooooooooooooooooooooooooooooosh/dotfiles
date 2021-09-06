#!/bin/bash
exit

wal -q -i $1
wal-discord
spicetify update >/dev/null
sed -i 's/@selected-.*fore/@back/' ~/.cache/wal/colors-rofi-dark.rasi

off_white=`grep color7 ~/.cache/wal/colors.json | cut -d\" -f4`
sed -i '/color15/s/: ".*"/: "'$off_white'"/' ~/.cache/wal/colors.json
pywalfox update
