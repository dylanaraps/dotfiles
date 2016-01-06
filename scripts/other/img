#!/bin/mksh
# Fit images to window size and scale them down if they're latger than screen size
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Get image size and add it to an array
IFS='x'
geometry=($(identify $1 | awk '{printf $3}'))

# Image size
width=${geometry[0]}
height=${geometry[1]}

while [ $height -ge 1080 ] && [ $width -ge 1920 ]; do
    width=$((width / 4))
    height=$((height / 4))
done

feh --zoom fill -. -g "$width"x"$height" $1
