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
	echo "%{F$blue}%{F} $title" # Limits the output to a maximum # of chars
}

# }}}

# Workspace Switcher {{{

workspace(){
	# Workspace switcher using wmctrl
	workspacenext="A4:bspc desktop -f next:"
	workspaceprevious="A5:bspc desktop -f prev:"

	wslist=$(\
		wmctrl -d \
		| awk '/ / {printf $2 $9}'\
		| sed -e 's/\-/\;/g' \
		-e 's/.Desktop2//g' \
		-e 's/\*****/%{+u} & %{-u} /g' \
		-e 's/\;****/%{A:bspc desktop -f &:} & %{A} /g' \
		-e 's/\*//g' \
		-e 's/\ ;/ /g'\
		)

	# Adds the scrollwheel events and displays the switcher
	echo "%{$workspacenext}%{$workspaceprevious}$wslist%{A}%{A}"
}

# }}}

while :; do
	echo "\
		%{l}\
		%{U$blue}\
			$(workspace)\
			%{B$black} $(windowtitle) \
		%{U}\
		%{l}\
		"
	sleep .03s
done |

orangebar -u 2 -g $size -f $font -f $icons -B \#00$bg -F $fg 2> /dev/null | bash
