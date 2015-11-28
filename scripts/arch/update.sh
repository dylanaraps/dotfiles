#!/bin/bash
# script to update aur packages

makepkg="makepkg -sicfC"
pkgdir="$HOME/aur"

# Error arrays
cowerError=()
makeError=()
cdError=()

# Use arguments 1-9 as package names
packages=($1 $2 $3 $4 $5 $6 $7 $8 $9)

# If $1 is empty, update all packages
if [ -z "$1" ]; then
    pkg="*"
else
    pkg=${packages[@]}
fi

# Update the packages
for package in $pkgdir/$pkg; do
    cd "$pkgdir/$(basename "$package")" 2>/dev/null || { cdError+=("$(basename "$package")"); continue; }
    $makepkg || makeError+=("$(basename "$package")")
    cd "$pkgdir" || exit
done

# Error Handling
errsuffix="$(tput bold)$(tput setaf 1)==> ERROR:$(tput sgr0)"

if [ ${#cowerError[@]} -gt 0 ]; then
    echo -n "$errsuffix Couldn't find package(s) $(tput bold)"
    echo -n "${cowerError[*]}$(tput sgr0)" | sed -e 's/\ /\,\ /g'
    echo " in the aur"
fi

if [ ${#makeError[@]} -gt 0 ]; then
    echo -n "$errsuffix Failed to install $(tput bold)"
    echo "${makeError[*]}$(tput sgr0)" | sed -e 's/\ /\,\ /g'
fi

if [ ${#cdError[@]} -gt 0 ]; then
    echo -n "$errsuffix Failed to find package(s) $(tput bold)"
    echo "${cdError[*]}$(tput sgr0)" | sed -e 's/\ /\,\ /g'
fi


