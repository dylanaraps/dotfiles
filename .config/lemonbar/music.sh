#!/bin/bash
# Music/Volume/Wifi/battery

# Music {{{

music(){
	musictoggle="A:mpc toggle:"
	musicnext="A4:mpc next:"
	musicprevious="A5:mpc prev:"

	# Displays currently playing mpd song, if nothing is playing it displays "Paused"
	if [[ $(mpc status | awk 'NR==2 {print $1}') == "[playing]" ]]; then
		current=$(mpc current)
		playing=$(echo " $current")
	else
		playing=$(echo " Paused")
		# playing=""
	fi

	echo "%{$musictoggle}%{$musicnext}%{$musicprevious}$playing %{A}%{A}%{A}"
}

# }}}

# Volume {{{

volume(){
	volup="A4:amixer set Master 5%+:"
 	voldown="A5:amixer set Master 5%-:"
 	volmute="A:amixer set Master toggle:"

	# Volume Indicator
	if [[ $(amixer get Master | awk '/Mono:/ {print $6}') == "[off]" ]]; then
		vol=$(echo " Mute")
		icon=
	else
		mastervol=$(amixer get Master | egrep -o '[0-9]{1,3}%' | sed -e 's/%//')
		vol=$(echo " $mastervol")
		icon=
	fi

	echo "%{$volup}%{$voldown}%{$volmute} %{F#$red}$icon%{F}$vol %{A}%{A}%{A}"
}

# }}}

size="400x$barheight+1200"

while :; do
	echo "\
	%{r}\
		$(volume) \
		%{B#$red}\
			$(music)\
		%{B}\
	%{r}"
	sleep .3s
done |

orangebar -g $size -f $barfont -f $baricons -B \#00$black -F \#$white 2> /dev/null | bash

