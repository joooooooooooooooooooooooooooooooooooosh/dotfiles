#!/bin/zsh
BACKLIGHT_PATH="/sys/class/backlight/"
MAX_BRIGHTNESS=$(cat ${BACKLIGHT_PATH}/*/max_brightness)
if [ "$1" = "max" ]; then
	((BRIGHT = MAX_BRIGHTNESS - 1))
elif [ "$1" = "high" ]; then
	((BRIGHT = MAX_BRIGHTNESS * 3 / 4))
elif [ "$1" = "mid" ]; then
	((BRIGHT = MAX_BRIGHTNESS / 2))
elif [ "$1" = "low" ]; then
	((BRIGHT = MAX_BRIGHTNESS / 4))
elif [ "$1" = "min" ]; then
	((BRIGHT = 10))
elif [ "$1" = "off" ]; then
	((BRIGHT = 0))
elif [ "$1" = "up" ]; then
	((BRIGHT = `cat ${BACKLIGHT_PATH}/*/brightness` + MAX_BRIGHTNESS / 25))
elif [ "$1" = "down" ]; then
	((BRIGHT = `cat ${BACKLIGHT_PATH}/*/brightness` - MAX_BRIGHTNESS / 25))
else
	a=$1
	case $a in
    ''|*[!0-9]*) 
		echo "Usage: $0 [max|high|mid|low|min|NUMBER < $MAX_BRIGHTNESS]"
		exit 1 ;;
    *) ((BRIGHT=$a)) ;;
	esac
fi

((BRIGHT = BRIGHT + 1))
if [ $BRIGHT -gt $MAX_BRIGHTNESS ]; then
	 BRIGHT=$MAX_BRIGHTNESS
fi

echo $BRIGHT | sudo tee ${BACKLIGHT_PATH}/*/brightness
XRANDR_BRIGHTNESS=`bc -l <<< "scale=3; $BRIGHT / $MAX_BRIGHTNESS"`
if [ $2 -a $2 != "!hdmi" ]; then
	for output in $(xrandr --listmonitors | sed '1d; s/.* //' | grep -v eDP); do
		xrandr --output $output --brightness $XRANDR_BRIGHTNESS
	done
fi

# polybar-msg action "#brightness.hook.0"
