#!/bin/sh
# Dylan's Lemonbar Clock

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh

battery () {
    battery="$(fetch --stdout battery)"
    num=${battery/\%*}
    case "$num" in
        [0-9]|10)
            battery="${battery}"
        ;;

        1[0-9]|2[0-5])
            battery="${battery}"
        ;;

        2[0-6]|3[0-9]|4[0-9]|50)
            battery="${battery}"
        ;;

        5[0-9]|6[0-9]|7[0-5])
            battery="${battery}"
        ;;

        7[0-6]|8[0-9]|9[0-9]|100)
            battery="${battery}"
        ;;
    esac
    printf "%s" "$battery"
}

while :; do
    echo "   $(battery) %{c}$(date "+%a %d %b %l:%M %p")%{c}"
	sleep 1s
done |

lemonbar -b -g "1000x75+1100+50" -f "roboto-16" -f "fontawesome-18" -B "#$white" -F "#$gray"
