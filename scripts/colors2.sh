#!/bin/sh
# Dylan's Color script
# Prints terminal colors with hex colors side by side
# Only works with terminals that use .Xdefaults/.Xresources

number="0"

echo ""

# This echo is outside of the for loop to manually set it's text color
for color in $( xrdb -query | awk '/*.color[1-8]:/ {print $2}' ); do
    number=$((number + 1))
    echo -n "$(tput setaf "$number")$(tput smso)       $(tput sgr0)"
done

echo ""
echo ""
