#!/bin/bash

wal -q -i "$@"
killall dunst

if [ "$2" != "-l" ]; then
    wal-discord
    sed 's/#//' ~/.cache/wal/spicetify_color.ini > ~/.config/spicetify/Themes/WalSleek/color.ini

    # replace white colour used by firefox
    off_white=$(grep color7 ~/.cache/wal/colors.json | cut -d\" -f4)
    sed -i '/color15/s/: ".*"/: "'"$off_white"'"/' ~/.cache/wal/colors.json
    pywalfox update &
fi

# invert text colour of selected element
sed -i 's/@selected-.*fore/@back/' ~/.cache/wal/colors-rofi-dark.rasi

# change border colour
kill $(pgrep xborders)

# xborders launch with alpha value 0xaa
~/.config/i3/xborder/xborders --smart-hide-border --border-radius 8 --border-mode center --border-width 4 --border-rgba "$(grep color6 ~/.cache/wal/colors.json | cut -d\" -f4)aa" & disown
