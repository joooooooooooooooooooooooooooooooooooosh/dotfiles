#!/bin/bash
kill $(wmctrl -pl | grep 'updatelist_polybar_aur' | cut -d' ' -f4) ||
    alacritty -t "updatelist_polybar_aur" -e zsh -ic 'while [ -f "/tmp/polybar-aur.lock" ]; do sleep 0.1; done; nvim $HOME/polybar-scripts/.updatelist'
