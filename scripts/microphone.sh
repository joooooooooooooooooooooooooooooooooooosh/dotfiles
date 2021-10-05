#!/bin/bash

# update loop immediately on SIGUSR1
trap 'echo -n' SIGUSR1

while true; do
    input=`pacmd stat | grep source | cut -d' ' -f4`
    pacmd list-sources | 
        grep $input -A 10 |
        grep volume -m1 |
        cut -d/ -f2 |
        sed "s/\s/$(pulseaudio-ctl full-status |
            cut -d' ' -f3 |
            sed 's/no//; s/yes//') /; s/\s*$//"
    sleep 2 &
    wait $!
done
