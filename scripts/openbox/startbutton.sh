#!/bin/bash
eval "$(xdotool getmouselocation --shell)"

xdotool mousemove 0 30 &&
sleep .1
xdotool click 3
xdotool mousemove "$X" "$Y"



