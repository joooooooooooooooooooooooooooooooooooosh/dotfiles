#!/bin/bash
output=`i3-msg -t get_outputs | jq '.[] | select(.active==true) | .current_workspace, .name'`
if [ `i3-msg -t get_outputs | sed 's/"},/\n/g' | wc -l` -ne 2 ]; then
    exit
fi
i=`echo $output | cut -d\" -f2`
ispace=`echo $output | cut -d\" -f4`
j=`echo $output | cut -d\" -f6`
jspace=`echo $output | cut -d\" -f8`
i3-msg workspace $i
i3-msg move workspace to output $jspace
i3-msg workspace $j
i3-msg move workspace to output $ispace
i3-msg workspace $j
i3-msg workspace $i
~/.config/polybar/launch.sh
