#!/bin/bash
# Dylan's Color script
# Prints terminal colors with hex colors side by side
# Only works with terminals that use .Xdefaults/.Xresources

number="0"

# Echo on it's own prints a newline
echo

# This echo is outside of the for loop to manually set it's text color
echo "$(tput setaf 0)$(tput smso)       $(tput sgr0)$(tput setaf 8) $( xrdb -query | awk '/*.color0:/ {print $2}' )"

for i in $( xrdb -query | awk '/*.color[1-7]:/ {print $2}' ); do
    number=$((number + 1))
    echo "$(tput setaf "$number")$(tput smso)       $(tput sgr0)$(tput setaf "$number") $i"
done

echo
