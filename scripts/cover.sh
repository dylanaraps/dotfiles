#!/bin/sh
dir=$HOME/Music/covers/

width=298
height=298

format=jpg

while :; do
	currentsong=$(mpc current | sed -e 's/\///g')

	# feh -g 140x140 -Z $HOME/Music/covers/"$currentsong".jpg
	w3m_command="0;1;0;0;$width;$height;;;;;$dir"$currentsong".$format\n4;\n3;"
	echo -e $w3m_command | /usr/lib/w3m/w3mimgdisplay

	mpc idle player update
	clear
done

