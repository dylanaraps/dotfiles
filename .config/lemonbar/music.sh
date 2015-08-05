#!/bin/bash
# Music/Volume/Wifi/battery

source ~/.dotfiles/.config/lemonbar/variables.sh

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

	echo "%{$musictoggle}%{$musicnext}%{$musicprevious} %{F$blue}%{F}$playing %{A}%{A}%{A}"
}

# }}}

# Volume {{{

volume(){
	volup="A4:pulseaudio-ctl up:"
	voldown="A5:pulseaudio-ctl down:"
	volmute="A:pulseaudio-ctl mute:"

	# Volume Indicator
	if [[ $(pulseaudio-ctl full-status | awk '/ / {printf $2}') == "yes" ]]; then
		vol=$(echo " Mute")
		icon=
	else
		mastervol=$(pulseaudio-ctl full-status | awk '/ / {printf $1}')
		vol=$(echo " $mastervol")
		icon=
	fi

	echo "%{$volup}%{$voldown}%{$volmute} %{F$blue}$icon%{F}$vol %{A}%{A}%{A}"
}

# }}}

if [[ $(xrandr | awk '/DFP10/ {print $1}') == "DFP10" ]]; then
	size="400x$height+1200"

	while :; do
		echo "%{r}$(volume)$(music)%{r}"
		sleep .3s
	done |

	orangebar -g $size -f $font -f $icons -B \#00$bg -F $fg 2> /dev/null | bash

elif [[ $(xrandr | awk '/eDP1/ {print $1}') == "eDP1" ]]; then
	size="600x$height+766"
	source ~/.dotfiles/.config/lemonbar/laptop.sh

	while :; do
		echo "%{r}$(wifi) $(battery) $(volume) $(music) %{B\#00$black}%{r}"
		sleep .3s
	done |

	orangebar -g $size -f $font -f $icons -B \#00$bg -F $fg 2> /dev/null | bash

else
	size=""
fi

