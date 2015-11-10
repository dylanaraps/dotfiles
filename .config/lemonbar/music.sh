#!/bin/bash
# Dylan's lemonbar music script

volume() {
	if [[ $(pulseaudio-ctl full-status | awk '{printf $2}') == "yes" ]]; then
		vol="Mute"
		icon=""
	else
		mastervol=$(pulseaudio-ctl full-status | egrep -o "[0-9]+")
		vol=$mastervol
		icon=""
	fi

	echo "%{A4:pulseaudio-ctl up:}%{A5:pulseaudio-ctl down:}%{A:pulseaudio-ctl mute:} $icon $vol %{A}%{A}%{A}"
}

music() {
	if [[ $(mpc status | grep -o "\[playing\]") == "[playing]" ]]; then
		playing=" $(mpc current)"
	else
		playing="  "
	fi

	echo "%{A:mpc toggle:}%{A4:mpc next:}%{A5:mpc prev:}%{B#$blue}%{F#$white} $playing %{F}%{B}%{A}%{A}%{A}"
}

while :; do
	echo "%{r}$(volume) $(music)%{r}"
	sleep .1s
done |

lemonbar -g "970x$barheight+950" -f "drift" -f "xbmicons" -B "#00$black" -F "#$white" | bash

