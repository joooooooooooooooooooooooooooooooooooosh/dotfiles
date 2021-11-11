#!/bin/sh 
dir="$HOME/polybar-scripts"
list="$dir/.updatelist"
polybar_output="$dir/.polybar-aur"
tmp_lock="/tmp/polybar-aur.lock"

if [ -f $tmp_lock ]; then
    exit
fi
touch $tmp_lock

printf "### Pacman updates ###\n\n" > $list

if ! updates_arch=$(checkupdates 2> /dev/null | tee -a $list | wc -l ); then
    updates_arch=0
fi

printf "\n### AUR updates ###\n\n" >> $list

if ! updates_aur=$(yay -Qum 2> /dev/null | tee -a $list | wc -l); then
    updates_aur=0
fi

updates=$(("$updates_arch" + "$updates_aur"))

if [ "$updates" -gt 0 ]; then
    echo "$updates_arch  $updates_aur" > $polybar_output
else
    echo "" > $polybar_output
fi

rm $tmp_lock
