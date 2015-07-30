#!/bin/bash
# Worksapce Switcher

# Variables {{{

source ~/.dotfiles/.config/lemonbar/variables.sh

if [[ $(xrandr | awk '/DFP10/ {print $1}') == "DFP10" ]]; then
	size="430x$height"

elif [[ $(xrandr | awk '/eDP1/ {print $1}') == "eDP1" ]]; then
	size="430x$height"

else
	size=""
fi

# }}}

# Window Title {{{

windowtitle(){
	# Grabs focused window's title
	# The echo "" at the end displays when no windows are focused.
	title=$(xdotool getactivewindow getwindowname 2>/dev/null || echo "Hi")
	echo " $title" | cut -c 1-50 # Limits the output to a maximum # of chars
}

# }}}

# Workspace Switcher {{{

workspace(){
	# Workspace switcher using wmctrl
	workspacenext="A4:bspc desktop -f next:"
	workspaceprevious="A5:bspc desktop -f prev:"

	wslist=$(\
		wmctrl -d \
		| awk '/[a-z]$/ {printf $2 $9}'\
		| sed -e 's/\-/\;/g' \
		-e 's/\*[a-z]*/%{B#FF459CAB}  &  %{B}/g' \
		-e 's/\;[a-z]*/%{B#1C1C1C}%{A:bspc desktop -f &:}  &  %{A}%{B}/g' \
		-e 's/\*//g' \
		-e 's/ \;/ /g'\
		)

	# Adds the scrollwheel events and displays the switcher
	echo "%{$workspacenext}%{$workspaceprevious}$wslist%{A}%{A}"
}

# }}}

while :; do
	echo "\
		%{l}\
			$(workspace)\
			%{B$black} $(windowtitle) \
		%{l}\
		"
	sleep .03s
done |

lemonbar -g $size -f $font -f $icons -B \#FF$black -F \#FF$white 2> /dev/null | bash
