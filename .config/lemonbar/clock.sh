#!/bin/bash
while :; do
	echo "%{c}$(date "+%a %d %b %l:%M %p")%{c}"
	sleep 1m
done |

lemonbar -name clockbar -g "1920x$barheight" -f "lemon-j" -B "#$black" -F "#$white" 2> /dev/null | bash

