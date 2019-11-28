#!/bin/sh

bud ~/Pictures/Wallpapers
xrdb ~/.Xresources

xset s 60 60
xset m 1/1
xset r rate 200 50
xset s off -dpms

xinput disable 'ELAN21EF:00 04F3:2200 Touchscreen'

exec sowm
