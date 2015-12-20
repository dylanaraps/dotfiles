#!/bin/mksh
# Spawn a terminal that displays cover art
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Sleep
sleep 5

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh

# Spawn the terminal
urxvtc -bg "#$white" -hold -fn "xft:fixed" -b 0 -g 18x8 -e mksh -c cover.sh >/dev/null

# Get window id
wid=$(wattr whi $(lsw -a) | awk '/144 144/ {print $3;}')

# Ignore it
ignw -s "$wid"

# Add a border
chwb -s 7 -c "$white" "$wid"

# Move the window to the bottom right
wmv -a 1738 886 "$wid"

# Redraw album art
mpc update
mpc update
mpc update
