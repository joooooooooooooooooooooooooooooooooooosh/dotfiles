#!/bin/sh
# move workspaces to correct outputs
currwin=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d '"' -f2`
for win in `i3-msg -t get_workspaces | sed 's/,/\n/g' | grep name | cut -d\" -f4`; do
    if test $win -lt 10 && !(i3-msg -t get_workspaces | jq ".[] | select(.name==\"$win\").output" | grep "HDMI-1"); then
        i3-msg workspace $win
        i3-msg move workspace to output HDMI-1
    elif test $win -ge 10 && !(i3-msg -t get_workspaces | jq ".[] | select(.name==\"$win\").output" | grep eDP-1); then
        i3-msg workspace $win
        i3-msg move workspace to output eDP-1
    fi
done
i3-msg workspace $currwin
~/.config/polybar/launch.sh
