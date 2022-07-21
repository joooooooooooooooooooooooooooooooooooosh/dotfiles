#!/bin/sh
spotify --remote-debugging-port=9222 &
sleep 3
spicetify -l watch
