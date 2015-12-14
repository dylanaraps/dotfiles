#!/bin/mksh
# Spawn a terminal that displays cover.sh

urxvt -bg "#$white" -hold -fn "xft:drift" -b 0 -g 24x11 -e mksh -c cover.sh &

mpc update
mpc update
mpc update
