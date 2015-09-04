#!/bin/bash
# Worksapce Switcher
size="1600x3+0+20"

while :; do
	echo "%{+u}%{-u}"
	sleep 60m
done |

lemonbar -g $size -B \#$white | bash

