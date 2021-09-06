#!/bin/bash

wal -q -i $1
wal-discord
spicetify update >/dev/null
sed -i 's/@selected-.*fore/@back/' ~/.cache/wal/colors-rofi-dark.rasi

off_white=`grep color7 ~/.cache/wal/colors.json | cut -d\" -f4`
sed -i '/color15/s/: ".*"/: "'$off_white'"/' ~/.cache/wal/colors.json
pywalfox update &

# could probably do this much more easily by copying first x lines of file but whatever
for change in `grep ": #" ~/.cache/wal/colors-rofi-dark.rasi | sed 's/ //g'`; do
    field=`echo $change | cut -d# -f1`
    color=`echo $change | cut -d# -f2`
    sed -i "/ $field/s/#.*/#$color/" ~/.config/rofi/wal-theme.rasi
done
