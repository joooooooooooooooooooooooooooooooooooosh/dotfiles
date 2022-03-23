#!/usr/bin/env bash

if [ -z "$1" ] || [ "$1" != "tail" ] && [ "$1" != "head" ]; then
	echo "Usage: $0 [tail|head]"
	exit 1
fi

monitor=$(i3-msg -t get_workspaces |
	sed -E 's/output\":([^,]+),/output\1\n/g' |
	grep \"focused\":true |
	sed 's/.*output\"//')

i3-msg workspace "$(i3-msg -t get_workspaces |
    sed -E 's/output\":([^,]+),/\1\n/g' |
	grep "$monitor" |
	$1 -1 |
	sed -E 's/.*num\":([^,]+),.*/\1/')"
