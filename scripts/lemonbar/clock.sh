#!/bin/sh
# Dylan's Lemonbar Clock

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh

while :; do
    echo "       $(neofetch --stdout memory) %{c}$(date "+%a %d %b %l:%M %p")%{r}$(mpc current | cut -c 1-25)      %{r}"
	sleep 2s
done |

lemonbar -b -g "500x33+710+33" -f "-benis-lemon-medium-r-normal--10-110-75-75-m-50-ISO8859-1" -B "#$white" -F "#$gray"

