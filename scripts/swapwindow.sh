#!/bin/bash
DISPLAY_CONFIG=($(i3-msg -t get_outputs | jq -r '.[]|select(.name != "xroot-0")|"\(.name):\(.current_workspace)"'))

for ROW in "${DISPLAY_CONFIG[@]}"
do
    IFS=':' read -r window workspace <<< "${ROW}"
    if [ "${window}" != "null" ] && [ "${workspace}" != "null" ]; then
        echo "moving ${workspace} right..."
        i3-msg -- workspace --no-auto-back-and-forth "${workspace}"
        i3-msg -- move workspace to output right	
    fi
done
