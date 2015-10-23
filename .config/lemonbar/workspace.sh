#!/bin/bash

windowtitle(){
	title=$(xdotool getactivewindow getwindowname 2>/dev/null || echo "Hi")
	echo " %{F#$white}>$title%{F}"
}

workspace(){
	query=$(wmctrl -d | grep "*" | cut -d ' ' -f 1)

	case $query in
		0 )
			echo "%{B#00$cyan}%{F#$white}  WWW  %{F}%{B}%{B#00$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#00$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#00$blue}%{A:wmctrl -s 3:}  mus  %{A}%{B}" ;;
		1 )
			echo "%{B#00$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#00$cyan}%{F#$white}  CMD  %{F}%{B}%{B#00$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#00$blue}%{A:wmctrl -s 3:}  mus  %{A}%{B}" ;;
		2 )
			echo "%{B#00$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#00$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#00$cyan}%{F#$white}  GAM  %{F}%{B}%{B#00$blue}%{A:wmctrl -s 3:}  mus  %{A}%{B}" ;;
		3 )
			echo "%{B#00$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#00$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#00$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#00$cyan}%{F#$white}  MUS  %{F}%{B}" ;;
		* )
			echo "%{B#00$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#00$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#00$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#00$blue}%{A:wmctrl -s 3:}  mus  %{A}%{B}" ;;
	esac
}

while :; do
	echo "%{l}%{F#$white}$(workspace)%{F}%{l}"
	sleep .03s
done |

orangebar -d -g "500x$barheight" -f "$barfont" -f "$baricons" -B "#00$black" -F "#$white" 2>/dev/null | bash
