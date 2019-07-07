#!/bin/bash

if grep -E 'status_command.+;$' ~/.config/i3/config 
then
	#remove semicolon
	sed -i -E 's/(status_command.+) ;$/\1/' ~/.config/i3/config
else
	#add semicolon
	sed -i -E 's/(status_command.+)$/\1 ;/' ~/.config/i3/config
fi

i3-msg reload
