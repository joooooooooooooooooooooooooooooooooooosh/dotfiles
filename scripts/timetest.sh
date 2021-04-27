#!/bin/zsh
#take in an integer value and create cron jobs to perform evenly across the day
let INT=1440/$1
let MIN=$INT%60
let HR=$((($INT-$MIN)/60))
#loop INT times, add min and hr to itself and make cron
for i in `seq 1 $1`; do
    let CINT=$(($INT*$i))
    let CMIN=$CINT%60
    let CHR=$((($CINT-$CMIN)/60))%24
    echo $CINT $CHR:$CMIN
done
exit 0
