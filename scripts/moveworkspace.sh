#!/bin/sh
# move workspaces to correct outputs
currwin=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d '"' -f2`
for win in `i3-msg -t get_workspaces | sed 's/,/\n/g' | grep name | cut -d\" -f4`; do
    if test $win -le 10 && !(i3-msg -t get_workspaces | jq ".[] | select(.name==\"$win\")" | grep HDMI1); then
        i3-msg workspace $win
        i3-msg move workspace to output HDMI1
    elif test $win -gt 10 && !(i3-msg -t get_workspaces | jq ".[] | select(.name==\"$win\")" | grep eDP1); then
        i3-msg workspace $win
        i3-msg move workspace to output eDP1
    fi
done
i3-msg workspace $currwin