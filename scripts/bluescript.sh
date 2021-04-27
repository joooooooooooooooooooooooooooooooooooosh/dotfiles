#!/bin/zsh
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
polybar-msg hook headphones 1
#polybar-msg cmd restart
