#!/bin/bash
MOUSE_ADDR="F8:B7:1E:B3:7C:68"
if hcitool con | grep -v $MOUSE_ADDR | grep handle >/dev/null
then
    echo ""
else
    echo ""
fi
