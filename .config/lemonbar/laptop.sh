# Battery {{{

battery(){
	upower=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 | awk '/state:/ {print $2}')

	if [[ $upower == "" ]]; then
		batt=""

	elif [[ $upower == "fully-charged" ]]; then
		batt=" Fully Charged"
		echo "%{B$lightblue} $batt "

	elif [[ $upower == "charging" ]]; then
		perc=$(acpi | cut -d, -f2 | sed -e 's/\%* *//g')
		batt=""
		echo "%{B$lightblue} $batt$perc% "

	elif [[ $upower == "discharging" ]]; then
		batt=$(acpi | cut -d, -f2 | sed -e 's/\%* *//g')

		if [[ $batt -gt 75 ]]; then
			echo "%{B$lightblue}  $batt%"

		elif [[ $batt -gt 50 && $batt -lt 76 ]]; then
			echo "%{B$lightblue}  $batt%"

		elif [[ $batt -gt 25 && $batt -lt 50 ]]; then
			echo "%{B$lightblue}  $batt%"

		elif [[ $batt -gt 10 && $batt -lt 50 ]]; then
			echo "%{B$yellow}  $batt%"

		else
			echo "%{B$yellow}  $batt%"
		fi
	fi
}

# }}}

# Wifi {{{

wifi(){
	strength=$(cat /proc/net/wireless | awk '/wlp4s0/ {print $3}' | sed -e 's/\.//g')

	if [[ $strength -gt 75 ]]; then
		echo "%{B$darkgrey}  $strength% "

	elif [[ $strength -gt 50 && $strength -lt 75 ]]; then
		echo "%{B$darkgrey}  $strength% "

	elif [[ $strength -gt 1 && $strength -lt 50 ]]; then
		echo "%{B$darkgrey}  $strength% "

	else
		echo "%{B$black}"
	fi
}

# }}}
