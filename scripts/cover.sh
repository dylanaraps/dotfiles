#!/bin/bash
# Dylan's cover art script

# Cover directory
dir=$HOME/Music/covers/

# Image size
width=158
height=158

# Image offset
xoffset=0
yoffset=0

# Image format
format=jpg

while :; do
	currentsong=$(mpc current | sed -e 's/\///g')

	w3m_command="0;1;$xoffset;$yoffset;$width;$height;;;;;$dir$currentsong.$format\n4;\n3;"
	echo -e "$w3m_command" | /usr/lib/w3m/w3mimgdisplay

    # Update on mpd play/pause/next/prev and database update
	mpc idle player update
	clear
done

