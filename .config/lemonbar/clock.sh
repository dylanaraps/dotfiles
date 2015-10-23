#!/bin/bash
while :; do
	echo "%{c}%{B#$black} $(date "+%a %d %b %l:%M %p") %{B}%{c}"
	sleep 1m
done |

lemonbar -g "1920x$barheight" -f "lemon-j" -B "#$black" -F "#$white" 2> /dev/null | bash

