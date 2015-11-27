#!/bin/bash
# Dylan's screenfetch script

## Formatting

# Set to nothing to disable bold/underline text
bold=$(tput bold)
underline=$(tput smul)

# Clears attributes
clear=$(tput sgr0)

## Text Colors

color="tput setaf"
black="$($color 0)"
red="$($color 1)"
green="$($color 2)"
yellow="$($color 3)"
blue="$($color 4)"
orange="$($color 5)"
cyan="$($color 6)"
white="$($color 7)"
gray="$($color 8)"

## Custom Image

width=120
height=120
yoffset=0
xoffset=0

# Comment out these two lines below to disable the image
img=$HOME/Pictures/fetch.jpg

# Padding to align text to the right
pad="                      "

## Other

title="Dylan's PC"

## Start printing info

# Clear terminal before running
clear

echo "${pad}${bold}$title${clear}"
echo "${pad}----------"
echo "${pad}${bold}${green}OS:${clear} $(cat /etc/*ease | awk '/^NAME=/' | cut -d '"' -f2)"
echo "${pad}${bold}${green}Kernal:${clear} $(uname -r)"
echo "${pad}${bold}${green}Uptime:${clear} $(uptime -p)"
echo "${pad}${bold}${green}Packages:${clear} $(pacman -Q | wc -l)"
echo "${pad}${bold}${green}Shell:${clear} $SHELL"
echo "${pad}${bold}${green}Window Manager:${clear} wmutils"
echo "${pad}${bold}${green}Cpu:${clear} AMD FX-6300 ${cyan}@${clear} $(lscpu | awk '/CPU MHz:/ {printf "scale=1; " $3 " / 1000 \n"}' | bc -l)GHz"
echo "${pad}${bold}${green}Ram:${clear} $(free -m | awk '/Mem:/ {printf $3 "MB / " $2 "MB"}')"
echo "${pad}${bold}${green}Current Song:${clear} $(mpc current | cut -c 1-25)"
echo
echo -e "0;1;$xoffset;$yoffset;$width;$height;;;;;$img\n4;\n3;" | /usr/lib/w3m/w3mimgdisplay
