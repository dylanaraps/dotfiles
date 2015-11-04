#!/bin/bash
workspace(){
	query=$(wmctrl -d | grep "*" | cut -d ' ' -f 1)
	focus="~/dotfiles/scripts/openbox/musicfoc.sh"

	case $query in
		0 )
			echo "%{B#$cyan}  www  %{B}%{B#$blue}%{A:$focus 1:}  cmd  %{A}%{B}%{B#$blue}%{A:$focus 2:}  gam  %{A}%{B}%{B#$blue}%{A:$focus 3:}  mus  %{A}%{B}" ;;
		1 )
			echo "%{B#$blue}%{A:$focus 0:}  www  %{A}%{B}%{B#$cyan}  cmd  %{B}%{B#$blue}%{A:$focus 2:}  gam  %{A}%{B}%{B#$blue}%{A:$focus 3:}  mus  %{A}%{B}" ;;
		2 )
			echo "%{B#$blue}%{A:$focus 0:}  www  %{A}%{B}%{B#$blue}%{A:$focus 1:}  cmd  %{A}%{B}%{B#$cyan}  gam  %{B}%{B#$blue}%{A:$focus 3:}  mus  %{A}%{B}" ;;
		3 )
			echo "%{B#$blue}%{A:$focus 0:}  www  %{A}%{B}%{B#$blue}%{A:$focus 1:}  cmd  %{A}%{B}%{B#$blue}%{A:$focus 2:}  gam  %{A}%{B}%{B#$cyan}  mus  %{B}" ;;
		* )
			echo "%{B#$blue}%{A:$focus 0:}  www  %{A}%{B}%{B#$blue}%{A:$focus 1:}  cmd  %{A}%{B}%{B#$blue}%{A:$focus 2:}  gam  %{A}%{B}%{B#$blue}%{A:$focus 3:}  mus  %{A}%{B}" ;;
	esac
}

windowtitle(){
	title=$(xdotool getactivewindow getwindowname | cut -c 1-75)
	echo " x> $title"
}

while :; do
	echo "%{l}$(workspace) $(windowtitle)%{l}"
	sleep .03s
done |

lemonbar -g "1000x$barheight" -f "lemon-j" -f "fontawesome-8" -B "#00$black" -F "#$white" 2>/dev/null | bash
