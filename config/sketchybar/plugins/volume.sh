#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
  [6-9][0-9] | 100)
    ICON="󰕾"
    ;;
  [3-5][0-9])
    ICON="󰖀"
    ;;
  [1-9] | [1-2][0-9])
    ICON="󰕿"
    ;;
  *) ICON="󰖁" ;;
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
elif [ "$SENDER" = "mouse.scrolled" ]; then
  DIRECTION="+"
  if echo "$SCROLL_DELTA" | grep -q "-"; then
    DIRECTION="-"
  fi

  /usr/bin/osascript -e "set volume output volume (output volume of (get volume settings) ${DIRECTION} 5)"
elif [ "$ACTION" = "toggle-mute" ]; then
  muted=$(/usr/bin/osascript -e 'output muted of (get volume settings)')
  action="with"
  if [ "$muted" = "true" ]; then
    action="without"
  fi

  /usr/bin/osascript -e "set volume ${action} output muted"
fi
