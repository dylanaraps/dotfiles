#!/bin/sh
# Dylan's Lemonbar Clock

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh

while :; do
	echo "%{c}$(date "+%a %d %b %l:%M %p")%{c}"
	sleep 1s
done |

lemonbar -d -g "150x40+1670+990" -f "lemon" -B "#$white" -F "#$black"
