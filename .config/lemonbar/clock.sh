#!/bin/bash
# Worksapce Switcher

# Variables {{{

white="FFFFFF"
black="#FF1C1C1C"

font="-benis-lemon-medium-r-normal--10-110-75-75-m-50-iso8859-1"
icons="-wuncon-sijipatched-medium-r-normal--10-100-75-75-c-80-iso10646-1"

if [[ $(xrandr | awk '/DFP10/ {print $1}') == "DFP10" ]]; then
	size="1600x25"

elif [[ $(xrandr | awk '/eDP1/ {print $1}') == "eDP1" ]]; then
	size="1366x25"

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
	echo "%{c}%{B$black} $(clock) %{B}%{c}"
	sleep 1m
done |

lemonbar -g $size -f $font -f $icons -B $black -F \#FF$white 2> /dev/null | bash
