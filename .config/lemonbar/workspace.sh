#!/bin/bash
# Worksapce Switcher

# Variables {{{

white="FFFFFF"
black="1C1C1C"
darkgrey="#FF252525"
blue="#BB459CAB"
lightblue="#BB61AAB5"
yellow="#BBFABD2F"

font="-benis-lemon-medium-r-normal--10-110-75-75-m-50-iso8859-1"
icons="-wuncon-sijipatched-medium-r-normal--10-100-75-75-c-80-iso10646-1"

if [[ $(xrandr | awk '/DFP10/ {print $1}') == "DFP10" ]]; then
	size="430x25"

elif [[ $(xrandr | awk '/eDP1/ {print $1}') == "eDP1" ]]; then
	size="430x25"

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
		-e 's/\*[a-z]*/%{B#BB458588}  &  %{B}/g' \
		-e 's/\;[a-z]*/%{B#001C1C1C}%{A:bspc desktop -f &:}  &  %{A}%{B}/g' \
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

lemonbar -g $size -f $font -f $icons -B \#00$black -F \#FF$white 2> /dev/null | bash
