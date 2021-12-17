#!/bin/bash
batt=`acpi | awk '{print $4;}' | awk '{sum += $1} END {print int(sum/2)}'`

if acpi -a | grep on >/dev/null; then
    icon=""
elif test $batt -gt 75; then
	icon=""
elif test $batt -gt 50; then
	icon=""
elif test $batt -gt 25; then
	icon=""
else
	icon=""
fi

echo "$icon $batt%"
