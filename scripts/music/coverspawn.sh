#!/bin/mksh
# Spawn a terminal that displays cover.sh

urxvt -bg "#$white" -hold -fn "xft:fixed" -b 0 -g 18x8 -e mksh -c cover.sh &

mpc update
mpc update
mpc update
