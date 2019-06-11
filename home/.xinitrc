#!/bin/sh

xinput disable "Lenovo EasyCamera: Lenovo EasyC"
xinput disable "ELAN21EF:00 04F3:2200"

xset s 60 60
xset m 1/1
xset r rate 200 50

xrdb ~/.Xresources
bud  ~/Pictures/Wallpapers

xrandr --dpi 192
xcalib ~/Downloads/SAMSUNG__L_YLLTN133YL05L02.icm

exec openbox
