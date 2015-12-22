#!/bin/mksh
# Spawn a terminal that displays cover art
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh

# Spawn the terminal
urxvtc -name "Music" -bg "#$white" -hold -fn "xft:fixed" -b 0 -g 18x8 -e mksh -c cover.sh >/dev/null

# Redraw album art
mpc update
mpc update
mpc update
