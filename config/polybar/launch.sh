#!/bin/bash
ps ax | grep polybar | grep -Ev 'grep|launch.sh' | awk '{print $1}' | xargs kill -9
# TODO: only launch one bar when screens are duplicated
# TODO: if this is fixed change the polywins README example
# while pgrep -x polybar >/dev/null; do sleep 1; done
#polybar example & disown
if type "xrandr"; then
  for m in $(polybar --list-monitors | cut -d: -f1); do
    echo $m
    MONITOR=$m polybar example &
  done
else
  polybar example &
fi
