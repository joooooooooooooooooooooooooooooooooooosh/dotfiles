#!/usr/bin/env bash

scratchpad_id=$(yabai -m query --windows | jq '.[] | select(.title=="Scratchpad").id')

if [ -z "$scratchpad_id" ]; then
  open -a Alacritty -n --args -t Scratchpad
  sleep 0.1
  scratchpad_id=$(yabai -m query --windows | jq '.[] | select(.title=="Scratchpad").id')
  yabai -m window --focus "$scratchpad_id"
  yabai -m window --resize abs:1920:1080
  yabai -m window --move abs:960:540
else
  current_space=$(yabai -m query --spaces --space | jq '.index')
  read -r scratchpad_space is_minimized <<< \
    "$(yabai -m query --windows --window "$scratchpad_id" | jq -j '.space," ", ."is-minimized"')"

  if [[ "$is_minimized" = "true" ]] || [[ $current_space -ne $scratchpad_space ]]; then
    yabai -m window "$scratchpad_id" --space "$current_space"
    yabai -m window --focus "$scratchpad_id"
  else
    yabai -m window "$scratchpad_id" --minimize
  fi
fi
