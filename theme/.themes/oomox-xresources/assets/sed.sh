#!/bin/sh
sed -i \
         -e 's/#FBFCF8/rgb(0%,0%,0%)/g' \
         -e 's/#3E463F/rgb(100%,100%,100%)/g' \
    -e 's/#3E463F/rgb(50%,0%,0%)/g' \
     -e 's/#9EA3A1/rgb(0%,50%,0%)/g' \
     -e 's/#FBFCF8/rgb(50%,0%,50%)/g' \
     -e 's/#3E463F/rgb(0%,0%,50%)/g' \
	$@
