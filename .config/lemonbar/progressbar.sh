#!/bin/zsh
# Dylan's Lemonbar

# Colors
white="DDFFFFFF"
black="#00181818"

# Fonts
font="Lemon"
icons="Sijipatched"

progressbar(){
	if [[ $(mpc status | awk 'NR==2 {print $1}') == "[playing]" ]]; then
		# Grabs the percentage from mpc status
		progress=$(mpc status | awk '/playing/ {print $4}' | sed -r 's/\)*\(*\%*//g')

		# Prints the bar
		pbar=$(printf "%-${progress}c" "") #

		# Echooooooo
		echo "${pbar//     /}"

	else
		echo ""
	fi
}

while :; do
	# Every line below is a different "Block" on the bar. I've laid it out this way so that it's easier to edit and to see what's going on.
	echo "%{B$black}$(progressbar)"
done |

# Finally, launches bar while piping the above while loop!
# | zsh is needed on the end for the click events to work.
lemonbar -g 250x5+675+25 -o -4 -d -f $font -f $icons -F \#FF$white | zsh
