#!/bin/bash
if [[ $(xdotool getwindowfocus getwindowname) == "Counter-Strike: Global Offensive - OpenGL" ]]; then
	while :; do
		xdotool key --window "$(xdotool search --class csgo_linux | head -n 1)" space
		sleep
	done
else
	xdotool key space
fi
