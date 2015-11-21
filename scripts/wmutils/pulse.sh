#!/bin/sh

FREQ=${FREQ:-0.05}
FILE=$BOOTSTRAP/colors

while :; do
    COLORS=$(tac < $FILE | cat - $FILE | tr -d '#')
    for c in $COLORS; do
        CUR=$(pfw)
        test "`wattr wh $CUR`" != "`wattr wh $(lsw -r)`" && chwb -c $c $CUR
        sleep $FREQ
    done
done
