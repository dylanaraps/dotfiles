#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# groaw - group, organize and arrange windows (or just a bear behind you)

GROOT=/tmp/groaw.d
GNUMBER=5

usage() {
        echo "$(basename $0) [-h] [-admtu <gid>]"
}

add_to_group() {
        :> $GROOT/$2/$1
        # show_group $2
}

remove_from_group() {
    test "$2" = "all" \
        && rm -f $GROOT/*/$1 \
        || rm -f $GROOT/$2/$1
}

find_group() {
        file=$(find $GROOT -name "$1")
        test -n "$file" && basename $(dirname $file)
}

show_group() {
        for file in $GROOT/$1/*; do
                wid=$(basename $file)
                mapw -m $wid
        done
}

hide_group() {
        for file in $GROOT/$1/*; do
                wid=$(basename $file)
                mapw -u $wid
        done
}

hide_group_all() {
        for file in $GROOT/*/*; do
                wid=$(basename $file)
                mapw -u $wid
        done
}

togg_group() {
    wid=$(ls -1 $GROOT/$1 | sed 1q)

    test -z "$wid" && return
    wattr m $wid \
        && hide_group $1 \
        || show_group $1
}

check_groups_sanity() {
        for gid in $(seq 1 $GNUMBER ); do
                test -d $GROOT/$gid || mkdir -p $GROOT/$gid
        done

        for file in $(find $GROOT -type f); do
                wid=$(basename $file)
                wattr $wid || rm -f $file
        done
}

check_groups_sanity

while getopts ":a:wd:ghm:t:u:U:" opt; do
        case $opt in
                a) add_to_group `pfw` $OPTARG ;;
                d) remove_from_group `pfw` $OPTARG ;;
                g) find_group `pfw` ;;
                m) show_group $OPTARG ;;
                t) togg_group $OPTARG ;;
                u) hide_group $OPTARG ;;
                U) hide_group_all $OPTARG ;;
                *) usage && exit 0;;
        esac
done

# in case no argument is given, display the whole tree
test $# -eq 0 && tree --noreport $GROOT
