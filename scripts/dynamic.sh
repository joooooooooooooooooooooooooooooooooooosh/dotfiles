#!/bin/zsh
#assumes directory exists and all contained files are images, and in ~/Pictures/...
#could also work out a rounding system for uneven minute divisions
#look into lockscreen options, syncing up changes with time of day, custom config
#wallpaper goes out of sync when computer sleeps
if [ $# -ne 1 ]
then
    echo "Usage: dynamic.sh [-s]|[-r]|[folder name]"
    exit 1
fi
if test "$1" = "-s"
then
    crontab -l | grep -v 'wal-discord' | crontab -
    exit 0
fi
OPT="--iterative"
if test "$1" = "-r"
then
    DIR=~/Pictures/wallpapers
    OPT=""
else
    DIR=~/Pictures/wallpapers/dynamic/$1
fi
COUNT=`cd $DIR; ls -l | wc -l`
let INT=1440/$(($COUNT-1))
if test $(($INT % 1)) -ne 0
then
    echo "Number of pictures must divide into 1440 (no. of mins)"
    exit 1
fi
crontab -l | grep -v 'wal-discord' | crontab -
let MIN=$INT%60
let HR=$((($INT-$MIN)/60))
for i in `seq 1 $(($COUNT-1))`; do
    let CINT=$(($INT*$i))
    let CMIN=$CINT%60
    let CHR=$((($CINT-$CMIN)/60))%24
    (crontab -l; echo "$CMIN $CHR * * * DISPLAY=:0.0 /usr/local/bin/wal -i $DIR $OPT -o wal-discord && pywalfox update") | crontab -
done
wal -i $DIR $OPT -o wal-discord && pywalfox update
exit 0
