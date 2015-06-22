#!/bin/bash
# Dylan's Lemonbar
# Feel free to use/edit this script!
# If you manage to improve the script please send a PR

# Kills lemon bar to keep one instance open
# Useful as I'm constantly editing and then reloading this file.
pkill lemonbar

# # Colors
white="FFFFFF"
black="#121212"
darkgrey="#252525"
blue="#85ADD4"
yellow="#d75f87"

# # Fonts
font="-benis-lemon-medium-r-normal--10-110-75-75-m-50-iso8859-1"
icons="-wuncon-sijipatched-medium-r-normal--10-100-75-75-c-80-iso10646-1"

battery(){
	upower=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk '/state:/ {print $2}')

	if [[ $upower == "fully-charged" ]]; then
		batt=" Fully Charged"
		echo "%{B$yellow} $batt"

	elif [[ $upower == "charging" ]]; then
		perc=$(acpi | cut -d, -f2 | sed -e 's/\%* *//g')
		batt=""
		echo "%{B$blue} $batt$perc% "

	elif [[ $upower == "discharging" ]]; then
		batt=$(acpi | cut -d, -f2 | sed -e 's/\%* *//g')

		if [[ $batt -gt 75 ]]; then
			echo "%{B$blue}  $batt%"

		elif [[ $batt -gt 50 && $batt -lt 76 ]]; then
			echo "%{B$blue}  $batt%"

		elif [[ $batt -gt 10 && $batt -lt 50 ]]; then
			echo "%{B$blue}  $batt%"

		else
			echo "%{B$yellow}  $batt%"
		fi
	fi
}

clock(){
	# Displays the date eg "Sun 17 May 9:10 AM"
	date=$(date '+%a %d %b %l:%M %p')
	echo " $date"
}

cpu(){
	cpuusage=$(mpstat | awk '/all/ {print $4 + $6}')
	echo "$cpuusage% Used"
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
		current=$(mpc current)
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

wifi(){
	strength=$(cat /proc/net/wireless | awk '/wlp4s0/ {print $3}' | sed -e 's/\.//g')
	wicd="%{A1:wicd-gtk:}"

	if [[ $strength -gt 75 ]]; then
		echo "%{B$darkgrey}$wicd $strength% %{A}"

	elif [[ $strength -gt 50 && $strength -lt 75 ]]; then
		echo "%{B$darkgrey}$wicd $strength% %{A}"

	elif [[ $strength -gt 1 && $strength -lt 50 ]]; then
		echo "%{B$darkgrey}$wicd $strength% %{A}"

	else
		echo "%{B$black}"
	fi
}

windowtitle(){
	# Grabs focused window's title
	# The echo "" at the end displays when no windows are focused.
	title=$(xdotool getactivewindow getwindowname 2>/dev/null || echo "Hi")
	echo " $title" | cut -c 1-50 # Limits the output to a maximum # of chars
}

workspace(){
	# Workspace switcher for i3 using wmctrl ( Can easily be edited for another wm)
	# Supports icon fonts, words and numbers of any length!
	# Functions exactly like the workspace switcher in i3bar
	# Also supports as many workspaces as your wm can create, you'll need the space to avoid overlapping though.

	# Bug: Click events don't work when the workspace is named (number: word) for some reason. Not sure is it's an i3 issue as the code sent to bar looks fine.
	# Missing: Mode indicator (Resize mode, etc) and I don't think it's possible without using an ipc library.

	# Change "next_on_output" to "next" to cycle between every workspace
	workspacenext="A4:i3-msg workspace next_on_output:"
	workspaceprevious="A5:i3-msg workspace prev_on_output:"

	# This part took hours of trial and error, check the git history of this file!
	# Increase the number of variables in print to have workspaces longer than 12 words in length.
	wslist=$(\
		wmctrl -d \
		| awk '/ / {print $2 $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20}' ORS=''\
		| sed -e 's/\s*  //g' \
		-e 's/\*[ 0-9A-Za-z]*[^ -~]*/%{B#85ADD4}  &  %{B}/g' \
		-e 's/\-[ 0-9A-Za-z]*[^ -~]*/%{B#252525}%{A:i3-msg workspace &:}  &  %{A}%{B}/g' \
		-e 's/\*//g' \
		-e 's/ -/ /g' \
		)

	# Adds the scrollwheel events and displays the switcher
	echo "%{$workspacenext}%{$workspaceprevious}$wslist%{A}%{A}"
}

while :; do
	echo "\
		%{l}\
			$(workspace)\
			%{B$black} $(windowtitle) \
		%{l}\
		%{c}\
			%{B$blue} $(music) \
			%{B$darkgrey} $(volume) \
		%{c}\
		%{r}\
			$(wifi) \
			$(battery) \
			%{B$black} $(clock) \
			%{B$black}\
		%{r}\
		"
	sleep .03s
done |
# Finally, launches bar while piping the above while loop!
# | bash is needed on the end for the click events to work.
lemonbar -g 1366x25 -f $font -f $icons -F \#FF$white | bash
