#!/bin/bash
music(){
	if [[ $(mpc status | grep -o "\[playing\]") == "[playing]" ]]; then
		playing=$(mpc current)
	else
		playing="Paused"
	fi

	echo "%{A:mpc toggle:}%{A4:mpc next:}%{A5:mpc prev:}%{B#$blue}%{F#$white} $playing %{F}%{B}%{A}%{A}%{A}"
}

volume(){
	if [[ $(pulseaudio-ctl full-status | awk '/ / {printf $2}') == "yes" ]]; then
		vol="Mute"
		icon="x"
	else
		mastervol=$(pulseaudio-ctl full-status | egrep -o "[0-9]+")
		vol=$mastervol
		icon="^"
	fi

	echo "%{A4:pulseaudio-ctl up:}%{A5:pulseaudio-ctl down:}%{A:pulseaudio-ctl mute:} $icon $vol %{A}%{A}%{A}"
}

while :; do
	echo "%{r}$(volume) $(music)%{r}"
	sleep .1s
done |

lemonbar -g "1000x$barheight+920" -f "drift" -B "#00$black" -F "#$white" 2>/dev/null | bash

