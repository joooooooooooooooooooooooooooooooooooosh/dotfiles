#!/bin/zsh
if [ -z $1 ]; then
    con=$({bluetoothctl devices; bluetoothctl devices Connected} \
        | sort | uniq -c | sort -nr \
        | sed '/^ *[^1] Device/{s/$/ (Connected)/}' \
        | awk '{ for(i=4; i<=NF; ++i) printf $i""FS; print "" }' \
        | rofi -dmenu -i -columns 2 -matching fuzzy -p "(dis)connect" \
        | sed 's/ (Connected) $//; s/ *$//')
    if [ -z $con ]; then
        exit 1
    fi
    1=$(bluetoothctl devices | grep "$con" | cut -d' ' -f2)
fi

if bluetoothctl devices Connected | grep $1
then
    bluetoothctl <<< "disconnect $1"
else
    bluetoothctl <<< "connect $1"
fi
