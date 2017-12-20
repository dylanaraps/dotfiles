#!/bin/sh
#
# .xinitrc
redshift -l "37.8136:144.9631" &
urxvtd -q -f -o &

xrandr --dpi 144
xset s 60 60
xset m 1/1
setxkbmap -option caps:escape

wal -R -o wal-set

exec dbus-launch openbox
