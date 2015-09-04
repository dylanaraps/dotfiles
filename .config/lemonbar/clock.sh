#!/bin/bash
# Worksapce Switcher
size="1600x$barheight"

# Clock {{{

clock(){
	# Displays the date eg "Sun 17 May 9:10 AM"
	date=$(date '+%a %d %b %l:%M %p')
	echo "$date"
}

# }}}

while :; do
	echo "%{c}%{B#$black} $(clock) %{B}%{c}"
	sleep 1m
done |

lemonbar -g $size -f $barfont -f $baricons -B \#$black -F \#$white 2> /dev/null | bash
