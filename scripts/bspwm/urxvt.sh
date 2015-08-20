#!/bin/sh
desktop="bspc query -D -d"

if [[ $(bspc query -D -d) == "$ws2" ]]; then
	bspc rule -a URxvt pseudo_tiled=on
	urxvt --geometry 110x60
else
	bspc rule -a URxvt pseudo_tiled=off
	urxvt
fi
