#!/bin/bash
batt=$(acpi -b | awk '{sum += $4} END {print int(sum/NR)}')

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
