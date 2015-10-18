#!/bin/bash

windowtitle(){
	title=$(xdotool getactivewindow getwindowname 2>/dev/null || echo "Hi")
	echo " %{F#$blue}%{F} $title"
}

workspace(){
	query=$(bspc query -D -d)

	case $query in
		1 )
			echo "%{B#$white}%{F#$black}  $ws1  %{F}%{B}%{B#00$black}%{A:bspc desktop -f 2:}  $ws2  %{A}%{B}%{B#00$black}%{A:bspc desktop -f 3:}  $ws3  %{A}%{B}%{B#00$black}%{A:bspc desktop -f 4:}  $ws4  %{A}%{B}" ;;
		2 )
			echo "%{B#00$black}%{A:bspc desktop -f 1:}  $ws1  %{A}%{B}%{B#$white}%{F#$black}  $ws2  %{F}%{B}%{B#00$black}%{A:bspc desktop -f 3:}  $ws3  %{A}%{B}%{B#00$black}%{A:bspc desktop -f 4:}  $ws4  %{A}%{B}" ;;
		3 )
			echo "%{B#00$black}%{A:bspc desktop -f 1:}  $ws1  %{A}%{B}%{B#00$black}%{A:bspc desktop -f 2:}  $ws2  %{A}%{B}%{B#$white}%{F#$black}  $ws3  %{F}%{B}%{B#00$black}%{A:bspc desktop -f 4:}  $ws4  %{A}%{B}" ;;
		4 )
			echo "%{B#00$black}%{A:bspc desktop -f 1:}  $ws1  %{A}%{B}%{B#00$black}%{A:bspc desktop -f 2:}  $ws2  %{A}%{B}%{B#00$black}%{A:bspc desktop -f 3:}  $ws3  %{A}%{B}%{B#$white}%{F#$black}  $ws4  %{F}%{B}" ;;
		* )
			echo "%{B#00$black}%{A:bspc desktop -f 1:}  $ws1  %{A}%{B}%{B#00$black}%{A:bspc desktop -f 2:}  $ws2  %{A}%{B}%{B#00$black}%{A:bspc desktop -f 3:}  $ws3  %{A}%{B}%{B#00$black}%{A:bspc desktop -f 4:}  $ws4  %{A}%{B}" ;;
	esac
}

while :; do
	echo "%{l}%{F#$white}$(workspace)%{F}$(windowtitle)%{l}"
	sleep .03s
done |

orangebar -g "500x$barheight" -f "$barfont" -f "$baricons" -B "#00$black" -F "#$white" 2>/dev/null | bash
