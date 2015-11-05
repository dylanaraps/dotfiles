#!/bin/bash
while :; do
	echo "%{c}$(date "+%a %d %b %l:%M %p")%{c}"
	sleep 1m
done |

lemonbar -g "1920x$barheight" -f "drift" -B "#$black" -F "#$white" 2> /dev/null | bash

