#!/bin/sh
# Generate colors from .Xresources and export them as environment variables

gencol () {
    colors=(black red green yellow blue orange cyan white darkgray)
    pos="-1"

    for color in $(xrdb -query | awk '/*.color[0-8]:/ {printf $2 "\n"}' | sed -e 's/\#//g'); do
        pos=$(($pos + 1))
        echo "export ${colors[$pos]}=$color"
    done
}

gencol > "$HOME/.colors"

