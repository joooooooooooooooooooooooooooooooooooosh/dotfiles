#!/bin/sh 
dir="$HOME/polybar-scripts"
list="$dir/.updatelist"
#list="/home/joshh/polybar-scripts/.updatelist"
# script=`realpath $0`     # get absolute path to the script itself
# exec 6< "$script"        # open bash script using file descriptor 6
# flock -n 6 || { sleep 5; list="/dev/null"; } # if script is already running, keep going but don't write to file
#exec 6<>/tmp/aur_lock
#flock -n 6 || list="/dev/null" # if script is already running, keep going but don't write to file

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
    echo "$updates_arch  $updates_aur" > "$dir/.polybar-aur"
else
    echo "" > "$dir/.polybar-aur"
fi
