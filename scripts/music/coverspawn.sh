#!/bin/mksh
# Spawn a terminal that displays cover art
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh

# Spawn the terminal
urxvtc -name "Music" -bg "#$white" -fn "xft:fixed" -b 3 -g 18x7 -e mksh -c "cover 140" >/dev/null

# Redraw album art
mpc update
mpc update
mpc update
