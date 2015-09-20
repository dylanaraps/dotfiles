#!/bin/sh

# Focus monitor
bspc monitor -f DVI-1

# Launch ncmpcpp/cava
urxvt -e cava &
urxvt -e ncmpcpp &

sleep .1s
bspc desktop hello -R 90


