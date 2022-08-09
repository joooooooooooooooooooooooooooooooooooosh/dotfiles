#!/bin/sh
case $1 in
0|off)
    arg=0
    ;;
1|on)
    arg=1
    ;;
*)
    echo "usage: $0 [0|off|1|on]"
    exit
    ;;
esac

echo $arg | sudo tee /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
