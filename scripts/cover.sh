#!/bin/bash
dir=$HOME/Music/covers/

width=158
height=158

format=jpg

while :; do
	currentsong=$(mpc current | sed -e 's/\///g')

	w3m_command="0;1;0;0;$width;$height;;;;;$dir$currentsong.$format\n4;\n3;"
	echo -e "$w3m_command" | /usr/lib/w3m/w3mimgdisplay

	mpc idle player update
	clear
done

