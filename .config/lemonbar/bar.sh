#!/bin/zsh

# Font Variable
font="envpynforpowerline"

# Variables for the colors
white=FFFFFF
black="#181818"
blue="#7CAFC2"
orange="#DC9656"
purple="#BA8BAF"

clock(){
	# Displays the date "Sun 17 May 9:10 AM"
	date '+%a %d %b %l:%M %p'
}

music(){
	# Displays currently playing mpd song, if nothing is playing it displays "Paused"
	if [[ $(mpc status | awk 'NR==2 {print $1}') == "[playing]" ]]; then
		playing=$(mpc current)
		echo "⭯ $playing" | cut -c 1-50 # Limits the output to a maximum of 50 chars
	else
		echo "⭯ Paused"
	fi
}

memory(){
	# Show free memory  "Free/Total MB"
	free -m | awk '/Mem:/ {print "⭦ " $3, "/ " $2 " MB"}'
}

window(){
	# Grabs focused window's title
	title=$(xdotool getactivewindow getwindowname)
	echo "$title" | cut -c 1-40 # Limits the output to a maximum of 40 chars
}


while :; do
	echo "%{l}%{B$blue}  $(window)  %{l}%{r}%{B$blue}%{A:mpc toggle:}  $(music)  %{A}%{B$purple}  $(memory)  %{B$orange}  ⭧ $(clock)  %{B$black}%{r}"

	# The window functions needs a tiny delay, anything longer and it becomes unresponsive.
	# Having no delay causes the cpu usage to go around 6-10% on my system, the .1s delay brings thar right down.
	sleep .1s
done |

lemonbar -g 1600x28 -f $font -F \#FF$white | zsh
