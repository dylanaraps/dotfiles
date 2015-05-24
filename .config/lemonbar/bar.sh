#!/bin/zsh
# Dylan's Lemonbar

# Kills lemon bar to keep one instance open
# Useful as I'm constantly editing and then reloading this file.
pkill lemonbar

# Colors
white="FFFFFF"
black="#181818"
darkgrey="#282828"
green="#8F9D6A"

# Fonts
font="Lemon"
icons="Sijipatched"

clock(){
	# Displays the date eg "Sun 17 May 9:10 AM"
	date=$(date '+%a %d %b %l:%M %p')
	echo " $date"
}

# cpu(){
# 	cpuusage=$(mpstat | awk '/all/ {print $4 + $6}')
# 	echo "$cpuusage % Used"
# }

focustitle(){
	# Grabs focused window's title
	title=$(xdotool getactivewindow getwindowname 2>/dev/null || echo "Hi")
	echo "$title" | cut -c 1-50 # Limits the output to a maximum # of chars
}

memory(){
	# Show free memory
	free -m | awk '/Mem:/ {print " " $3" MB Used "}'
}

music(){
	musictoggle="A:mpc toggle:"
	musicnext="A4:mpc next:"
	musicprevious="A5:mpc prev:"

	# Displays currently playing mpd song, if nothing is playing it displays "Paused"
	if [[ $(mpc status | awk 'NR==2 {print $1}') == "[playing]" ]]; then
		current=$(mpc current | cut -c 1-50) # Limits the output to a maximum of 50 chars
		playing=$(echo " $current")
	else
		playing=$(echo " Paused")
	fi

	echo "%{$musictoggle}%{$musicnext}%{$musicprevious} $playing %{A}%{A}%{A}"
}

volume(){
	volup="A4:amixer set Master 5%+:"
	voldown="A5:amixer set Master 5%-:"
	volmute="A:amixer set Master toggle:"

	# Volume Indicator
	if [[ $(amixer get Master | awk '/Mono:/ {print $6}') == "[off]" ]]; then
		vol=$(echo " Mute")
	else
		mastervol=$(amixer get Master | egrep -o '[0-9]{1,3}%' | sed -e 's/%//')
		vol=$(echo " $mastervol")
	fi

	echo "%{$volup}%{$voldown}%{$volmute} $vol %{A}%{A}%{A}"
}

workspace(){
	# Fully functional workspace switcher for i3 using wmctrl/i3-msg (Can easily be edited to work with any wm) by Dylan Araps.
	# Works with an infinite number of workspaces of infinite character lengths (999999999999)
	# Works with named workspaces up to 11 words long. (can include any amount of chars just limited word-wise)
	# Works with icon fonts
	# Bug: Click events don't work when the workspace is named (number: word) for some reason. Not sure is it's an i3 issue as the code sent to bar looks fine.
	# Only thing missing is the status indicator (Resize mode indicator) and I'm working on it.
	workspacenext="A4:i3-msg workspace next_on_output:"
	workspaceprevious="A5:i3-msg workspace prev_on_output:"

	wslist=$(\
		wmctrl -d \
		| awk '/ / {print $2 $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20}' ORS=''\
		| sed -e 's/\s*  //g' \
		      -e 's/\*[ 0-9A-Za-z]*[^ -~]*/%{B#8F9D6A}  &  %{B}/g' \
		      -e 's/\-[ 0-9A-Za-z]*[^ -~]*/%{B#323537}%{A:i3-msg workspace &:}  &  %{A}%{B}/g' \
		      -e 's/\*//g' \
		      -e 's/ -/ /g' \
	)

	# Space infront of $wslist is needed to center the output.
	echo "%{$workspacenext}%{$workspaceprevious}$wslist%{A}%{A}"
}

while :; do
	# Every line below is a different "Block" on the bar. I've laid it out this way so that it's easier to edit and to see what's going on.
	echo\
		"%{l}\
			$(workspace)\
			%{B$black} $(focustitle) \
		%{l}\
		%{c}\
			%{B$green} $(music) \
			%{B$darkgrey} $(volume) \
		%{c}\
		%{r}\
			%{B$darkgrey} $(memory) \
			%{B$black} $(clock) \
			%{B$black}\
		%{r}"
	sleep .03s
done |

# Finally, launches bar while piping the above while loop!
# | zsh is needed on the end for the click events to work.
lemonbar -g 1600x25 -f $font -f $icons -F \#FF$white | zsh
