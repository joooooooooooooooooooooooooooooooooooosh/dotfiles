#!/bin/sh

# /device\.profile\.description/{s/.*"(.*)"/\1/; p}; 
sink=$(pactl list sinks \
    | sed -En '/Sink #/{s/.*#//; p}; /device\.description/{s/.*"(.*)"/\1/; p}' \
    | sed -n 'N; s/\n/ /; p' \
    | rofi -dmenu -i -columns 2 -matching fuzzy -p "(dis)connect" \
    | cut -d' ' -f1
)

if [ -z "$sink" ]; then
    echo "No sink specified."
    exit 1
fi

pacmd set-default-sink "$sink"
for i in $(pacmd list-sink-inputs | grep index | cut -d: -f2); do
    pacmd move-sink-input "$i" "$sink"
done
