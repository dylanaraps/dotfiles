#!/bin/mksh
# Prints terminal colors as blocks in a line
#
# Usage: colors2.sh startcol endcol
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Start and end color
start=0
end=7

printcols () {
    while [ "$start" -le "$end" ]; do
        echo -n "\033[48;5;${start}m      "
        start=$((start + 1))

        # Split the blocks at 8 colors
        if [ "$end" -ge "8" ]; then
            [ $start -eq 8 ] && echo -e "\033[0m"
        fi
    done

    # clear formatting
    echo -n "\033[0m"
}

[ ! -z $1 ] && start=$1
[ ! -z $2 ] && end=$2

printcols
echo
