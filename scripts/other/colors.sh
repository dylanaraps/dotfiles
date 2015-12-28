#!/bin/mksh
# Prints terminal colors with hex colors side by side
# Only works with terminals that use .Xdefaults/.Xresources
#
# Dependencies: tput, terminal emu that uses Xresources/Xdefaults
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Add linebreak above colors
echo

eight () {
    number=-1

    for color in $(xrdb -query | awk '/*.color[0-7]:/ {print $2}'); do
        number=$((number + 1))

        if [ $number -eq 0 ]; then
            echo "$(tput setaf "$number")$(tput smso)       $(tput sgr0)$(tput setaf 8) $color"
        else
            echo "$(tput setaf "$number")$(tput smso)       $(tput sgr0)$(tput setaf "$number") $color"
        fi
    done
}

nine () {
    number=-1

    for color in $(xrdb -query | awk '/*.color[0-8]:/ {print $2}'); do
        number=$((number + 1))

        if [ $number -eq 0 ]; then
            echo "$(tput setaf "$number")$(tput smso)       $(tput sgr0)$(tput setaf 8) $color"
        else
            echo "$(tput setaf "$number")$(tput smso)       $(tput sgr0)$(tput setaf "$number") $color"
        fi
    done
}

sixteen () {
    number=-1

    # Add the hex colors to an array
    colors=($(xrdb -query | grep "\*\.color[0-9]*[0-9]:" | sort --version-sort | cut -f2))

    while [ $number -lt 7 ]; do
        number=$((number + 1))

        if [ $number -eq 0 ]; then
            echo -n "$(tput setaf $number)$(tput smso)       $(tput sgr0)$(tput setaf $((number + 8))) ${colors[$number]}"
            echo " $(tput setaf $((number + 8)))$(tput smso)       $(tput sgr0)$(tput setaf $((number + 8))) ${colors[$((number + 8))]}"
        else
            echo -n "$(tput setaf $number)$(tput smso)       $(tput sgr0)$(tput setaf $number) ${colors[$number]}"
            echo " $(tput setaf $((number + 8)))$(tput smso)       $(tput sgr0)$(tput setaf $((number + 8))) ${colors[$((number + 8))]}"
        fi
    done
}

case $1 in
    8) eight ;;
    9) nine ;;
    16) sixteen ;;
esac

# Add linebreak below colors
echo
