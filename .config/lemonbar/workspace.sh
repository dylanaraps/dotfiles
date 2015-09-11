#!/bin/bash

windowtitle(){
	title=$(xdotool getactivewindow getwindowname 2>/dev/null || echo "Hi")
	echo " %{F#$cyan}%{F} $title"
}

workspace(){
	query=$(bspc query -D -d)

	case $query in
		$ws1 )
			echo "%{B#6A9994}  $ws1  %{B}%{B#406080}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#406080}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#406080}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;
		$ws2 )
			echo "%{B#406080}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#6A9994}  $ws2  %{B}%{B#406080}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#406080}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;
		$ws3 )
			echo "%{B#406080}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#406080}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#6A9994}  $ws3  %{B}%{B#406080}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;
		$ws4 )
			echo "%{B#406080}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#406080}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#406080}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#6A9994}  $ws4  %{B}" ;;
		hello )
			echo "%{B#406080}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#406080}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#406080}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#406080}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;
	esac
}

while :; do
	echo "%{l}%{F#$white2}$(workspace)%{F}$(windowtitle)%{l}"
	sleep .03s
done |

orangebar -g "430x$barheight" -f "$barfont" -f "$baricons" -B "#00$black" -F "#$white" 2>/dev/null | bash
