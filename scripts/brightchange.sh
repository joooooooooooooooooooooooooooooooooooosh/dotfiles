#!/bin/zsh
if [ "$1" = "max" ]; then
	((BRIGHT = 4285))
elif [ "$1" = "high" ]; then
	((BRIGHT = 3214))
elif [ "$1" = "mid" ]; then
	((BRIGHT = 2143))
elif [ "$1" = "low" ]; then
	((BRIGHT = 1072))
elif [ "$1" = "min" ]; then
	((BRIGHT = 50))
elif [ "$1" = "off" ]; then
	((BRIGHT = 0))
elif [ "$1" = "up" ]; then
	((BRIGHT = `cat /sys/class/backlight/intel_backlight/brightness` + 150))
elif [ "$1" = "down" ]; then
	((BRIGHT = `cat /sys/class/backlight/intel_backlight/brightness` - 150))
else
	a=`rofi -dmenu -p "set brightness (0 - 4285)"`
	case $a in
    ''|*[!0-9]*) 
		echo "Usage: $0 [max|high|mid|low|min|NUMBER < 4285]"
		exit 1 ;;
    *) ((BRIGHT=$a)) ;;
	esac
fi
# if [ $BRIGHT -gt 4285 ]; then
#	echo "Usage: $0 [max|high|mid|low|min|NUMBER < 4285]"
#	exit 1
# fi
echo $BRIGHT | sudo tee /sys/class/backlight/intel_backlight/brightness
if [ $2 -a $2 != "!hdmi" ]; then
	xrandr --output HDMI-1 --brightness `bc -l <<< "scale=3; $BRIGHT / 4285"`
fi
polybar-msg hook brightness 1
