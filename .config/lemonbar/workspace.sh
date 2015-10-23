#!/bin/bash

windowtitle(){
	title=$(xdotool getactivewindow getwindowname 2>/dev/null || echo "Hi")
	echo " %{F#$white}x> $title%{F}"
}

workspace(){
	query=$(wmctrl -d | grep "*" | cut -d ' ' -f 1)

	case $query in
		0 )
			echo "%{B#$cyan}%{F#$white}  www  %{F}%{B}%{B#$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#$blue}%{A:wmctrl -s 3:}  mus  %{A}%{B}" ;;
		1 )
			echo "%{B#$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#$cyan}%{F#$white}  cmd  %{F}%{B}%{B#$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#$blue}%{A:wmctrl -s 3:}  mus  %{A}%{B}" ;;
		2 )
			echo "%{B#$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#$cyan}%{F#$white}  gam  %{F}%{B}%{B#$blue}%{A:wmctrl -s 3:}  mus  %{A}%{B}" ;;
		3 )
			echo "%{B#$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#$cyan}%{F#$white}  mus  %{F}%{B}" ;;
		* )
			echo "%{B#$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#$blue}%{A:wmctrl -s 3:}  mus  %{A}%{B}" ;;
	esac
}

while :; do
	echo "%{l}%{F#$white}$(workspace) $(windowtitle)%{F}%{l}"
	sleep .03s
done |

orangebar -g "1000x$barheight" -f "lemon-j" -B "#00$black" -F "#$white" 2>/dev/null | bash
