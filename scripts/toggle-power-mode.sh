#!/bin/sh

choices=$(
    cat /sys/firmware/acpi/platform_profile_choices \
        | sed '1p' \
        | tr ' ' '\n'
)

if [ $1 ]; then
    if ! grep "^$1\$" <<< $choices >/dev/null; then
        echo "usage: $0 [power_mode]"
        exit 1
    fi

    mode=$1
else
    mode=$(
        grep $(cat /sys/firmware/acpi/platform_profile) -A1 -m1 <<< $choices \
            | tail -1
    )
fi

echo $mode | sudo tee /sys/firmware/acpi/platform_profile
