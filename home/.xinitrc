#!/bin/sh

bud ~/Pictures/Wallpapers
xrdb ~/.Xresources

xset s 60 60
xset m 1/1
xset r rate 200 50
xset s off -dpms

exec sowm

