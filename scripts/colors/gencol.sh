#!/bin/bash
# Grab Xresources colors and ouput them in various formats

# Options

# Directory to store generated files
colordir="$HOME/dotfiles/scripts/colors/output"

# Total number of colors in your palette
# Starts counting from 0
# Supports a value of "8" or "16"
totalcolors=8

# Name of the colors
colors () {
    # Grab the current terminal colors
    if [[ $totalcolors == 8 ]]; then
        getcolors=$(xrdb -query | grep "\*\.color[0-8]:" | sort --version-sort | cut -f2 | sed -e "s/\#//")
    else
        getcolors=$(xrdb -query | grep "\*\.color[0-9]*[0-4]:" | sort --version-sort | cut -f2 | sed -e "s/\#//")
    fi
    # What to name the colors.
    # Goes in order of 0-15
    colors=(black red green yellow blue orange cyan white gray red2 green2 yellow2 blue2 orange2 cyan2 white2)

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
while getopts "negcs" opt 2>/dev/null; do
    case $opt in
        # The -n flag must come first for it to work
        n) totalcolors=16; echo "Using 16 colors" ;;
        e) envar > "$colordir/colors.envar"; echo "Generated envars"   ;;
        g) gtk2 > "$colordir/colors.rc"; echo "Generated gtk2 colors" ;;
        c) css > "$colordir/colors.css"; echo "Generated firefox css vars" ;;
    esac
done
