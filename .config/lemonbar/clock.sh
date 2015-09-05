#!/bin/bash

clock(){
	# "Sun 17 May 9:10 AM"
	date '+%a %d %b %l:%M %p'
}

while :; do
	echo "%{c}%{B#$black} $(clock) %{B}%{c}"
	sleep 1m
done |

lemonbar -g 1600x$barheight -f $barfont -f $baricons -B \#$black -F \#$white 2> /dev/null | bash
