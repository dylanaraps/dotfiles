#!/bin/sh
# Dylan's Lemonbar Clock

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh

battery () {
    battery="$(</sys/class/power_supply/BAT1/capacity)"
    charging="$(</sys/class/power_supply/BAT1/status)"

    case "$battery" in
        [0-9]|10)
            battery="${battery}%  "
        ;;

        1[0-9]|2[0-5])
            battery="${battery}%  "
        ;;

        2[6-9]|3[0-9]|4[0-9]|50)
            battery="${battery}%  "
        ;;

        5[1-9]|6[0-9]|7[0-5])
            battery="${battery}%  "
        ;;

        7[6-9]|8[0-9]|9[0-9]|100)
            battery="${battery}%  "
        ;;
    esac

    [ "$charging" == "Charging" ] && \
        battery="Charging  $battery"

    printf "%s" "$battery"
}

while :; do
    echo "       $(fetch --stdout memory) %{c}$(date "+%a %d %b %l:%M %p")%{r}$(battery)     %{r}"
	sleep 2s
done |

lemonbar -d -b -g "1000x75+1100+50" -f "roboto-16" -o 0 -f "fontawesome-18" -o -2 -B "#$white" -F "#$gray"
