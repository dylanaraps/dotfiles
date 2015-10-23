#!/bin/bash
while :; do
	echo "%{c}%{B#$black} $(date "+%a %d %b %l:%M %p") %{B}%{c}"
	sleep 1m
done |

lemonbar -d -g "1920x$barheight" -f "$barfont" -f "$baricons" -B "#$black" -F "#$white" 2> /dev/null | bash

