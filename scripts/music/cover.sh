#!/bin/mksh
# Display cover art based on "mpc current"
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Show cursor on exit
trap 'printf "\033[?25h"; clear; exit' 2

# Set terminal title
echo -e '\033]2;'Music'\007'

# Hide terminal cursor
tput civis

# Clear terminal output
clear

# Cover directory
dir=$HOME/Music/covers/

# Image size
width=$1
height=$1

# Image offset
xoffset=0
yoffset=0

# Image format
format=jpg

while :; do
	currentsong=$(mpc current)
    currentsong=${currentsong//\/}
    img="$dir$currentsong.$format"

	w3m_command="0;1;$xoffset;$yoffset;$width;$height;;;;;$img\n4;\n3;"
	echo -e "$w3m_command" | /usr/lib/w3m/w3mimgdisplay

    # Update on mpd play/pause/next/prev and database update
	mpc idle player update > /dev/null 2>&1
done

