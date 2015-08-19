#!/bin/bash
# Worksapce Switcher

# Variables {{{

if [[ $(xrandr | awk '/DFP10/ {print $1}') == "DFP10" ]]; then
	size="1600x$barheight"

elif [[ $(xrandr | awk '/eDP1/ {print $1}') == "eDP1" ]]; then
	size="1366x$barheight"

else
	size=""
fi

# }}}

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
