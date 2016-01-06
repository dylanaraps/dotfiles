#!/bin/mksh
# Script to backup specific folders using rsync
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# First notification
popup -e "Backing Up System" -s 10000 &

# Videos

echo "Syncing Family Videos"
rsync -a --delete /home/dyl/Videos/Other/Family /home/dyl/Backup/Videos/Other


# Television

echo "Syncing Avatar The Last Airbender"
rsync -a --delete /home/dyl/Videos/Television/Avatar\ The\ Last\ Airbender /home/dyl/Backup/Videos/Television

echo "Syncing Game of Thrones"
rsync -a --delete /home/dyl/Videos/Television/Game\ of\ Thrones /home/dyl/Backup/Videos/Television

echo "Syncing Silicon Valley"
rsync -a --delete /home/dyl/Videos/Television/Silicon\ Valley /home/dyl/Backup/Videos/Television


# Anime

# Exclude naruto, one piece and yugioh as they're huge and I don't have enough space.
echo "Syncing Anime"
rsync -a --delete --exclude='Naruto Shippuden' --exclude='One Piece' --exclude='yugioh' /home/dyl/Videos/Anime/ /home/dyl/Backup/Videos/Anime


# Music

echo "Syncing Music"
rsync -a --delete /home/dyl/Stuff/Music/ /home/dyl/Backup/Music


# Pictures

echo "Syncing Pictures"
rsync -a --delete /home/dyl/Stuff/Pictures/ /home/dyl/Backup/Pictures


# Games

echo "Syncing CS:GO"
rsync -a --delete /home/dyl/.steam/steam/SteamApps/Common/Counter-Strike\ Global\ Offensive /home/dyl/Backup/Games


echo "Done!"; popup -e "Backup Complete!" -s 5 &
