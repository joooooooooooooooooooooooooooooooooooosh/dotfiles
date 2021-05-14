#!/bin/bash
device=`hcitool con | grep -v F8:B7:1E:B3:7C:67 | grep handle | cut -d' ' -f3`
$HOME/Documents/scripts/bluescript.sh $device
