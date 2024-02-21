#!/bin/sh

# /device\.profile\.description/{s/.*"(.*)"/\1/; p}; 
active_sink=$(pacmd dump \
    | grep set-default-sink \
    | cut -d' ' -f2
)

# | sed -En '/Sink #/{s/.*#//; p}; /device\.description/{s/.*"(.*)"/\1/; p}' \
sink=$(stdbuf -o0 pactl list sinks \
    | sed -En "
	/Sink #/{s/.*#//; p}
	/${active_sink}$/{N; s/$/ (Connected)/}
	/Description:/{s/.*Description: //; p}" \
    | sed -n 'N; s/\n/ /; p' \
    | column -t -l 2 \
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
