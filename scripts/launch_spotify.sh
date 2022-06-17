#!/bin/sh
spotify --remote-debugging-port=9222 &
sleep 5
spicetify -l watch
