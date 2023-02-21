#!/bin/zsh
BACKLIGHT_PATH="/sys/class/backlight/amdgpu_bl0"
MAX_BRIGHTNESS=$(cat ${BACKLIGHT_PATH}/max_brightness)
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
	((BRIGHT = `cat ${BACKLIGHT_PATH}/brightness` + MAX_BRIGHTNESS / 25))
elif [ "$1" = "down" ]; then
	((BRIGHT = `cat ${BACKLIGHT_PATH}/brightness` - MAX_BRIGHTNESS / 25))
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
# if [ $BRIGHT -gt 4285 ]; then
#	echo "Usage: $0 [max|high|mid|low|min|NUMBER < 4285]"
#	exit 1
# fi
echo $BRIGHT | sudo tee ${BACKLIGHT_PATH}/brightness
XRANDR_BRIGHTNESS=`bc -l <<< "scale=3; $BRIGHT / $MAX_BRIGHTNESS"`
if [ $2 -a $2 != "!hdmi" ]; then
	# killall redshift
	# i3-msg exec "redshift -b $XRANDR_BRIGHTNESS:$XRANDR_BRIGHTNESS -r"
	xrandr --output DisplayPort-1 --brightness $XRANDR_BRIGHTNESS
fi

# polybar-msg action "#brightness.hook.0"
