#!/bin/bash
# Worksapce Switcher

# Variables {{{

source ~/.dotfiles/.config/lemonbar/variables.sh

if [[ $(xrandr | awk '/DFP10/ {print $1}') == "DFP10" ]]; then
	size="1600x$height"

elif [[ $(xrandr | awk '/eDP1/ {print $1}') == "eDP1" ]]; then
	size="1366x$height"

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

lemonbar -g $size -f $font -f $icons -B $bg -F $fg 2> /dev/null | bash
