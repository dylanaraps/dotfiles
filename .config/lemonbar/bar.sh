#!/bin/zsh
# Bar is launched by piping a seperate script into it.
# ~/.cofnig/lemonbar/output.sh | ~/.config/lemonbar/bar.sh

fg=FFFFFF
font="envypn\ for\ powerline"

lemonbar -g 1600x28 -f $font -F \#FF$fg
