#!/bin/bash

music(){
	mtoggle="A:mpc toggle:"
	mnext="A4:mpc next:"
	mprevious="A5:mpc prev:"

	if [[ $(mpc status | grep -o "\[playing\]") == "[playing]" ]]; then
		playing=$(mpc current)
	else
		playing="Paused"
	fi

	echo "%{$mtoggle}%{$mnext}%{$mprevious} $playing %{A}%{A}%{A}"
}

volume(){
	volup="A4:amixer set Master 5%+:"
 	voldown="A5:amixer set Master 5%-:"
 	volmute="A:amixer set Master toggle:"

	if [[ $(amixer get Master | grep -o "\[off\]") == "[off]" ]]; then
		vol="Mute"
		icon=""
	else
		mastervol=$(amixer get Master | egrep -o "[0-9]+%" | tr -d '%')
		vol=$mastervol
		icon=""
	fi

	echo "%{$volup}%{$voldown}%{$volmute} %{F#$red}$icon%{F} $vol %{A}%{A}%{A}"
}

while :; do
	echo "%{r}$(volume) %{B#$red}$(music)%{B}%{r}"
	sleep .3s
done |

orangebar -g 400x$barheight+1200 -f $barfont -f $baricons -B \#00$black -F \#$white 2>/dev/null | bash

