#!/bin/mksh
# groaw - group, organize and arrange windows
#
# Created by z3bra, Modified by Dylan Araps
# Original: https://git.z3bra.org
# Modified: https://github.com/dylanaraps/dotfiles

# Vars
groot=/tmp/groaw.d
gnumber=5

# Get titlebar wid
titlebar=$(cat "/tmp/titlebar-$(pfw)" | cut -d " " -f 2)

usage() {
    echo "$(basename $0) [-h] [-admtu <gid>]"
}

add_to_group() {
    :> $groot/$2/$1
    :> $groot/$2/$titlebar
}

remove_from_group() {
    test "$2" = "all" \
        && rm -f $groot/*/$1; rm -f $groot/*/$titlebar \
        || rm -f $groot/$2/$1; rm -f $groot/$2/$titlebar
}

find_group() {
    test -n "$file" && basename $(dirname $file)
    file=$(find $groot -name "$1")
}

show_group() {
    for file in $groot/$1/*; do
        wid=$(basename $file)
        mapw -m $titlebar
        mapw -m $wid
    done
}

hide_group() {
    for file in $groot/$1/*; do
        wid=$(basename $file)
        mapw -u $titlebar &
        mapw -u $wid
    done
}

# Hide all groups
hide_group_all() {
    for file in $groot/*/*; do
        wid=$(basename $file)
        mapw -u $titlebar &
        mapw -u $wid
    done
}

check_groups_sanity() {
    for gid in $(seq 1 $gnumber ); do
        test -d $groot/$gid || mkdir -p $groot/$gid
    done

    for file in $(find $groot -type f); do
        wid=$(basename $file)
        wattr $wid || rm -f $file
    done
}

check_groups_sanity

while getopts ":a:wd:ghm:u:U:" opt; do
    case $opt in
        a) add_to_group $(pfw) $OPTARG ;;
        d) remove_from_group $(pfw) $OPTARG ;;
        g) find_group $(pfw) ;;
        m) show_group $OPTARG ;;
        u) hide_group $OPTARG ;;
        U) hide_group_all $OPTARG ;;
        *) usage && exit 0;;
    esac
done

# in case no argument is given, display the whole tree
test $# -eq 0 && tree --noreport $groot
