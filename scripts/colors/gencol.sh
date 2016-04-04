#!/bin/mksh
# Grab Xresources colors and ouput them in various formats
# The script is a huge clusterfuck atm, i'm going to rewrite it from scratch
# soon.
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Options

# Directory to store generated files
colordir="$HOME/dotfiles/scripts/colors/output"

# Total number of colors in your palette
# Starts counting from 0
# Supports a value of "8" or "16", anything else and it'll print 9 colors
totalcolors=9

# Name of the colors
colors () {
    # Grab the current terminal colors
    if [ $totalcolors -eq 8 ]; then
        getcolors=$(xrdb -query | grep "\*\.color[0-7]:" | sort --version-sort | cut -f2 | sed -e "s/\#//")
    elif [ $totalcolors -eq 16 ]; then
        getcolors=$(xrdb -query | grep "\*\.color[0-9]*[0-9]:" | sort --version-sort | cut -f2 | sed -e "s/\#//")
    else
        # I print 9 colors as the second black is a dark grey in my schemes
        getcolors=$(xrdb -query | grep "\*\.color[0-8]:" | sort --version-sort | cut -f2 | sed -e "s/\#//")
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

# Used as an include inside of scripts
scripts () {
    colors

    for color in $getcolors; do
        pos=$((pos + 1))
        echo "${colors[$pos]}=$color"
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

# Generate firefox only css variables for my userChrome.css
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

scss () {
    colors

    echo "// Color variables"

    for color in $getcolors; do
        pos=$((pos + 1))
        echo "\$${colors[$pos]}: #$color;"
    done
}

erb () {
    colors

    echo "<%"
    echo -e "\t# Colors"

    for color in $getcolors; do
        pos=$((pos + 1))
        echo -e "\t${colors[$pos]} = [\"\#$color\", $pos, \"${colors[$pos]}\"]"
    done

    echo
}

nvim () {
    colors

    echo

    echo -e "\t\" Neovim Terminal Mode Colors."

    for color in $getcolors; do
        pos=$((pos + 1))
        echo -e "\tlet g:terminal_color_$pos = \"\#$color\""
    done

    echo
    echo "\" }}}"
}

openbox () {
    colors

    # Titlebar colors
    active_titlebg=$(xrdb -query | grep "\*\.color5" | cut -f2)
    inactive_titlebg=$(xrdb -query | grep "\*\.color2:" | cut -f2)
    active_titlefg=$(xrdb -query | grep "\*\.color7:" | cut -f2)
    inactive_titlefg=$(xrdb -query | grep "\*\.color7:" | cut -f2)


    # Menu colors
    menubg=$(xrdb -query | grep "\*\.color7:" | cut -f2)
    menufg=$(xrdb -query | grep "\*\.color8:" | cut -f2)

    echo "# Openbox colors, generated using gencol"
    echo "window.active.title.bg.color: $active_titlebg"
    echo "window.inactive.title.bg.color: $inactive_titlebg"
    echo "window.active.label.text.color: $active_titlefg"
    echo "window.inactive.label.text.color: $inactive_titlefg"
    echo "window.*.button.*.image.color: $active_titlefg"
    echo "menu*.bg.color: $menubg"
    echo "menu*.text.color: $menufg"
    echo "menu.border.color: $menubg"
    echo "menu.separator.color: $menubg"
    echo
}

# Neovim colorscheme
# How it works:  colors.erbvim + theme.erbvim + tui.erbvim > ryuuko.erb
# On launch neovim converts the erb to a vim theme.
erbgen () {
    themedir="$HOME/dotfiles/colorschemes/ryuuko"

    # Combine the three files
    cat "$themedir/gen/colors.erbvim" "$themedir/gen/theme.erbvim" "$themedir/gen/tui.erbvim" > "$themedir/ryuuko.erb"
}

# Generate css
# Use sass to preproccess css
gencss () {
    startpage="$HOME/dotfiles/startpage"
    sassc --style expanded "$startpage/scss/main.scss" "$startpage/main.css"
}

# Generate openbox theme
obthemegen () {
    themedir="$HOME/dotfiles/themes/yellow/openbox-3"
    cat "$themedir/gen/colors.openbox" "$themedir/gen/themerc.openbox" > "$themedir/themerc"

    # Send signal to openbox to reload config files
    killall -USR2 openbox
}

# Reopen lemonbar
bar () {
    pkill clock
    clock &>/dev/null
}

# Generate the colors
all () {
    echo
    echo "Generating color files"
    echo
    envar > "$colordir/colors.envar"; echo "Generated envars"
    scripts > "$colordir/colors.sh"; echo "Generated variables"
    gtk2 > "$colordir/colors.rc"; echo "Generated gtk2 colors"
    css > "$colordir/colors.css"; echo "Generated firefox css vars"
    scss > "$colordir/colors.scss"; echo "Generated Sass variables"
    erb > "$colordir/colors.erbvim"; echo "Generated vim erb vars"
    openbox > "$colordir/colors.openbox"; echo "Generated openbox colors"

    # Nvim uses 16 colors so lets generate all 16
    totalcolors=16
    nvim > "$colordir/tui.erbvim"; echo "Generated neovim tui colors"

    # Other Generation
    echo
    echo "Doing other generation"
    echo
    erbgen; echo "Generated Vim colorscheme template"
    gencss; echo "Generated css file using sass"
    obthemegen; echo "Generated openbox themerc"
    bar & echo "Restarted lemonbar"
}

xrdb "$HOME/.Xresources"
all
