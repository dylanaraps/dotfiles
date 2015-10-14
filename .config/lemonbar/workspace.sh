#!/bin/bash

windowtitle(){
	title=$(xdotool getactivewindow getwindowname 2>/dev/null || echo "Hi")
	echo " %{F#$cyan}%{F} $title"
}

workspace(){
	query=$(bspc query -D -d)

	case $query in
		$ws1 )
			echo "%{B#B4BCC9}%{F#757B8E}  $ws1  %{F}%{B}%{B#757B8E}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;
		$ws2 )
			echo "%{B#757B8E}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#B4BCC9}%{F#757B8E}  $ws2  %{F}%{B}%{B#757B8E}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;
		$ws3 )
			echo "%{B#757B8E}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#B4BCC9}%{F#757B8E}  $ws3  %{F}%{B}%{B#757B8E}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;
		$ws4 )
			echo "%{B#757B8E}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#B4BCC9}%{F#757B8E}  $ws4  %{F}%{B}" ;;
		hello )
			echo "%{B#757B8E}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;

		5 )
			echo "%{B#757B8E}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;

		6 )
			echo "%{B#757B8E}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;

		7 )
			echo "%{B#757B8E}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;

		8 )
			echo "%{B#757B8E}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;

		9 )
			echo "%{B#757B8E}%{A:bspc desktop -f $ws1:}  $ws1  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws2:}  $ws2  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws3:}  $ws3  %{A}%{B}%{B#757B8E}%{A:bspc desktop -f $ws4:}  $ws4  %{A}%{B}" ;;
	esac
}

while :; do
	echo "%{l}%{F#$white}$(workspace)%{F}$(windowtitle)%{l}"
	sleep .03s
done |

orangebar -g "500x$barheight" -f "$barfont" -f "$baricons" -B "#00$black" -F "#$white" 2>/dev/null | bash
