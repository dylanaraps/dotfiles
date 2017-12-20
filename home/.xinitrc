#!/bin/sh
#
# .xinitrc
redshift -l "37.8136:144.9631" &
urxvtd -q -f -o &

xset s 60 60
xset m 1/1
setxkbmap -option caps:escape

xrdb ~/.Xresources
wal -R -o wal-set
xrandr --dpi 144

exec dbus-launch openbox
