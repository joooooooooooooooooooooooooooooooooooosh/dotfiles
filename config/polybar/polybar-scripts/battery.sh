#!/bin/bash
batt=$(acpi -b | grep -v "rate information unavailable" | sed -E 's/^.* (.+)%/\1/' | awk '{sum += $1} END {print int(sum/NR)}')

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
