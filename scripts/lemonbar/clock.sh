#!/bin/bash
# Dylan's bar
while :; do
	echo "%{c}$(date "+%a %d %b %l:%M %p")%{c}"
	sleep 1s
done |

lemonbar -d -g "150x30+1670+1015" -f "drift" -f "xbmicons" -B "#$white" -F "#$black"
