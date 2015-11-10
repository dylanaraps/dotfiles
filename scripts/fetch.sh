#!/bin/bash
# Dylan's screenfetch

## Formatting

# Set to nothing to disable bold text
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
img=$HOME/Pictures/fuuu5.png

# Padding to align text to the right
pad="                      "

## Other

title="Dylan's PC"

## Start printing info

# Clear terminal before running
clear

echo "${pad}${bold}$title${clear}"
echo "${pad}----------"
echo "${pad}${bold}${red}OS:${clear} $(cat /etc/*ease | awk '/^NAME=/' | cut -d '"' -f2)"
echo "${pad}${bold}${red}Kernal:${clear} $(uname -r)"
echo "${pad}${bold}${red}Uptime:${clear} $(uptime -p)"
echo "${pad}${bold}${red}Packages:${clear} $(pacman -Q | wc -l)"
echo "${pad}${bold}${red}Shell:${clear} $SHELL"
echo "${pad}${bold}${red}Window Manager:${clear} $(wmctrl -m | awk '/Name:/ {printf $2}')"
echo "${pad}${bold}${red}Cpu:${clear} $(lscpu | awk '/Model name:/ { s = ""; for (i = 3; i <= NF; i++) s = s $i " "; print s }')${cyan}@${clear} $(lscpu | awk '/CPU MHz:/ {printf "scale=1; " $3 " / 1000 \n"}' | bc -l)GHz"
echo "${pad}${bold}${red}Ram:${clear} $(free -m | awk '/Mem:/ {printf $3 "MB / " $2 "MB"}')"
echo "${pad}${bold}${red}Current Song:${clear} $(mpc current)"
echo
echo -e "0;1;$xoffset;$yoffset;$width;$height;;;;;$img\n4;\n3;" | /usr/lib/w3m/w3mimgdisplay
