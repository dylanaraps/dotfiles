#!/bin/sh

# Focus monitor
bspc monitor -f DVI-1

# Set urxvt windows to pseudo tiled
bspc rule -a URxvt pseudo_tiled=on

# Launch ncmpcpp/cava
urxvt -e cava &
urxvt -e ncmpcpp &
