#!/bin/sh

#
# .xinitrc

# My locale randomly gets set to C
export LC_ALL=en_US.UTF-8

redshift -l "37.8136:144.9631" &

xset s 60 60
xset m 1/1
xset r rate 200 40
setxkbmap -option caps:escape
xmodmap -e 'keycode 70 = 0x0000'
xrdb ~/.Xresources

wal -R -o wal-set
xrandr --dpi 192
bar &
# compton -b

exec openbox
