#!/bin/bash

# if the last open desktop is empty, use that desktop
check_empty_desktop() {
    numwindows=$(i3-msg -t get_tree | jq -r "recurse(.nodes[]) | select(.name==\"$((move - 1))\").nodes | length")
    if [ "$numwindows" -eq 0 ]; then
        move=$((move - 1))
    fi
}

move_left() {
    move=$(($(i3-msg -t get_workspaces | sed 's/,/\n/g' | grep name | cut -d\" -f4 | sort -nr | grep ^.$ | head -1) + 1))
    check_empty_desktop
}

move_right() {
    move=$(($(i3-msg -t get_workspaces | sed 's/,/\n/g' | grep name | cut -d\" -f4 | sort -nr | head -1) + 1))
    check_empty_desktop
}

move_container() {
    i3-msg move container to workspace $move
    i3-msg workspace $move
}

if [ "$1" == "left" ]; then
    move_left

    if [ $move -ge 10 ]; then
        # use a workspace from the right monitor on the left
        move_right
        move_container
        i3-msg move workspace to output left
    else
        move_container
    fi
else 
    move_right

    if [ $move -lt 10 ]; then
        move=10
    fi
    move_container
fi

# TODO: move out of other desktop if it's now empty?
