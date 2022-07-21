#!/bin/zsh
if [ -z $1 ]; then
    con=`bluetoothctl devices | cut -d' ' -f3- | tac |
       rofi -dmenu -i -columns 2 -matching fuzzy -p "(dis)connect"`
    if [ -z $con ]; then
        exit 1
    fi
    1=`bluetoothctl devices | grep $con | cut -d' ' -f2`
fi

coproc bluetoothctl
if hcitool con | grep $1
then
    echo -e "disconnect $1" >&p
else
    echo -e "connect $1" >&p
fi
sleep 3
echo -e 'exit' >&p
sleep 2
