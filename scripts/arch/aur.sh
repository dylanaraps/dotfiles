#!/bin/bash
# Hacked together script to install/update/remove aur packages
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Directory for aur packages and their PKGBUILDS
aurdir="$HOME/aur"

# Makepkg flags
mkflags="-sicfC"

# Install packages
install () {
    cd "$aurdir" || exit

    for pkg in ${packages[@]}; do
        # If package isn't in aur folder, attempt to download PKGBUILD/etc using cower
        if [ ! -d "$pkg" ]; then
            cower -d "$pkg"

            read -p "View PKGBUILD? (y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                $EDITOR "$pkg/PKGBUILD"
            fi
        fi

        # cd into the package's directory and run makepkg
        cd "$pkg" || exit
        makepkg "$mkflags"
        cd "$aurdir"
    done
}

# Remove packages
uninstall () {
    cd "$aurdir" || exit

    for pkg in ${packages[@]}; do
        if [ -d $pkg ]; then
            rm -rf "$pkg" && echo "Removed $aurdir/$pkg"
            sudo pacman -R "$pkg"
        else
            echo "$aurdir/$pkg doesn't exist, exiting"
        fi
    done
}

# Update all aur packages
update_all () {
    cd "$aurdir" || exit

    for pkg in *; do
        # cd into the package's directory and run makepkg
        cd "$pkg" || exit
        makepkg "$mkflags"
        cd "$aurdir"
    done
}

# Set up args
while getopts "S:R:U" opt 2>/dev/null; do
    case $opt in
        S) packages+=($OPTARG); install ;;
        R) packages+=($OPTARG); uninstall ;;
        U) update_all ;;
    esac
done

# Recursively remove uneeded dependencies
sudo pacman -Rns $(pacman -Qtdq) 2>/dev/null || echo "No uneeded dependencies to remove"
