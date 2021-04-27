#!/bin/bash
WINDOW=`i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name' | cut -d '"' -f2`
if [ "$1" = "next" ]
then
	((WINDOW=WINDOW + 1))
elif [ "$1" = "prev" ]
then
	((WINDOW=WINDOW - 1))
fi
i3-msg move container to workspace $WINDOW
i3-msg workspace $WINDOW