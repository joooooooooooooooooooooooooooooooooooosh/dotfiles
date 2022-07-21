#!/bin/sh

cat /sys/firmware/acpi/platform_profile_choices |
    sed '1p' |
    tr ' ' '\n' |
    grep $(cat /sys/firmware/acpi/platform_profile) -A1 -m1 |
    tail -1 |
    sudo tee /sys/firmware/acpi/platform_profile
