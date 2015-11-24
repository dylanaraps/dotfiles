#!/bin/sh
# Dylan's music bar

while :; do
    # If song title + artist is longer than 30 chars, only show song title
	if [[ $(mpc status | grep -o "\[paused\]") == "[paused]" ]]; then
        playing="Paused"
    elif [[ $(mpc current | wc -c) -gt 30 ]]; then
        playing=$(mpc current -f %title% | cut -c 1-30)
    else
        playing=$(mpc current)
    fi

	echo "%{c}%{A:mpc toggle:}%{A4:mpc next:}%{A5:mpc prev:} $playing %{A}%{A}%{A}%{c}"

	mpc idle player update >/dev/null
done |

lemonbar -d -g "200x30+1450+1015" -f "drift" -B "#$white" -F "#$black" | sh
