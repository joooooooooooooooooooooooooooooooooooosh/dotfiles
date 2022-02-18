#!/bin/bash
kill $(wmctrl -pl | grep "updatelist_polybar_aur" | sed -E 's/[^ ]+ +[^ ]+ +//' | cut -d' ' -f1) ||
    alacritty -t "updatelist_polybar_aur" -e zsh -ic 'while [ -f "/tmp/polybar-aur.lock" ]; do sleep 0.1; done; nvim $HOME/.config/polybar/polybar-scripts/.updatelist'
