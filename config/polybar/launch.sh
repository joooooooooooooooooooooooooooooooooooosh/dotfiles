#!/bin/bash

# give scripts a chance to clean up nicely first (e.g. aur script)
ps ax | grep polybar | grep -Ev 'grep|launch.sh|vim' | awk '{print $1}' | xargs kill
ps ax | grep polybar | grep -Ev 'grep|launch.sh|vim' | awk '{print $1}' | xargs kill -9

# TODO: only launch one bar when screens are duplicated
# TODO: if this is fixed change the polywins README example
# while pgrep -x polybar >/dev/null; do sleep 1; done
# polybar example & disown
if type "xrandr"; then
  for m in $(polybar --list-monitors | cut -d: -f1); do
    bar=$m
    if ! sed -En "s/^\[bar\/([^]]+)\]/\1/; T; p" ~/.config/polybar/config.ini \
        | grep "^$m$" >/dev/null; then
      bar="example"
    fi
      
    echo $m launching $bar
    MONITOR=$m polybar $bar &
  done
else
  polybar example &
fi
