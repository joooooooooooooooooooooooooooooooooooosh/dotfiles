#!/bin/sh

# stop bouncing on open and alert etc
defaults write com.apple.dock no-bouncing -bool TRUE

# should help dragging windows around, but not sure if it works
defaults write -g NSWindowShouldDragOnGesture -bool true

# similarly, don't remember if this works
defaults write NSGlobalDomain KeyRepeat -int 2

# I think this was for removing animations on minimise/open/etc
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
