#!/bin/bash
wal -q -i $1 -o wal-discord
spicetify update >/dev/null
outputs=`i3-msg -t get_outputs | jq '.[] | select(.active==true) | .current_workspace'`
xdotool windowactivate --sync $(wmctrl -lx | grep spotify\.Spotify | sed 's/\s.*//') key control+shift+r
for win in $outputs; do
	i3-msg workspace $win >/dev/null
done
pywalfox update
# cse /home/joshh/.vscode/extensions/dlasagno.wal-theme-1.0.4/themes/wal.json .vscode-server/extensions/dlasagno.wal-theme-1.0.4/themes/wal.json