#!/bin/bash
# Script to install/update aur packages

# Options and their default values

# Cower/Makepkg flags
mkflags=(-sicfC --noconfirm)
cowflags="-d"

# aur packages dir
aurdir="$HOME/aur"

# Use cower to get pkgbuilds by default
dl=1

# Error message arrays
cowError=(); makeError=(); pkgCdError=()

# Package array
packages=()

# Script usage
usage () {
    echo "Usage: $(basename $0) -n -U -a [\"aurdir\"] -u [\"package1 package2 package3\"] -m [makepkg flags] -c [cower flags] -M [makepkg flags]"
    echo ""
    echo "-a \"dir/to/store/aur/packages\" : Directory to store aur packages (default \"\$HOME/aur\")"
    echo "    The script won't create this directory, ensure it exists"
    echo ""
    echo "-s \"package1 package2 package3\" : Packages to install/update";
    echo "    Packages must be defined as follows \"cava cower tmux-truecolor\""
    echo "    The quotes are necessary as getopts doesn't allow multi arg options"
    echo ""
    echo "-S  : Update all packages inside of the aur folder"
    echo ""
    echo "-m \"makepkg flags\" : flags to send to makepkg (default: -sicfC)";
    echo "    -m: Overrides the default mkflags"
    echo "    -M: Adds to the default mkflags"
    echo ""
    echo "-c \"cower flags\" : flags to send to cower (default: -d)";
    echo ""
    echo "-n  : Disables the use of cower"
    echo ""
}

# If no options are given, print usage
if [ $# -eq 0 ]; then
    usage
fi

# Set up args
while getopts "a:c:s:Sm:M:n:*" opt 2>/dev/null; do
    case $opt in
        a) aurdir="$OPTARG" ;;
        c) cowflags="$OPTARG" ;;
        s) packages+=($OPTARG) ;;
        S) dl=0; all=1 ;;
        m) mkflags=($OPTARG) ;;
        M) mkflags+=($OPTARG) ;;
        n) dl=0 ;;
        *) usage ;;
    esac
done

# Error message suffix
errsuffix="$(tput setaf 1)ERROR:$(tput sgr0)"

# cd to aur folder
cd "$aurdir" 2>/dev/null || \
{ echo "$errsuffix Failed to cd to aur directory: $aurdir"; exit; }

# Update the packages
if [[ $all == 1 ]]; then
    loop="*"
else
    loop="${packages[@]}"
fi

for pkg in $loop; do
    # If package isn't in aur folder, attempt to download PKGBUILD/etc using cower
    # Use the -n flag to disable this.
    if [ ! -d "$aurdir/$pkg" ] && [ $dl -eq 1 ]; then
        cower "$cowflags" "$pkg" || { cowError+=("$pkg"); continue; }
    fi

    # cd into the package's directory and run makepkg
    cd "$pkg" 2>/dev/null || { pkgCdError+=("$pkg"); continue; }
    makepkg "${mkflags[@]}" || makeError+=("$pkg")
    cd "$aurdir"
done

# Error Handling
if [ ${#cowError[@]} -gt 0 ]; then
    echo -n "$errsuffix Cower failed to download package(s):"
    echo -n "${cowError[*]}" | sed -e 's/\ /\,\ /g'
fi

if [ ${#makeError[@]} -gt 0 ]; then
    echo -n "$errsuffix Makepkg failed to install package(s)"
    echo "${makeError[*]}" | sed -e 's/\ /\,\ /g'
fi

# Doesn't appear often but is useful for packages that have differing name/foldername
if [ ${#pkgCdError[@]} -gt 0 ]; then
    echo -n "$errsuffix Failed to cd to package directory of"
    echo "${pkgCdError[*]}" | sed -e 's/\ /\,\ /g'
fi

# Finally, remove all uneeded build dependencies
sudo pacman -R $(pacman -Qqdt) 2>/dev/null

