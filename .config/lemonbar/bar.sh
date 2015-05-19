#!/bin/zsh

# Colors
white=FFFFFF

black="#181818"
blue="#7CAFC2"
orange="#DC9656"
purple="#BA8BAF"

# Fonts
font="envpynforpowerline"
icons="-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1"

clock(){
	# Displays the date "Sun 17 May 9:10 AM"
	date=$(date '+%a %d %b %l:%M %p')
	echo " $date"
}

memory(){
	# Show free memory  "Free/Total MB"
	free -m | awk '/Mem:/ {print " " $3, "/ " $2 " MB"}'
}

music(){
	musictoggle="A:mpc toggle:"

	# Displays currently playing mpd song, if nothing is playing it displays "Paused"
	if [[ $(mpc status | awk 'NR==2 {print $1}') == "[playing]" ]]; then
		playing=$(mpc current | cut -c 1-50) # Limits the output to a maximum of 50 chars
	else
		playing=$(echo "Paused")
	fi

	echo "%{$musictoggle}  $playing %{A}"
}

volume(){
	volup="A4:amixer set Master 5%+:"
	voldown="A5:amixer set Master 5%-:"
	volmute="A:amixer set Master toggle:"

	if [[ $(amixer get Master | awk '/Mono:/ {print $6}') == "[off]" ]]; then
		vol=$(echo "Mute")
	else
		vol=$(amixer get Master | egrep -o '[0-9]{1,3}%' | sed -e 's/%//')
	fi

	echo "%{$volup}%{$voldown}%{$volmute} $vol %{A}%{A}%{A}"
}

window(){
	# Grabs focused window's title
	title=$(xdotool getactivewindow getwindowname)
	echo "$title" | cut -c 1-40 # Limits the output to a maximum of 40 chars
}


while :; do
	# Every line below is a different "Block" on the bar. I've laid it out this way so that it's easier to edit and to see what's going on.
	echo\
		"%{l}\
			%{B$blue} $(window) \
		%{l}\
		%{r}\
			%{B$blue} $(music) \
			%{B$purple} $(volume) \
			%{B$orange} $(clock) \
			%{B$black}\
		%{r}"
	sleep .05s
done |

# | zsh is needed on the end for the click events to work.
lemonbar -g 1600x25 -f $font -f $icons -F \#FF$white | zsh
