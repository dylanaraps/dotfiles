#!/bin/bash
# Worksapce Switcher
size="430x$barheight"

# Window Title {{{

windowtitle(){
	# Grabs focused window's title
	# The echo "" at the end displays when no windows are focused.
	title=$(xdotool getactivewindow getwindowname 2>/dev/null || echo "Hi")
	echo " %{F#$green}%{F} $title" # Limits the output to a maximum # of chars
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
		-e 's/\*****/%{B#6A9994}  &  %{B}/g' \
		-e 's/\;****/%{B#406080}%{A:bspc desktop -f &:}  &  %{A}%{B}/g' \
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
		%{F#$white2}\
			$(workspace)\
		%{F}\
			$(windowtitle) \
		%{l}\
		"
	sleep .03s
done |

orangebar -u 2 -g $size -f $barfont -f $baricons -B \#00$black -F \#$white 2> /dev/null | bash
