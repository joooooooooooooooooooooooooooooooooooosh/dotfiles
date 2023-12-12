#!/bin/bash

# required order: non primary, primary
outputs=$(xrandr --listactivemonitors \
    | awk '{print $4}' \
    | sed '1d' \
    | tac
)

original_wss=$(i3-msg -t get_workspaces | \
    jq ".[] | select(.visible==true).num"
)

fetch_wss() {
    i3-msg -t get_workspaces \
        | sed 's/\"urgent\":/\n/g' \
        | sed -E 's/.*\"num\":([^,]+,).*\"output\":\"([^"]+)\".*/\1\2/; $d'
}

ws_list=$(fetch_wss)

ws_on_output() {
    local output=$1
    grep -E "$output" <<< "$ws_list" \
        | cut -d, -f1
}

ws_reserved() {
    local ws=$1
    local norm_ws=$2
    fetch_wss \
        | grep -q "^$norm_ws,"
}

move_workspace() {
    local output=$1
    local ws=$2
    local norm_ws=$3

    i3-msg workspace "$ws"
    # TODO: how many layers do we need to go up?
    i3-msg focus parent; i3-msg focus parent; i3-msg focus parent; i3-msg focus parent; i3-msg focus parent; i3-msg focus parent; i3-msg focus parent;
    i3-msg move container to workspace "$norm_ws"
    # in case the new workspace is on another monitor by default
    i3-msg workspace "$norm_ws"
    i3-msg move workspace to output "$output"
    original_wss=$(sed "s/^$ws$/$norm_ws/g" <<< "$original_wss")
}


reserved_wss=""
min_ws=0
for output in $outputs; do
    norm_ws=$((norm_ws > min_ws ? norm_ws : min_ws))
    for ws in $(ws_on_output "$output"); do
        if [ "$ws" = "$norm_ws" ]; then
            norm_ws=$((norm_ws + 1))
            continue
        elif ws_reserved "$ws" "$norm_ws"; then
            reserved_wss=$(echo -en "$reserved_wss\n$output,$ws,$norm_ws")
            norm_ws=$((norm_ws + 1))
            continue
        fi

        move_workspace "$output" "$ws" "$norm_ws"
        norm_ws=$((norm_ws + 1))
    done

    min_ws=$((min_ws + 10))
done

# delete blank line at start
input=$(sed '1d' <<< "$reserved_wss")
junk_ws=100

booked_out_wss=""
i=1
while IFS=, read -r output ws norm_ws; do
    if sed "1,${i}d" <<< "$reserved_wss" | grep "$norm_ws" | grep -q ",$norm_ws,"; then
        # destination is used later
        booked_out_wss=$(echo -en "$booked_out_wss\n$output,$junk_ws,$norm_ws")
        move_workspace "$output" "$ws" "$junk_ws"
        junk_ws=$((junk_ws + 1))
    else
        move_workspace "$output" "$ws" "$norm_ws"
    fi

    i=$((i + 1))
done <<< "$input"

# i don't *think* a cycle of 4 is possible
# at least not on 2 monitors
# so we're good to not check cycles anymore

# delete blank line at start
booked_out_wss=$(sed '1d' <<< "$booked_out_wss")

while IFS=, read -r output ws norm_ws; do
    move_workspace "$output" "$ws" "$norm_ws"
done <<< "$booked_out_wss"


for ws in $original_wss; do
    i3-msg workspace "$ws"
done
