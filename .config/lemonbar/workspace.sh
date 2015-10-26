#!/bin/bash

windowtitle(){
	title=$(xdotool getactivewindow getwindowname 2>/dev/null)
	echo " x> $title"
}

workspace(){
	query=$(wmctrl -d | grep "*" | cut -d ' ' -f 1)

	case $query in
		0 )
			echo "%{B#$cyan}  www  %{B}%{B#$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#$blue}%{A:~/dotfiles/scripts/openbox/musicfoc.sh:}  mus  %{A}%{B}" ;;
		1 )
			echo "%{B#$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#$cyan}  cmd  %{B}%{B#$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#$blue}%{A:~/dotfiles/scripts/openbox/musicfoc.sh:}  mus  %{A}%{B}" ;;
		2 )
			echo "%{B#$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#$cyan}  gam  %{B}%{B#$blue}%{A:~/dotfiles/scripts/openbox/musicfoc.sh:}  mus  %{A}%{B}" ;;
		3 )
			echo "%{B#$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#$cyan}  mus  %{B}" ;;
		* )
			echo "%{B#$blue}%{A:wmctrl -s 0:}  www  %{A}%{B}%{B#$blue}%{A:wmctrl -s 1:}  cmd  %{A}%{B}%{B#$blue}%{A:wmctrl -s 2:}  gam  %{A}%{B}%{B#$blue}%{A:~/dotfiles/scripts/openbox/musicfoc.sh:}  mus  %{A}%{B}" ;;
	esac
}

while :; do
	echo "%{l}$(workspace) $(windowtitle)%{l}"
	sleep .03s
done |

orangebar -g "1000x$barheight" -f "lemon-j" -B "#00$black" -F "#$white" 2>/dev/null | bash
