#!/bin/sh
if [[ $(bspc query -D -d) == "hello" ]]; then
	bspc rule -a URxvt pseudo_tiled=on
	urxvt
else
	bspc rule -a URxvt pseudo_tiled=off
	urxvt
fi
