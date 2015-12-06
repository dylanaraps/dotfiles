#!/bin/sh
# Dylan's transmission popup script
# Displays a notification when transmission finishes downloading a torrent.

# Notification Texy
text=$(echo "Finished Downloading: $TR_TORRENT_NAME" | cut -c 1-50)

popup.sh -e "$text" -s 5 -w $(txtw "$text") -x $((1820 - $(txtw "$text")))
