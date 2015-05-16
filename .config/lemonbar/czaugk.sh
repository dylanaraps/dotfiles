#!/bin/zsh

BLACK="#181818"
BLUE="#7CAFC2"
ORANGE="#DC9656"
PURPLE="#BA8BAF"

clk(){
	date '+%a %d %b %H:%M'
}

mpd(){
	if [[ $(mpc status | awk 'NR==2 {print $1}') == "[playing]" ]]; then
		TTL=$(mpc current)
		echo "♫ $TTL"
	else
		echo "♫ Paused"
	fi
}

mem(){
	free -m | awk '/Mem:/ {print "⭦ " $3, "/ " $2 " MB"}'
}

xtitle -s | while read window; do
		echo "%{l}%{B$BLUE}  $window  %{l}%{r}%{B$BLUE}  $(mpd)  %{B$PURPLE}  $(mem)  %{B$ORANGE}  ⭧ $(clk)  %{B$BLACK}%{r}"

done

