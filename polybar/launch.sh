#!/bin/bash
killall -q polybar &
#polybar-msg cmd quit &
wait
# TODO: only launch one bar when screens are duplicated
#while pgrep -x polybar >/dev/null; do sleep 2; done
#polybar example & disown
if type "xrandr"; then
  if [ `xrandr --query | grep " connected.*+0+0" | wc -l` -gt 1 ]; then
    MONITOR=eDP1 polybar example &
    exit
  fi
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    echo $m
    MONITOR=$m polybar --reload example &
  done
else
  polybar --reload example &
fi
