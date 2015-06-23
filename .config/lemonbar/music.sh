#!/bin/bash
# Worksapce Switcher

# Variables {{{

white="FFFFFF"
black="#1C1C1C"
darkgrey="#252525"
blue="#689D6A"
lightblue="#8EC07C"
yellow="#FABD2F"

font="-benis-lemon-medium-r-normal--10-110-75-75-m-50-iso8859-1"
icons="-wuncon-sijipatched-medium-r-normal--10-100-75-75-c-80-iso10646-1"

# }}}

# Music {{{

music(){
	musictoggle="A:mpc toggle:"
	musicnext="A4:mpc next:"
	musicprevious="A5:mpc prev:"

	# Displays currently playing mpd song, if nothing is playing it displays "Paused"
	if [[ $(mpc status | awk 'NR==2 {print $1}') == "[playing]" ]]; then
		current=$(mpc current)
		playing=$(echo " $current")
	else
		# playing=$(echo " Paused")
		playing=$(echo "")
	fi

	echo "%{$musictoggle}%{$musicnext}%{$musicprevious} $playing %{A}%{A}%{A}"
}

# }}}

# Volume {{{

volume(){
	volup="A4:pulseaudio-ctl up:"
	voldown="A5:pulseaudio-ctl down:"
	volmute="A:pulseaudio-ctl mute:"

	# Volume Indicator
	if [[ $(pulseaudio-ctl full-status | awk '/ / {printf $2}') == "yes" ]]; then
		vol=$(echo " Mute")
	else
		mastervol=$(pulseaudio-ctl full-status | awk '/ / {printf $1}')
		vol=$(echo " $mastervol")
	fi

	echo "%{$volup}%{$voldown}%{$volmute} $vol %{A}%{A}%{A}"
}

# }}}

if [[ $(xrandr | awk '/DFP10/ {print $1}') == "DFP10" ]]; then
	size="600x25+1000"

	while :; do
		echo "%{r}%{B$blue}$(volume)$(music)%{B}%{r}"
		sleep .1s
	done |

	lemonbar -g $size -f $font -f $icons -B $black -F \#FF$white 2> /dev/null | bash

elif [[ $(xrandr | awk '/eDP1/ {print $1}') == "eDP1" ]]; then
	size="600x25+766"
	source ~/.dotfiles/.config/lemonbar/laptop.sh

	while :; do
		echo "%{r}$(wifi) $(battery) %{B$blue}$(volume) $(music) %{B$black}%{r}"
		sleep .1s
	done |

	lemonbar -g $size -f $font -f $icons -B $black -F \#FF$white 2> /dev/null | bash

else
	size=""
fi

