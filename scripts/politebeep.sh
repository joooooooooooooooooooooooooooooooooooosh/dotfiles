#!/bin/sh
#beep on volume keypress iff media is not playing
if test $# -ne 1 || test "$1" != "up" && test "$1" != "down"; then
    echo "Usage: politebeep.sh [up|down]"
    exit 1
fi
#unmute
if (pulseaudio-ctl full-status | cut -d' ' -f2 | grep yes); then
    pulseaudio-ctl mute
fi

pulseaudio-ctl "$1"

# ignoring musescore since it always lists sink as on
if ! (pacmd list-sink-inputs | 
     grep -E "state: RUNNING|application.name =" |
     sed -E '{N; s/state:.*\n.*MuseScore.*// ;P;D}' |
     grep "state: RUNNING" >/dev/null); then

    #nothing is playing audio
    play /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga
fi
