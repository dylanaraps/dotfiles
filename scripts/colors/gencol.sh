#!/bin/bash
# Grab Xresources colors and ouput them in various formats

# Options

# Directory to store generated files
colordir="$HOME/dotfiles/scripts/colors/output"

# Total number of colors in your palette
totalcolors="8"

# Grab the current terminal colors
getcolors=$(xrdb -query | grep "\*\.color[0-$totalcolors]:" | sort -g | cut -f2 | sed -e "s/\#//")

# Name of the colors
colors () {
    # What to name the colors, you'll have to add to this array depending on your maxcol value
    # The array goes in order of terminal colors, so the first array item is equal to 0 (black) and so on.
    colors=(black red green yellow blue orange cyan white gray add your own names here)

    # Leave this as is.
    pos="-1"
}

# Generate environment vars for use in scripts
envar () {
    colors

    for color in $getcolors; do
        pos=$((pos + 1))
        echo "export ${colors[$pos]}=$color"
    done
}

# Generate gtk2 colors for use in my gtk theme
gtk2 () {
    colors

    for color in $getcolors; do
        pos=$((pos + 1))
        echo "gtk_color_scheme = \"color_${colors[$pos]}:#$color\""
    done

    echo ""
}

# Generate firefox only css variables for my startpage and stylish css
css () {
    colors

    echo "/* Color variables */"
    echo ":root {"

    for color in $getcolors; do
        pos=$((pos + 1))
        echo "    --${colors[$pos]}: #$color;"
    done

    echo "}"
}

# Set up args
while getopts "egcs" opt 2>/dev/null; do
    case $opt in
        e) envar > "$colordir/colors.envar"; echo "Generated envars"   ;;
        g) gtk2 > "$colordir/colors.rc"; echo "Generated gtk2 colors" ;;
        c) css > "$colordir/colors.css"; echo "Generated firefox css vars" ;;
    esac
done
