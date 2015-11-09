#!/bin/bash
# Dylan's lemonbar workspace script

# Variables that don't need to be in the loop.
focus="~/dotfiles/scripts/openbox/musicfoc.sh"
bg=$red
bgfoc=$cyan

startbutton() {
	echo "%{A:~/dotfiles/scripts/openbox/startbutton.sh:}    %{A}"
}

workspace() {
    query=$(wmctrl -d | awk '/\*/ {printf $1}')

	case $query in
		0 )
			echo "%{B#$bgfoc}  www  %{B}%{B#$bg}%{A:$focus 1:}  cmd  %{A}%{B}%{B#$bg}%{A:$focus 2:}  gam  %{A}%{B}%{B#$bg}%{A:$focus 3:}  mus  %{A}%{B}" ;;
		1 )
			echo "%{B#$bg}%{A:$focus 0:}  www  %{A}%{B}%{B#$bgfoc}  cmd  %{B}%{B#$bg}%{A:$focus 2:}  gam  %{A}%{B}%{B#$bg}%{A:$focus 3:}  mus  %{A}%{B}" ;;
		2 )
			echo "%{B#$bg}%{A:$focus 0:}  www  %{A}%{B}%{B#$bg}%{A:$focus 1:}  cmd  %{A}%{B}%{B#$bgfoc}  gam  %{B}%{B#$bg}%{A:$focus 3:}  mus  %{A}%{B}" ;;
		3 )
			echo "%{B#$bg}%{A:$focus 0:}  www  %{A}%{B}%{B#$bg}%{A:$focus 1:}  cmd  %{A}%{B}%{B#$bg}%{A:$focus 2:}  gam  %{A}%{B}%{B#$bgfoc}  mus  %{B}" ;;
		* )
			echo "%{B#$bg}%{A:$focus 0:}  www  %{A}%{B}%{B#$bg}%{A:$focus 1:}  cmd  %{A}%{B}%{B#$bg}%{A:$focus 2:}  gam  %{A}%{B}%{B#$bg}%{A:$focus 3:}  mus  %{A}%{B}" ;;
	esac
}

windowtitle() {
	title=$(xdotool getactivewindow getwindowname | cut -c 1-75)
	echo "%{F#$white}  $title%{F}"
}

while :; do
	echo "$(startbutton)$(workspace) $(windowtitle)"
	sleep .03s
done |

lemonbar -g "970x$barheight" -f "drift" -f "xbmicons" -B "#00$black" -F "#$white" 2>/dev/null | bash
