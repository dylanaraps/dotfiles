#!/bin/bash
# Get current artist/song

song="$(cmus-remote -Q | grep "tag artist\|title")"
song=${song/tag artist }
song=${song/tag title/-}
song=${song//[[:space:]]/ }

echo "$song"
