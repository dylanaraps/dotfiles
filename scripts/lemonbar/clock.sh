#!/bin/sh
# Dylan's Lemonbar Clock

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh

while :; do
	echo "%{c}$(date "+%a %d %b %l:%M %p")%{c}"
	sleep 1s
done |

lemonbar -d -g "150x40+1670+990" -f "-benis-lemon-medium-r-normal--10-110-75-75-m-50-ISO8859-1" -B "#$white" -F "#$black"
